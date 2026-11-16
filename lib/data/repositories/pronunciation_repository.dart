import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/pronunciation.dart';

/// Dữ liệu luyện phát âm (chỉ đọc, nằm trong assets/pronunciation).
/// Dữ liệu nhỏ và không gắn với tiến độ nên đọc thẳng từ asset, không qua DB.
class PronunciationRepository {
  PronunciationRepository([AssetBundle? bundle]) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;
  static const _dir = 'assets/pronunciation';

  PinyinChart? _chart;
  PronunciationDrills? _drills;

  Future<PinyinChart> chart() async {
    if (_chart != null) return _chart!;
    final json = jsonDecode(await _bundle.loadString('$_dir/syllables.json'))
        as Map<String, dynamic>;
    return _chart = PinyinChart(
      initials: (json['initials'] as List).cast<String>(),
      finals: (json['finals'] as List).cast<String>(),
      syllables: [
        for (final s in json['syllables'] as List)
          Syllable.fromJson(s as Map<String, dynamic>),
      ],
    );
  }

  Future<PronunciationDrills> drills() async => _drills ??=
      PronunciationDrills.fromJson(
        jsonDecode(await _bundle.loadString('$_dir/drills.json'))
            as Map<String, dynamic>,
      );

}
