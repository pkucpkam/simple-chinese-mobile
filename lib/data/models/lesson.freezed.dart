// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonSummary {

 String get id; int get level; int get order; String get title; String get subtitle;
/// Create a copy of LessonSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonSummaryCopyWith<LessonSummary> get copyWith => _$LessonSummaryCopyWithImpl<LessonSummary>(this as LessonSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.level, level) || other.level == level)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,id,level,order,title,subtitle);

@override
String toString() {
  return 'LessonSummary(id: $id, level: $level, order: $order, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $LessonSummaryCopyWith<$Res>  {
  factory $LessonSummaryCopyWith(LessonSummary value, $Res Function(LessonSummary) _then) = _$LessonSummaryCopyWithImpl;
@useResult
$Res call({
 String id, int level, int order, String title, String subtitle
});




}
/// @nodoc
class _$LessonSummaryCopyWithImpl<$Res>
    implements $LessonSummaryCopyWith<$Res> {
  _$LessonSummaryCopyWithImpl(this._self, this._then);

  final LessonSummary _self;
  final $Res Function(LessonSummary) _then;

/// Create a copy of LessonSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? level = null,Object? order = null,Object? title = null,Object? subtitle = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonSummary].
extension LessonSummaryPatterns on LessonSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonSummary value)  $default,){
final _that = this;
switch (_that) {
case _LessonSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonSummary value)?  $default,){
final _that = this;
switch (_that) {
case _LessonSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int level,  int order,  String title,  String subtitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonSummary() when $default != null:
return $default(_that.id,_that.level,_that.order,_that.title,_that.subtitle);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int level,  int order,  String title,  String subtitle)  $default,) {final _that = this;
switch (_that) {
case _LessonSummary():
return $default(_that.id,_that.level,_that.order,_that.title,_that.subtitle);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int level,  int order,  String title,  String subtitle)?  $default,) {final _that = this;
switch (_that) {
case _LessonSummary() when $default != null:
return $default(_that.id,_that.level,_that.order,_that.title,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc


class _LessonSummary implements LessonSummary {
  const _LessonSummary({required this.id, required this.level, required this.order, required this.title, this.subtitle = ''});
  

@override final  String id;
@override final  int level;
@override final  int order;
@override final  String title;
@override@JsonKey() final  String subtitle;

/// Create a copy of LessonSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonSummaryCopyWith<_LessonSummary> get copyWith => __$LessonSummaryCopyWithImpl<_LessonSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.level, level) || other.level == level)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,id,level,order,title,subtitle);

@override
String toString() {
  return 'LessonSummary(id: $id, level: $level, order: $order, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$LessonSummaryCopyWith<$Res> implements $LessonSummaryCopyWith<$Res> {
  factory _$LessonSummaryCopyWith(_LessonSummary value, $Res Function(_LessonSummary) _then) = __$LessonSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, int level, int order, String title, String subtitle
});




}
/// @nodoc
class __$LessonSummaryCopyWithImpl<$Res>
    implements _$LessonSummaryCopyWith<$Res> {
  __$LessonSummaryCopyWithImpl(this._self, this._then);

  final _LessonSummary _self;
  final $Res Function(_LessonSummary) _then;

/// Create a copy of LessonSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? level = null,Object? order = null,Object? title = null,Object? subtitle = null,}) {
  return _then(_LessonSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LessonNode {

 LessonSummary get lesson; int get wordCount; int get bestScore; DateTime? get completedAt;/// Bài đầu tiên luôn mở; bài sau mở khi bài trước đạt [kPassScore].
 bool get unlocked;
/// Create a copy of LessonNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonNodeCopyWith<LessonNode> get copyWith => _$LessonNodeCopyWithImpl<LessonNode>(this as LessonNode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonNode&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked));
}


@override
int get hashCode => Object.hash(runtimeType,lesson,wordCount,bestScore,completedAt,unlocked);

@override
String toString() {
  return 'LessonNode(lesson: $lesson, wordCount: $wordCount, bestScore: $bestScore, completedAt: $completedAt, unlocked: $unlocked)';
}


}

/// @nodoc
abstract mixin class $LessonNodeCopyWith<$Res>  {
  factory $LessonNodeCopyWith(LessonNode value, $Res Function(LessonNode) _then) = _$LessonNodeCopyWithImpl;
@useResult
$Res call({
 LessonSummary lesson, int wordCount, int bestScore, DateTime? completedAt, bool unlocked
});


$LessonSummaryCopyWith<$Res> get lesson;

}
/// @nodoc
class _$LessonNodeCopyWithImpl<$Res>
    implements $LessonNodeCopyWith<$Res> {
  _$LessonNodeCopyWithImpl(this._self, this._then);

  final LessonNode _self;
  final $Res Function(LessonNode) _then;

/// Create a copy of LessonNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lesson = null,Object? wordCount = null,Object? bestScore = null,Object? completedAt = freezed,Object? unlocked = null,}) {
  return _then(_self.copyWith(
lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as LessonSummary,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LessonNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonSummaryCopyWith<$Res> get lesson {
  
  return $LessonSummaryCopyWith<$Res>(_self.lesson, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}
}


/// Adds pattern-matching-related methods to [LessonNode].
extension LessonNodePatterns on LessonNode {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonNode() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonNode value)  $default,){
final _that = this;
switch (_that) {
case _LessonNode():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonNode value)?  $default,){
final _that = this;
switch (_that) {
case _LessonNode() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LessonSummary lesson,  int wordCount,  int bestScore,  DateTime? completedAt,  bool unlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonNode() when $default != null:
return $default(_that.lesson,_that.wordCount,_that.bestScore,_that.completedAt,_that.unlocked);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LessonSummary lesson,  int wordCount,  int bestScore,  DateTime? completedAt,  bool unlocked)  $default,) {final _that = this;
switch (_that) {
case _LessonNode():
return $default(_that.lesson,_that.wordCount,_that.bestScore,_that.completedAt,_that.unlocked);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LessonSummary lesson,  int wordCount,  int bestScore,  DateTime? completedAt,  bool unlocked)?  $default,) {final _that = this;
switch (_that) {
case _LessonNode() when $default != null:
return $default(_that.lesson,_that.wordCount,_that.bestScore,_that.completedAt,_that.unlocked);case _:
  return null;

}
}

}

/// @nodoc


class _LessonNode extends LessonNode {
  const _LessonNode({required this.lesson, required this.wordCount, this.bestScore = 0, this.completedAt, required this.unlocked}): super._();
  

@override final  LessonSummary lesson;
@override final  int wordCount;
@override@JsonKey() final  int bestScore;
@override final  DateTime? completedAt;
/// Bài đầu tiên luôn mở; bài sau mở khi bài trước đạt [kPassScore].
@override final  bool unlocked;

/// Create a copy of LessonNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonNodeCopyWith<_LessonNode> get copyWith => __$LessonNodeCopyWithImpl<_LessonNode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonNode&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.bestScore, bestScore) || other.bestScore == bestScore)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked));
}


@override
int get hashCode => Object.hash(runtimeType,lesson,wordCount,bestScore,completedAt,unlocked);

@override
String toString() {
  return 'LessonNode(lesson: $lesson, wordCount: $wordCount, bestScore: $bestScore, completedAt: $completedAt, unlocked: $unlocked)';
}


}

/// @nodoc
abstract mixin class _$LessonNodeCopyWith<$Res> implements $LessonNodeCopyWith<$Res> {
  factory _$LessonNodeCopyWith(_LessonNode value, $Res Function(_LessonNode) _then) = __$LessonNodeCopyWithImpl;
@override @useResult
$Res call({
 LessonSummary lesson, int wordCount, int bestScore, DateTime? completedAt, bool unlocked
});


@override $LessonSummaryCopyWith<$Res> get lesson;

}
/// @nodoc
class __$LessonNodeCopyWithImpl<$Res>
    implements _$LessonNodeCopyWith<$Res> {
  __$LessonNodeCopyWithImpl(this._self, this._then);

  final _LessonNode _self;
  final $Res Function(_LessonNode) _then;

/// Create a copy of LessonNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lesson = null,Object? wordCount = null,Object? bestScore = null,Object? completedAt = freezed,Object? unlocked = null,}) {
  return _then(_LessonNode(
lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as LessonSummary,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,bestScore: null == bestScore ? _self.bestScore : bestScore // ignore: cast_nullable_to_non_nullable
as int,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LessonNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonSummaryCopyWith<$Res> get lesson {
  
  return $LessonSummaryCopyWith<$Res>(_self.lesson, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}
}


/// @nodoc
mixin _$DialogueLine {

 String get speaker; String get hanzi; String get pinyin; String get vi;
/// Create a copy of DialogueLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DialogueLineCopyWith<DialogueLine> get copyWith => _$DialogueLineCopyWithImpl<DialogueLine>(this as DialogueLine, _$identity);

  /// Serializes this DialogueLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DialogueLine&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.vi, vi) || other.vi == vi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speaker,hanzi,pinyin,vi);

@override
String toString() {
  return 'DialogueLine(speaker: $speaker, hanzi: $hanzi, pinyin: $pinyin, vi: $vi)';
}


}

/// @nodoc
abstract mixin class $DialogueLineCopyWith<$Res>  {
  factory $DialogueLineCopyWith(DialogueLine value, $Res Function(DialogueLine) _then) = _$DialogueLineCopyWithImpl;
@useResult
$Res call({
 String speaker, String hanzi, String pinyin, String vi
});




}
/// @nodoc
class _$DialogueLineCopyWithImpl<$Res>
    implements $DialogueLineCopyWith<$Res> {
  _$DialogueLineCopyWithImpl(this._self, this._then);

  final DialogueLine _self;
  final $Res Function(DialogueLine) _then;

/// Create a copy of DialogueLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speaker = null,Object? hanzi = null,Object? pinyin = null,Object? vi = null,}) {
  return _then(_self.copyWith(
speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,vi: null == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DialogueLine].
extension DialogueLinePatterns on DialogueLine {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DialogueLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DialogueLine() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DialogueLine value)  $default,){
final _that = this;
switch (_that) {
case _DialogueLine():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DialogueLine value)?  $default,){
final _that = this;
switch (_that) {
case _DialogueLine() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String speaker,  String hanzi,  String pinyin,  String vi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DialogueLine() when $default != null:
return $default(_that.speaker,_that.hanzi,_that.pinyin,_that.vi);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String speaker,  String hanzi,  String pinyin,  String vi)  $default,) {final _that = this;
switch (_that) {
case _DialogueLine():
return $default(_that.speaker,_that.hanzi,_that.pinyin,_that.vi);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String speaker,  String hanzi,  String pinyin,  String vi)?  $default,) {final _that = this;
switch (_that) {
case _DialogueLine() when $default != null:
return $default(_that.speaker,_that.hanzi,_that.pinyin,_that.vi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DialogueLine implements DialogueLine {
  const _DialogueLine({required this.speaker, required this.hanzi, required this.pinyin, required this.vi});
  factory _DialogueLine.fromJson(Map<String, dynamic> json) => _$DialogueLineFromJson(json);

@override final  String speaker;
@override final  String hanzi;
@override final  String pinyin;
@override final  String vi;

/// Create a copy of DialogueLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DialogueLineCopyWith<_DialogueLine> get copyWith => __$DialogueLineCopyWithImpl<_DialogueLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DialogueLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DialogueLine&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.vi, vi) || other.vi == vi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speaker,hanzi,pinyin,vi);

@override
String toString() {
  return 'DialogueLine(speaker: $speaker, hanzi: $hanzi, pinyin: $pinyin, vi: $vi)';
}


}

/// @nodoc
abstract mixin class _$DialogueLineCopyWith<$Res> implements $DialogueLineCopyWith<$Res> {
  factory _$DialogueLineCopyWith(_DialogueLine value, $Res Function(_DialogueLine) _then) = __$DialogueLineCopyWithImpl;
@override @useResult
$Res call({
 String speaker, String hanzi, String pinyin, String vi
});




}
/// @nodoc
class __$DialogueLineCopyWithImpl<$Res>
    implements _$DialogueLineCopyWith<$Res> {
  __$DialogueLineCopyWithImpl(this._self, this._then);

  final _DialogueLine _self;
  final $Res Function(_DialogueLine) _then;

/// Create a copy of DialogueLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speaker = null,Object? hanzi = null,Object? pinyin = null,Object? vi = null,}) {
  return _then(_DialogueLine(
speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,vi: null == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OrderSentence {

 List<String> get tokens; String get vi;
/// Create a copy of OrderSentence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderSentenceCopyWith<OrderSentence> get copyWith => _$OrderSentenceCopyWithImpl<OrderSentence>(this as OrderSentence, _$identity);

  /// Serializes this OrderSentence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderSentence&&const DeepCollectionEquality().equals(other.tokens, tokens)&&(identical(other.vi, vi) || other.vi == vi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tokens),vi);

@override
String toString() {
  return 'OrderSentence(tokens: $tokens, vi: $vi)';
}


}

/// @nodoc
abstract mixin class $OrderSentenceCopyWith<$Res>  {
  factory $OrderSentenceCopyWith(OrderSentence value, $Res Function(OrderSentence) _then) = _$OrderSentenceCopyWithImpl;
@useResult
$Res call({
 List<String> tokens, String vi
});




}
/// @nodoc
class _$OrderSentenceCopyWithImpl<$Res>
    implements $OrderSentenceCopyWith<$Res> {
  _$OrderSentenceCopyWithImpl(this._self, this._then);

  final OrderSentence _self;
  final $Res Function(OrderSentence) _then;

/// Create a copy of OrderSentence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tokens = null,Object? vi = null,}) {
  return _then(_self.copyWith(
tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<String>,vi: null == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderSentence].
extension OrderSentencePatterns on OrderSentence {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderSentence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderSentence() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderSentence value)  $default,){
final _that = this;
switch (_that) {
case _OrderSentence():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderSentence value)?  $default,){
final _that = this;
switch (_that) {
case _OrderSentence() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> tokens,  String vi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderSentence() when $default != null:
return $default(_that.tokens,_that.vi);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> tokens,  String vi)  $default,) {final _that = this;
switch (_that) {
case _OrderSentence():
return $default(_that.tokens,_that.vi);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> tokens,  String vi)?  $default,) {final _that = this;
switch (_that) {
case _OrderSentence() when $default != null:
return $default(_that.tokens,_that.vi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderSentence extends OrderSentence {
  const _OrderSentence({required final  List<String> tokens, required this.vi}): _tokens = tokens,super._();
  factory _OrderSentence.fromJson(Map<String, dynamic> json) => _$OrderSentenceFromJson(json);

 final  List<String> _tokens;
@override List<String> get tokens {
  if (_tokens is EqualUnmodifiableListView) return _tokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tokens);
}

@override final  String vi;

/// Create a copy of OrderSentence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderSentenceCopyWith<_OrderSentence> get copyWith => __$OrderSentenceCopyWithImpl<_OrderSentence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderSentenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderSentence&&const DeepCollectionEquality().equals(other._tokens, _tokens)&&(identical(other.vi, vi) || other.vi == vi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tokens),vi);

@override
String toString() {
  return 'OrderSentence(tokens: $tokens, vi: $vi)';
}


}

/// @nodoc
abstract mixin class _$OrderSentenceCopyWith<$Res> implements $OrderSentenceCopyWith<$Res> {
  factory _$OrderSentenceCopyWith(_OrderSentence value, $Res Function(_OrderSentence) _then) = __$OrderSentenceCopyWithImpl;
@override @useResult
$Res call({
 List<String> tokens, String vi
});




}
/// @nodoc
class __$OrderSentenceCopyWithImpl<$Res>
    implements _$OrderSentenceCopyWith<$Res> {
  __$OrderSentenceCopyWithImpl(this._self, this._then);

  final _OrderSentence _self;
  final $Res Function(_OrderSentence) _then;

/// Create a copy of OrderSentence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tokens = null,Object? vi = null,}) {
  return _then(_OrderSentence(
tokens: null == tokens ? _self._tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<String>,vi: null == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LessonDetail {

 LessonSummary get lesson; List<Word> get words; List<GrammarContent> get grammar; List<DialogueLine> get dialogue; List<OrderSentence> get sentences;
/// Create a copy of LessonDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonDetailCopyWith<LessonDetail> get copyWith => _$LessonDetailCopyWithImpl<LessonDetail>(this as LessonDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonDetail&&(identical(other.lesson, lesson) || other.lesson == lesson)&&const DeepCollectionEquality().equals(other.words, words)&&const DeepCollectionEquality().equals(other.grammar, grammar)&&const DeepCollectionEquality().equals(other.dialogue, dialogue)&&const DeepCollectionEquality().equals(other.sentences, sentences));
}


@override
int get hashCode => Object.hash(runtimeType,lesson,const DeepCollectionEquality().hash(words),const DeepCollectionEquality().hash(grammar),const DeepCollectionEquality().hash(dialogue),const DeepCollectionEquality().hash(sentences));

@override
String toString() {
  return 'LessonDetail(lesson: $lesson, words: $words, grammar: $grammar, dialogue: $dialogue, sentences: $sentences)';
}


}

/// @nodoc
abstract mixin class $LessonDetailCopyWith<$Res>  {
  factory $LessonDetailCopyWith(LessonDetail value, $Res Function(LessonDetail) _then) = _$LessonDetailCopyWithImpl;
@useResult
$Res call({
 LessonSummary lesson, List<Word> words, List<GrammarContent> grammar, List<DialogueLine> dialogue, List<OrderSentence> sentences
});


$LessonSummaryCopyWith<$Res> get lesson;

}
/// @nodoc
class _$LessonDetailCopyWithImpl<$Res>
    implements $LessonDetailCopyWith<$Res> {
  _$LessonDetailCopyWithImpl(this._self, this._then);

  final LessonDetail _self;
  final $Res Function(LessonDetail) _then;

/// Create a copy of LessonDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lesson = null,Object? words = null,Object? grammar = null,Object? dialogue = null,Object? sentences = null,}) {
  return _then(_self.copyWith(
lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as LessonSummary,words: null == words ? _self.words : words // ignore: cast_nullable_to_non_nullable
as List<Word>,grammar: null == grammar ? _self.grammar : grammar // ignore: cast_nullable_to_non_nullable
as List<GrammarContent>,dialogue: null == dialogue ? _self.dialogue : dialogue // ignore: cast_nullable_to_non_nullable
as List<DialogueLine>,sentences: null == sentences ? _self.sentences : sentences // ignore: cast_nullable_to_non_nullable
as List<OrderSentence>,
  ));
}
/// Create a copy of LessonDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonSummaryCopyWith<$Res> get lesson {
  
  return $LessonSummaryCopyWith<$Res>(_self.lesson, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}
}


/// Adds pattern-matching-related methods to [LessonDetail].
extension LessonDetailPatterns on LessonDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonDetail value)  $default,){
final _that = this;
switch (_that) {
case _LessonDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonDetail value)?  $default,){
final _that = this;
switch (_that) {
case _LessonDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LessonSummary lesson,  List<Word> words,  List<GrammarContent> grammar,  List<DialogueLine> dialogue,  List<OrderSentence> sentences)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonDetail() when $default != null:
return $default(_that.lesson,_that.words,_that.grammar,_that.dialogue,_that.sentences);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LessonSummary lesson,  List<Word> words,  List<GrammarContent> grammar,  List<DialogueLine> dialogue,  List<OrderSentence> sentences)  $default,) {final _that = this;
switch (_that) {
case _LessonDetail():
return $default(_that.lesson,_that.words,_that.grammar,_that.dialogue,_that.sentences);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LessonSummary lesson,  List<Word> words,  List<GrammarContent> grammar,  List<DialogueLine> dialogue,  List<OrderSentence> sentences)?  $default,) {final _that = this;
switch (_that) {
case _LessonDetail() when $default != null:
return $default(_that.lesson,_that.words,_that.grammar,_that.dialogue,_that.sentences);case _:
  return null;

}
}

}

/// @nodoc


class _LessonDetail implements LessonDetail {
  const _LessonDetail({required this.lesson, required final  List<Word> words, required final  List<GrammarContent> grammar, required final  List<DialogueLine> dialogue, required final  List<OrderSentence> sentences}): _words = words,_grammar = grammar,_dialogue = dialogue,_sentences = sentences;
  

@override final  LessonSummary lesson;
 final  List<Word> _words;
@override List<Word> get words {
  if (_words is EqualUnmodifiableListView) return _words;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_words);
}

 final  List<GrammarContent> _grammar;
@override List<GrammarContent> get grammar {
  if (_grammar is EqualUnmodifiableListView) return _grammar;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_grammar);
}

 final  List<DialogueLine> _dialogue;
@override List<DialogueLine> get dialogue {
  if (_dialogue is EqualUnmodifiableListView) return _dialogue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dialogue);
}

 final  List<OrderSentence> _sentences;
@override List<OrderSentence> get sentences {
  if (_sentences is EqualUnmodifiableListView) return _sentences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sentences);
}


/// Create a copy of LessonDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonDetailCopyWith<_LessonDetail> get copyWith => __$LessonDetailCopyWithImpl<_LessonDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonDetail&&(identical(other.lesson, lesson) || other.lesson == lesson)&&const DeepCollectionEquality().equals(other._words, _words)&&const DeepCollectionEquality().equals(other._grammar, _grammar)&&const DeepCollectionEquality().equals(other._dialogue, _dialogue)&&const DeepCollectionEquality().equals(other._sentences, _sentences));
}


@override
int get hashCode => Object.hash(runtimeType,lesson,const DeepCollectionEquality().hash(_words),const DeepCollectionEquality().hash(_grammar),const DeepCollectionEquality().hash(_dialogue),const DeepCollectionEquality().hash(_sentences));

@override
String toString() {
  return 'LessonDetail(lesson: $lesson, words: $words, grammar: $grammar, dialogue: $dialogue, sentences: $sentences)';
}


}

/// @nodoc
abstract mixin class _$LessonDetailCopyWith<$Res> implements $LessonDetailCopyWith<$Res> {
  factory _$LessonDetailCopyWith(_LessonDetail value, $Res Function(_LessonDetail) _then) = __$LessonDetailCopyWithImpl;
@override @useResult
$Res call({
 LessonSummary lesson, List<Word> words, List<GrammarContent> grammar, List<DialogueLine> dialogue, List<OrderSentence> sentences
});


@override $LessonSummaryCopyWith<$Res> get lesson;

}
/// @nodoc
class __$LessonDetailCopyWithImpl<$Res>
    implements _$LessonDetailCopyWith<$Res> {
  __$LessonDetailCopyWithImpl(this._self, this._then);

  final _LessonDetail _self;
  final $Res Function(_LessonDetail) _then;

/// Create a copy of LessonDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lesson = null,Object? words = null,Object? grammar = null,Object? dialogue = null,Object? sentences = null,}) {
  return _then(_LessonDetail(
lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as LessonSummary,words: null == words ? _self._words : words // ignore: cast_nullable_to_non_nullable
as List<Word>,grammar: null == grammar ? _self._grammar : grammar // ignore: cast_nullable_to_non_nullable
as List<GrammarContent>,dialogue: null == dialogue ? _self._dialogue : dialogue // ignore: cast_nullable_to_non_nullable
as List<DialogueLine>,sentences: null == sentences ? _self._sentences : sentences // ignore: cast_nullable_to_non_nullable
as List<OrderSentence>,
  ));
}

/// Create a copy of LessonDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonSummaryCopyWith<$Res> get lesson {
  
  return $LessonSummaryCopyWith<$Res>(_self.lesson, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}
}

// dart format on
