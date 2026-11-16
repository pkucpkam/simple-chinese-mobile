// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DialogueLine _$DialogueLineFromJson(Map<String, dynamic> json) =>
    _DialogueLine(
      speaker: json['speaker'] as String,
      hanzi: json['hanzi'] as String,
      pinyin: json['pinyin'] as String,
      vi: json['vi'] as String,
    );

Map<String, dynamic> _$DialogueLineToJson(_DialogueLine instance) =>
    <String, dynamic>{
      'speaker': instance.speaker,
      'hanzi': instance.hanzi,
      'pinyin': instance.pinyin,
      'vi': instance.vi,
    };

_OrderSentence _$OrderSentenceFromJson(Map<String, dynamic> json) =>
    _OrderSentence(
      tokens: (json['tokens'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      vi: json['vi'] as String,
    );

Map<String, dynamic> _$OrderSentenceToJson(_OrderSentence instance) =>
    <String, dynamic>{'tokens': instance.tokens, 'vi': instance.vi};
