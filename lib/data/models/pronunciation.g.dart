// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronunciation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Syllable _$SyllableFromJson(Map<String, dynamic> json) => _Syllable(
  syllable: json['syllable'] as String,
  initial: json['initial'] as String,
  finalPart: json['finalPart'] as String,
  tones: (json['tones'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(int.parse(k), e as String),
  ),
);

Map<String, dynamic> _$SyllableToJson(_Syllable instance) => <String, dynamic>{
  'syllable': instance.syllable,
  'initial': instance.initial,
  'finalPart': instance.finalPart,
  'tones': instance.tones.map((k, e) => MapEntry(k.toString(), e)),
};

_TonePairWord _$TonePairWordFromJson(Map<String, dynamic> json) =>
    _TonePairWord(
      hanzi: json['hanzi'] as String,
      pinyin: json['pinyin'] as String,
      vi: json['vi'] as String,
    );

Map<String, dynamic> _$TonePairWordToJson(_TonePairWord instance) =>
    <String, dynamic>{
      'hanzi': instance.hanzi,
      'pinyin': instance.pinyin,
      'vi': instance.vi,
    };

_ConfusableGroup _$ConfusableGroupFromJson(Map<String, dynamic> json) =>
    _ConfusableGroup(
      id: json['id'] as String,
      title: json['title'] as String,
      tipVi: json['tipVi'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$ConfusableGroupToJson(_ConfusableGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tipVi': instance.tipVi,
      'items': instance.items,
    };

_PronunciationDrills _$PronunciationDrillsFromJson(Map<String, dynamic> json) =>
    _PronunciationDrills(
      tonePairs: (json['tonePairs'] as List<dynamic>)
          .map((e) => TonePairWord.fromJson(e as Map<String, dynamic>))
          .toList(),
      confusables: (json['confusables'] as List<dynamic>)
          .map((e) => ConfusableGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PronunciationDrillsToJson(
  _PronunciationDrills instance,
) => <String, dynamic>{
  'tonePairs': instance.tonePairs,
  'confusables': instance.confusables,
};
