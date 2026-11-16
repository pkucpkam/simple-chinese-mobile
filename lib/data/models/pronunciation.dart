import 'package:freezed_annotation/freezed_annotation.dart';

part 'pronunciation.freezed.dart';
part 'pronunciation.g.dart';

/// Một ô trong bảng pinyin: âm tiết + chữ đại diện cho từng thanh.
@freezed
abstract class Syllable with _$Syllable {
  const Syllable._();

  const factory Syllable({
    /// Cách viết không dấu: "zhang", "nü", "yue".
    required String syllable,

    /// Thanh mẫu ("" nếu không có).
    required String initial,

    /// Vận mẫu gốc theo bảng ("ü", "iu", "ui"...).
    required String finalPart,

    /// Thanh (1..4) → chữ Hán đại diện để phát âm.
    required Map<int, String> tones,
  }) = _Syllable;

  factory Syllable.fromJson(Map<String, dynamic> json) => Syllable(
        syllable: json['syllable'] as String,
        initial: json['initial'] as String,
        finalPart: json['final'] as String,
        tones: {
          for (final e in (json['tones'] as Map<String, dynamic>).entries)
            int.parse(e.key): e.value as String,
        },
      );

  List<int> get availableTones => tones.keys.toList()..sort();
}

/// Bảng pinyin: danh sách thanh mẫu (cột), vận mẫu (hàng) và các ô có thật.
class PinyinChart {
  PinyinChart({
    required this.initials,
    required this.finals,
    required this.syllables,
  })  : _index = {for (final s in syllables) (s.initial, s.finalPart): s},
        _bySpelling = {for (final s in syllables) s.syllable: s};

  final List<String> initials;
  final List<String> finals;
  final List<Syllable> syllables;
  final Map<(String, String), Syllable> _index;
  final Map<String, Syllable> _bySpelling;

  /// Tra ô theo (thanh mẫu, vận mẫu); null nếu tổ hợp không tồn tại.
  Syllable? cell(String initial, String finalPart) => _index[(initial, finalPart)];

  /// Tra theo cách viết: "zhang", "lü" (chấp nhận "lv").
  Syllable? bySpelling(String s) => _bySpelling[s.replaceAll('v', 'ü')];

  /// Chữ đại diện cho âm tiết dạng số: "zhi4" → "志", "lv3" → "旅".
  /// Null nếu tổ hợp không có trong bảng.
  String? hanziFor(String numbered) {
    final m = RegExp(r'^([a-zA-ZüÜ:]+)([1-4])$').firstMatch(numbered.trim());
    if (m == null) return null;
    final spelling = m.group(1)!.toLowerCase().replaceAll('u:', 'ü');
    return bySpelling(spelling)?.tones[int.parse(m.group(2)!)];
  }
}

/// Từ hai âm tiết dùng để luyện cặp thanh.
@freezed
abstract class TonePairWord with _$TonePairWord {
  const factory TonePairWord({
    required String hanzi,
    required String pinyin,
    required String vi,
  }) = _TonePairWord;

  factory TonePairWord.fromJson(Map<String, dynamic> json) =>
      _$TonePairWordFromJson(json);
}

/// Nhóm âm dễ nhầm, vd z/zh. Mỗi item là 2-3 âm tiết dạng số ("zi4", "zhi4").
@freezed
abstract class ConfusableGroup with _$ConfusableGroup {
  const factory ConfusableGroup({
    required String id,
    required String title,
    required String tipVi,
    required List<List<String>> items,
  }) = _ConfusableGroup;

  factory ConfusableGroup.fromJson(Map<String, dynamic> json) =>
      _$ConfusableGroupFromJson(json);
}

@freezed
abstract class PronunciationDrills with _$PronunciationDrills {
  const factory PronunciationDrills({
    required List<TonePairWord> tonePairs,
    required List<ConfusableGroup> confusables,
  }) = _PronunciationDrills;

  factory PronunciationDrills.fromJson(Map<String, dynamic> json) =>
      _$PronunciationDrillsFromJson(json);
}
