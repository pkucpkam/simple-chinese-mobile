import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/data/content/content_importer.dart';
import 'package:simple_chinese/data/content/content_models.dart';
import 'package:simple_chinese/data/content/content_source.dart';
import 'package:simple_chinese/data/db/app_database.dart';
import 'package:simple_chinese/data/repositories/word_repository.dart';

/// Nguồn nội dung trong bộ nhớ để test.
class FakeSource implements ContentSource {
  final Map<String, Map<ContentKind, String>> packs = {};

  void put(String pack, ContentKind kind, Map<String, dynamic> json) =>
      (packs[pack] ??= {})[kind] = jsonEncode(json);

  @override
  Future<List<String>> listPacks() async => packs.keys.toList()..sort();

  @override
  Future<String?> read(String pack, ContentKind kind) async => packs[pack]?[kind];
}

/// Đọc file thật trong assets/content từ ổ đĩa.
class DiskSource implements ContentSource {
  @override
  Future<List<String>> listPacks() async => Directory('assets/content')
      .listSync()
      .whereType<Directory>()
      .map((d) => d.uri.pathSegments.where((s) => s.isNotEmpty).last)
      .toList();

  @override
  Future<String?> read(String pack, ContentKind kind) async {
    final f = File('assets/content/$pack/${kind.fileName}');
    return f.existsSync() ? f.readAsString() : null;
  }
}

Map<String, dynamic> wordsFile(int version, List<Map<String, dynamic>> items) =>
    {'contentVersion': version, 'level': 1, 'items': items};

Map<String, dynamic> word(String id, String hanzi, String pinyin,
        {String meaning = 'nghĩa'}) =>
    {
      'id': id,
      'hanzi': hanzi,
      'pinyin': pinyin,
      'hanViet': 'hv',
      'meaningVi': meaning,
      'lessonId': 'hsk1-l01',
      'examples': [
        {'hanzi': '$hanzi。', 'pinyin': '$pinyin.', 'vi': 'ví dụ'},
      ],
    };

void main() {
  late AppDatabase db;
  late FakeSource source;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    source = FakeSource();
  });
  tearDown(() => db.close());

  test('import lần đầu ghi words + version', () async {
    source.put('hsk1', ContentKind.words, wordsFile(1, [
      word('w1', '你', 'nǐ'),
      word('w2', '好', 'hǎo'),
    ]));

    final report = await ContentImporter(db, source).run();

    expect(report.imported, ['hsk1/words']);
    final rows = await db.select(db.words).get();
    expect(rows, hasLength(2));
    expect(rows.first.pinyinPlain, 'ni');
    expect(rows.first.level, 1);

    final w = await WordRepository(db).watchWord('w1').first;
    expect(w!.examples.single.vi, 'ví dụ');
  });

  test('cùng version thì bỏ qua', () async {
    source.put('hsk1', ContentKind.words, wordsFile(1, [word('w1', '你', 'nǐ')]));
    await ContentImporter(db, source).run();

    final second = await ContentImporter(db, source).run();
    expect(second.imported, isEmpty);
    expect(second.upToDate, ['hsk1/words']);
  });

  test('tăng contentVersion: cập nhật nội dung, KHÔNG mất tiến độ', () async {
    source.put('hsk1', ContentKind.words, wordsFile(1, [
      word('w1', '你', 'nǐ', meaning: 'cũ'),
      word('w2', '好', 'hǎo'),
    ]));
    await ContentImporter(db, source).run();

    // Người học đã có thẻ + lịch sử ôn + tiến độ bài.
    final cardId = await db.into(db.cards).insert(CardsCompanion.insert(
          wordId: 'w1',
          skill: CardSkill.read,
          due: DateTime(2030),
          stability: const Value(12.5),
          reps: const Value(3),
        ));
    await db.into(db.reviewLogs).insert(ReviewLogsCompanion.insert(
          cardId: cardId,
          rating: 3,
          reviewedAt: DateTime(2026),
        ));
    await db.into(db.lessonProgress).insert(LessonProgressCompanion.insert(
          lessonId: 'hsk1-l01',
          bestScore: const Value(90),
        ));

    // Phiên bản 2: sửa nghĩa w1, bỏ w2, thêm w3.
    source.put('hsk1', ContentKind.words, wordsFile(2, [
      word('w1', '你', 'nǐ', meaning: 'mới'),
      word('w3', '我', 'wǒ'),
    ]));
    final report = await ContentImporter(db, source).run();
    expect(report.imported, ['hsk1/words']);

    final words = {for (final w in await db.select(db.words).get()) w.id: w};
    expect(words.keys, unorderedEquals(['w1', 'w3']));
    expect(words['w1']!.meaningVi, 'mới');

    final card = await db.select(db.cards).getSingle();
    expect(card.stability, 12.5);
    expect(card.reps, 3);
    expect(await db.select(db.reviewLogs).get(), hasLength(1));
    expect((await db.select(db.lessonProgress).getSingle()).bestScore, 90);

    final version = await db.select(db.contentVersions).getSingle();
    expect(version.version, 2);
  });

  test('nhiều pack độc lập (thêm hsk2 không cần sửa code)', () async {
    source.put('hsk1', ContentKind.words, wordsFile(1, [word('a', '你', 'nǐ')]));
    source.put('hsk2', ContentKind.words, {
      'contentVersion': 1,
      'level': 2,
      'items': [word('b', '再', 'zài')],
    });
    source.put('hsk2', ContentKind.lessons, {
      'contentVersion': 1,
      'level': 2,
      'items': [
        {'id': 'hsk2-l01', 'order': 1, 'title': 'Bài 1', 'dialogue': []},
      ],
    });

    final report = await ContentImporter(db, source).run();
    expect(report.imported,
        containsAll(['hsk1/words', 'hsk2/words', 'hsk2/lessons']));

    final hsk2 = await (db.select(db.words)..where((t) => t.level.equals(2))).get();
    expect(hsk2.single.id, 'b');
    final lesson = await db.select(db.lessons).getSingle();
    expect(jsonDecode(lesson.contentJson)['dialogue'], isEmpty);
  });

  test('file thiếu contentVersion → lỗi rõ ràng', () async {
    source.packs['hsk1'] = {ContentKind.words: jsonEncode({'items': []})};
    expect(() => ContentImporter(db, source).run(), throwsFormatException);
  });

  test('nội dung thật trong assets hợp lệ và import được', () async {
    final report = await ContentImporter(db, DiskSource()).run();
    expect(report.imported,
        containsAll(['hsk1/words', 'hsk1/lessons', 'hsk1/grammar']));

    final words = await db.select(db.words).get();
    expect(words, hasLength(30));
    expect(words.map((w) => w.id).toSet(), hasLength(30), reason: 'id trùng');

    final lessonIds = (await db.select(db.lessons).get()).map((l) => l.id).toSet();
    for (final w in words) {
      expect(lessonIds, contains(w.lessonId), reason: '${w.id} trỏ bài không tồn tại');
      expect(w.hanViet, isNotEmpty);
      expect(w.meaningVi, isNotEmpty);
      // Số âm tiết pinyin phải bằng số chữ Hán (quy ước tách âm tiết).
      expect(w.pinyin.split(' ').length, w.hanzi.runes.length, reason: w.id);
    }
  });
}
