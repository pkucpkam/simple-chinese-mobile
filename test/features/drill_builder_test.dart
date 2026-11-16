import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/core/pinyin/pinyin.dart';
import 'package:simple_chinese/data/models/pronunciation.dart';
import 'package:simple_chinese/features/pronunciation/drill/drill_builder.dart';

void main() {
  // Dùng dữ liệu thật trong assets để đồng thời kiểm tra file dữ liệu.
  final chartJson = jsonDecode(
      File('assets/pronunciation/syllables.json').readAsStringSync()) as Map<String, dynamic>;
  final chart = PinyinChart(
    initials: (chartJson['initials'] as List).cast<String>(),
    finals: (chartJson['finals'] as List).cast<String>(),
    syllables: [
      for (final s in chartJson['syllables'] as List)
        Syllable.fromJson(s as Map<String, dynamic>),
    ],
  );
  final drills = PronunciationDrills.fromJson(jsonDecode(
      File('assets/pronunciation/drills.json').readAsStringSync()) as Map<String, dynamic>);
  final builder = DrillBuilder(random: Random(7));

  group('dữ liệu phát âm', () {
    test('bảng pinyin có các ô quen thuộc', () {
      expect(chart.cell('m', 'a')!.tones, {1: '妈', 2: '麻', 3: '马', 4: '骂'});
      expect(chart.cell('n', 'ü')!.syllable, 'nü');
      expect(chart.cell('j', 'ü')!.syllable, 'ju');
      expect(chart.cell('', 'ü')!.syllable, 'yu');
      expect(chart.cell('', 'uo')!.syllable, 'wo');
      expect(chart.hanziFor('lv3'), '旅');
      expect(chart.hanziFor('zhi4'), isNotNull);
      expect(chart.hanziFor('xyz1'), isNull);
    });

    test('mọi âm tiết trong bài âm dễ nhầm đều có chữ để phát âm', () {
      for (final g in drills.confusables) {
        for (final item in g.items) {
          for (final n in item) {
            expect(chart.hanziFor(n), isNotNull, reason: '${g.id}: $n');
          }
        }
      }
    });

    test('từ luyện cặp thanh có đúng 2 âm tiết, khớp số chữ', () {
      for (final w in drills.tonePairs) {
        expect(splitSyllables(w.pinyin), hasLength(2), reason: w.hanzi);
        expect(w.hanzi.runes.length, 2, reason: w.hanzi);
      }
    });
  });

  group('DrillBuilder', () {
    test('tones: 10 câu, đáp án đúng khớp chữ được phát', () {
      final qs = builder.tones(chart);
      expect(qs, hasLength(10));
      for (final q in qs) {
        expect(q.options, hasLength(4));
        final tone = q.answer + 1;
        // Âm tiết có thanh đúng phải là âm có chữ đại diện == chữ được phát.
        final syl = chart.syllables.firstWhere(
            (s) => syllableToMarked(s.syllable, tone) == q.options[q.answer]);
        expect(syl.tones[tone], q.speak);
      }
    });

    test('tonePairs: đáp án là pinyin gốc', () {
      final qs = builder.tonePairs(drills.tonePairs);
      expect(qs, hasLength(10));
      for (final q in qs) {
        final w = drills.tonePairs.firstWhere((w) => w.hanzi == q.speak);
        expect(q.options[q.answer], w.pinyin);
        expect(q.options.toSet(), hasLength(q.options.length));
      }
    });

    test('confusables: phương án là các âm trong cặp', () {
      final g = drills.confusables.firstWhere((g) => g.id == 'z_zh');
      final qs = builder.confusables(g, chart.hanziFor);
      expect(qs, hasLength(10));
      for (final q in qs) {
        expect(q.options, hasLength(2));
        expect(q.speak, isNotEmpty);
      }
    });

    test('DrillKind.parse ↔ code', () {
      for (final k in [const ToneDrill(), const TonePairDrill(), const ConfusableDrill('n_ng')]) {
        expect(DrillKind.parse(k.code).code, k.code);
      }
    });
  });
}
