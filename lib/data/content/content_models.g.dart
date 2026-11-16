// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExampleSentence _$ExampleSentenceFromJson(Map<String, dynamic> json) =>
    _ExampleSentence(
      hanzi: json['hanzi'] as String,
      pinyin: json['pinyin'] as String,
      vi: json['vi'] as String,
    );

Map<String, dynamic> _$ExampleSentenceToJson(_ExampleSentence instance) =>
    <String, dynamic>{
      'hanzi': instance.hanzi,
      'pinyin': instance.pinyin,
      'vi': instance.vi,
    };

_WordContent _$WordContentFromJson(Map<String, dynamic> json) => _WordContent(
  id: json['id'] as String,
  hanzi: json['hanzi'] as String,
  pinyin: json['pinyin'] as String,
  hanViet: json['hanViet'] as String,
  meaningVi: json['meaningVi'] as String,
  lessonId: json['lessonId'] as String,
  mustWrite: json['mustWrite'] as bool? ?? false,
  audio: json['audio'] as String?,
  examples:
      (json['examples'] as List<dynamic>?)
          ?.map((e) => ExampleSentence.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ExampleSentence>[],
);

Map<String, dynamic> _$WordContentToJson(_WordContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hanzi': instance.hanzi,
      'pinyin': instance.pinyin,
      'hanViet': instance.hanViet,
      'meaningVi': instance.meaningVi,
      'lessonId': instance.lessonId,
      'mustWrite': instance.mustWrite,
      'audio': instance.audio,
      'examples': instance.examples,
    };

_LessonContent _$LessonContentFromJson(Map<String, dynamic> json) =>
    _LessonContent(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
    );

Map<String, dynamic> _$LessonContentToJson(_LessonContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'subtitle': instance.subtitle,
    };

_GrammarContent _$GrammarContentFromJson(Map<String, dynamic> json) =>
    _GrammarContent(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      title: json['title'] as String,
      pattern: json['pattern'] as String,
      explanationVi: json['explanationVi'] as String,
      examples:
          (json['examples'] as List<dynamic>?)
              ?.map((e) => ExampleSentence.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExampleSentence>[],
    );

Map<String, dynamic> _$GrammarContentToJson(_GrammarContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'title': instance.title,
      'pattern': instance.pattern,
      'explanationVi': instance.explanationVi,
      'examples': instance.examples,
    };
