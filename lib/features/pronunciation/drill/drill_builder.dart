import 'dart:math';

import '../../../core/pinyin/pinyin.dart';
import '../../../data/models/pronunciation.dart';

/// Loại bài luyện nghe.
sealed class DrillKind {
  const DrillKind();

  /// Mã dùng trong URL: "tones", "pairs", "conf-z_zh".
  String get code;

  static DrillKind parse(String code) => switch (code) {
        'tones' => const ToneDrill(),
        'pairs' => const TonePairDrill(),
        _ when code.startsWith('conf-') => ConfusableDrill(code.substring(5)),
        _ => throw ArgumentError('Loại bài không hợp lệ: $code'),
      };
}

final class ToneDrill extends DrillKind {
  const ToneDrill();
  @override
  String get code => 'tones';
}

final class TonePairDrill extends DrillKind {
  const TonePairDrill();
  @override
  String get code => 'pairs';
}

final class ConfusableDrill extends DrillKind {
  const ConfusableDrill(this.groupId);
  final String groupId;
  @override
  String get code => 'conf-$groupId';
}

/// Một câu hỏi nghe: phát [speak] rồi chọn đúng phương án trong [options].
class DrillQuestion {
  const DrillQuestion({
    required this.speak,
    required this.options,
    required this.answer,
    this.meaning,
  });

  /// Chữ Hán đưa cho TTS đọc (cũng là gợi ý khi máy không phát được âm).
  final String speak;

  /// Các phương án, dạng pinyin có dấu.
  final List<String> options;

  /// Chỉ số đáp án đúng trong [options].
  final int answer;

  /// Nghĩa tiếng Việt (nếu có) để hiện sau khi trả lời.
  final String? meaning;
}

/// Sinh câu hỏi luyện nghe. Hàm thuần, truyền [random] cố định để test.
class DrillBuilder {
  DrillBuilder({Random? random}) : _r = random ?? Random();

  final Random _r;

  /// Nghe một âm tiết → chọn thanh. Chỉ lấy âm tiết có ≥ 3 thanh để 4
  /// phương án đều là âm có thật hoặc gần như có thật.
  List<DrillQuestion> tones(PinyinChart chart, {int count = 10}) {
    final pool = chart.syllables.where((s) => s.tones.length >= 3).toList()..shuffle(_r);
    return [
      for (final s in pool.take(count))
        () {
          final tones = s.availableTones;
          final tone = tones[_r.nextInt(tones.length)];
          final options = [for (var t = 1; t <= 4; t++) syllableToMarked(s.syllable, t)];
          return DrillQuestion(
            speak: s.tones[tone]!,
            options: options,
            answer: tone - 1,
          );
        }(),
    ];
  }

  /// Nghe từ hai âm tiết → chọn đúng cặp thanh trong 4 phương án.
  List<DrillQuestion> tonePairs(List<TonePairWord> words, {int count = 10}) {
    final pool = List.of(words)..shuffle(_r);
    return [
      for (final w in pool.take(count))
        () {
          final options = toneVariants(w.pinyin, _r.nextInt);
          return DrillQuestion(
            speak: w.hanzi,
            options: options,
            answer: options.indexOf(w.pinyin),
            meaning: w.vi,
          );
        }(),
    ];
  }

  /// Âm dễ nhầm: phát một âm trong cặp/bộ ba, chọn đúng âm đã nghe.
  /// [resolve] tra chữ đại diện cho âm tiết dạng số (null nếu không có).
  List<DrillQuestion> confusables(
    ConfusableGroup group,
    String? Function(String numbered) resolve, {
    int count = 10,
  }) {
    final usable = [
      for (final item in group.items)
        if (item.every((n) => resolve(n) != null)) item,
    ];
    if (usable.isEmpty) return const [];
    return List.generate(count, (_) {
      final item = usable[_r.nextInt(usable.length)];
      final target = _r.nextInt(item.length);
      return DrillQuestion(
        speak: resolve(item[target])!,
        options: [for (final n in item) numberedToMarked(n)],
        answer: target,
      );
    });
  }
}
