// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExampleSentence {

 String get hanzi; String get pinyin; String get vi;
/// Create a copy of ExampleSentence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleSentenceCopyWith<ExampleSentence> get copyWith => _$ExampleSentenceCopyWithImpl<ExampleSentence>(this as ExampleSentence, _$identity);

  /// Serializes this ExampleSentence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleSentence&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.vi, vi) || other.vi == vi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hanzi,pinyin,vi);

@override
String toString() {
  return 'ExampleSentence(hanzi: $hanzi, pinyin: $pinyin, vi: $vi)';
}


}

/// @nodoc
abstract mixin class $ExampleSentenceCopyWith<$Res>  {
  factory $ExampleSentenceCopyWith(ExampleSentence value, $Res Function(ExampleSentence) _then) = _$ExampleSentenceCopyWithImpl;
@useResult
$Res call({
 String hanzi, String pinyin, String vi
});




}
/// @nodoc
class _$ExampleSentenceCopyWithImpl<$Res>
    implements $ExampleSentenceCopyWith<$Res> {
  _$ExampleSentenceCopyWithImpl(this._self, this._then);

  final ExampleSentence _self;
  final $Res Function(ExampleSentence) _then;

/// Create a copy of ExampleSentence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hanzi = null,Object? pinyin = null,Object? vi = null,}) {
  return _then(_self.copyWith(
hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,vi: null == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExampleSentence].
extension ExampleSentencePatterns on ExampleSentence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExampleSentence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExampleSentence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExampleSentence value)  $default,){
final _that = this;
switch (_that) {
case _ExampleSentence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExampleSentence value)?  $default,){
final _that = this;
switch (_that) {
case _ExampleSentence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String hanzi,  String pinyin,  String vi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExampleSentence() when $default != null:
return $default(_that.hanzi,_that.pinyin,_that.vi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String hanzi,  String pinyin,  String vi)  $default,) {final _that = this;
switch (_that) {
case _ExampleSentence():
return $default(_that.hanzi,_that.pinyin,_that.vi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String hanzi,  String pinyin,  String vi)?  $default,) {final _that = this;
switch (_that) {
case _ExampleSentence() when $default != null:
return $default(_that.hanzi,_that.pinyin,_that.vi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExampleSentence implements ExampleSentence {
  const _ExampleSentence({required this.hanzi, required this.pinyin, required this.vi});
  factory _ExampleSentence.fromJson(Map<String, dynamic> json) => _$ExampleSentenceFromJson(json);

@override final  String hanzi;
@override final  String pinyin;
@override final  String vi;

/// Create a copy of ExampleSentence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleSentenceCopyWith<_ExampleSentence> get copyWith => __$ExampleSentenceCopyWithImpl<_ExampleSentence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExampleSentenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExampleSentence&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.vi, vi) || other.vi == vi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hanzi,pinyin,vi);

@override
String toString() {
  return 'ExampleSentence(hanzi: $hanzi, pinyin: $pinyin, vi: $vi)';
}


}

/// @nodoc
abstract mixin class _$ExampleSentenceCopyWith<$Res> implements $ExampleSentenceCopyWith<$Res> {
  factory _$ExampleSentenceCopyWith(_ExampleSentence value, $Res Function(_ExampleSentence) _then) = __$ExampleSentenceCopyWithImpl;
@override @useResult
$Res call({
 String hanzi, String pinyin, String vi
});




}
/// @nodoc
class __$ExampleSentenceCopyWithImpl<$Res>
    implements _$ExampleSentenceCopyWith<$Res> {
  __$ExampleSentenceCopyWithImpl(this._self, this._then);

  final _ExampleSentence _self;
  final $Res Function(_ExampleSentence) _then;

/// Create a copy of ExampleSentence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hanzi = null,Object? pinyin = null,Object? vi = null,}) {
  return _then(_ExampleSentence(
hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,vi: null == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WordContent {

 String get id; String get hanzi;/// Pinyin có dấu, tách âm tiết bằng dấu cách: "lǎo shī".
 String get pinyin; String get hanViet; String get meaningVi; String get lessonId; bool get mustWrite;/// Đường dẫn asset audio (vd "assets/audio/hsk1/ni3.mp3"); null → dùng TTS.
 String? get audio; List<ExampleSentence> get examples;
/// Create a copy of WordContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordContentCopyWith<WordContent> get copyWith => _$WordContentCopyWithImpl<WordContent>(this as WordContent, _$identity);

  /// Serializes this WordContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordContent&&(identical(other.id, id) || other.id == id)&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.hanViet, hanViet) || other.hanViet == hanViet)&&(identical(other.meaningVi, meaningVi) || other.meaningVi == meaningVi)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.mustWrite, mustWrite) || other.mustWrite == mustWrite)&&(identical(other.audio, audio) || other.audio == audio)&&const DeepCollectionEquality().equals(other.examples, examples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hanzi,pinyin,hanViet,meaningVi,lessonId,mustWrite,audio,const DeepCollectionEquality().hash(examples));

@override
String toString() {
  return 'WordContent(id: $id, hanzi: $hanzi, pinyin: $pinyin, hanViet: $hanViet, meaningVi: $meaningVi, lessonId: $lessonId, mustWrite: $mustWrite, audio: $audio, examples: $examples)';
}


}

/// @nodoc
abstract mixin class $WordContentCopyWith<$Res>  {
  factory $WordContentCopyWith(WordContent value, $Res Function(WordContent) _then) = _$WordContentCopyWithImpl;
@useResult
$Res call({
 String id, String hanzi, String pinyin, String hanViet, String meaningVi, String lessonId, bool mustWrite, String? audio, List<ExampleSentence> examples
});




}
/// @nodoc
class _$WordContentCopyWithImpl<$Res>
    implements $WordContentCopyWith<$Res> {
  _$WordContentCopyWithImpl(this._self, this._then);

  final WordContent _self;
  final $Res Function(WordContent) _then;

/// Create a copy of WordContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hanzi = null,Object? pinyin = null,Object? hanViet = null,Object? meaningVi = null,Object? lessonId = null,Object? mustWrite = null,Object? audio = freezed,Object? examples = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,hanViet: null == hanViet ? _self.hanViet : hanViet // ignore: cast_nullable_to_non_nullable
as String,meaningVi: null == meaningVi ? _self.meaningVi : meaningVi // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,mustWrite: null == mustWrite ? _self.mustWrite : mustWrite // ignore: cast_nullable_to_non_nullable
as bool,audio: freezed == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String?,examples: null == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as List<ExampleSentence>,
  ));
}

}


/// Adds pattern-matching-related methods to [WordContent].
extension WordContentPatterns on WordContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordContent value)  $default,){
final _that = this;
switch (_that) {
case _WordContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordContent value)?  $default,){
final _that = this;
switch (_that) {
case _WordContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String hanzi,  String pinyin,  String hanViet,  String meaningVi,  String lessonId,  bool mustWrite,  String? audio,  List<ExampleSentence> examples)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordContent() when $default != null:
return $default(_that.id,_that.hanzi,_that.pinyin,_that.hanViet,_that.meaningVi,_that.lessonId,_that.mustWrite,_that.audio,_that.examples);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String hanzi,  String pinyin,  String hanViet,  String meaningVi,  String lessonId,  bool mustWrite,  String? audio,  List<ExampleSentence> examples)  $default,) {final _that = this;
switch (_that) {
case _WordContent():
return $default(_that.id,_that.hanzi,_that.pinyin,_that.hanViet,_that.meaningVi,_that.lessonId,_that.mustWrite,_that.audio,_that.examples);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String hanzi,  String pinyin,  String hanViet,  String meaningVi,  String lessonId,  bool mustWrite,  String? audio,  List<ExampleSentence> examples)?  $default,) {final _that = this;
switch (_that) {
case _WordContent() when $default != null:
return $default(_that.id,_that.hanzi,_that.pinyin,_that.hanViet,_that.meaningVi,_that.lessonId,_that.mustWrite,_that.audio,_that.examples);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordContent implements WordContent {
  const _WordContent({required this.id, required this.hanzi, required this.pinyin, required this.hanViet, required this.meaningVi, required this.lessonId, this.mustWrite = false, this.audio, final  List<ExampleSentence> examples = const <ExampleSentence>[]}): _examples = examples;
  factory _WordContent.fromJson(Map<String, dynamic> json) => _$WordContentFromJson(json);

@override final  String id;
@override final  String hanzi;
/// Pinyin có dấu, tách âm tiết bằng dấu cách: "lǎo shī".
@override final  String pinyin;
@override final  String hanViet;
@override final  String meaningVi;
@override final  String lessonId;
@override@JsonKey() final  bool mustWrite;
/// Đường dẫn asset audio (vd "assets/audio/hsk1/ni3.mp3"); null → dùng TTS.
@override final  String? audio;
 final  List<ExampleSentence> _examples;
@override@JsonKey() List<ExampleSentence> get examples {
  if (_examples is EqualUnmodifiableListView) return _examples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_examples);
}


/// Create a copy of WordContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordContentCopyWith<_WordContent> get copyWith => __$WordContentCopyWithImpl<_WordContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordContent&&(identical(other.id, id) || other.id == id)&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.hanViet, hanViet) || other.hanViet == hanViet)&&(identical(other.meaningVi, meaningVi) || other.meaningVi == meaningVi)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.mustWrite, mustWrite) || other.mustWrite == mustWrite)&&(identical(other.audio, audio) || other.audio == audio)&&const DeepCollectionEquality().equals(other._examples, _examples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hanzi,pinyin,hanViet,meaningVi,lessonId,mustWrite,audio,const DeepCollectionEquality().hash(_examples));

@override
String toString() {
  return 'WordContent(id: $id, hanzi: $hanzi, pinyin: $pinyin, hanViet: $hanViet, meaningVi: $meaningVi, lessonId: $lessonId, mustWrite: $mustWrite, audio: $audio, examples: $examples)';
}


}

/// @nodoc
abstract mixin class _$WordContentCopyWith<$Res> implements $WordContentCopyWith<$Res> {
  factory _$WordContentCopyWith(_WordContent value, $Res Function(_WordContent) _then) = __$WordContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String hanzi, String pinyin, String hanViet, String meaningVi, String lessonId, bool mustWrite, String? audio, List<ExampleSentence> examples
});




}
/// @nodoc
class __$WordContentCopyWithImpl<$Res>
    implements _$WordContentCopyWith<$Res> {
  __$WordContentCopyWithImpl(this._self, this._then);

  final _WordContent _self;
  final $Res Function(_WordContent) _then;

/// Create a copy of WordContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hanzi = null,Object? pinyin = null,Object? hanViet = null,Object? meaningVi = null,Object? lessonId = null,Object? mustWrite = null,Object? audio = freezed,Object? examples = null,}) {
  return _then(_WordContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,hanViet: null == hanViet ? _self.hanViet : hanViet // ignore: cast_nullable_to_non_nullable
as String,meaningVi: null == meaningVi ? _self.meaningVi : meaningVi // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,mustWrite: null == mustWrite ? _self.mustWrite : mustWrite // ignore: cast_nullable_to_non_nullable
as bool,audio: freezed == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String?,examples: null == examples ? _self._examples : examples // ignore: cast_nullable_to_non_nullable
as List<ExampleSentence>,
  ));
}


}


/// @nodoc
mixin _$LessonContent {

 String get id; int get order; String get title; String get subtitle;
/// Create a copy of LessonContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonContentCopyWith<LessonContent> get copyWith => _$LessonContentCopyWithImpl<LessonContent>(this as LessonContent, _$identity);

  /// Serializes this LessonContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonContent&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,order,title,subtitle);

@override
String toString() {
  return 'LessonContent(id: $id, order: $order, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $LessonContentCopyWith<$Res>  {
  factory $LessonContentCopyWith(LessonContent value, $Res Function(LessonContent) _then) = _$LessonContentCopyWithImpl;
@useResult
$Res call({
 String id, int order, String title, String subtitle
});




}
/// @nodoc
class _$LessonContentCopyWithImpl<$Res>
    implements $LessonContentCopyWith<$Res> {
  _$LessonContentCopyWithImpl(this._self, this._then);

  final LessonContent _self;
  final $Res Function(LessonContent) _then;

/// Create a copy of LessonContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? order = null,Object? title = null,Object? subtitle = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonContent].
extension LessonContentPatterns on LessonContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonContent value)  $default,){
final _that = this;
switch (_that) {
case _LessonContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonContent value)?  $default,){
final _that = this;
switch (_that) {
case _LessonContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int order,  String title,  String subtitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonContent() when $default != null:
return $default(_that.id,_that.order,_that.title,_that.subtitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int order,  String title,  String subtitle)  $default,) {final _that = this;
switch (_that) {
case _LessonContent():
return $default(_that.id,_that.order,_that.title,_that.subtitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int order,  String title,  String subtitle)?  $default,) {final _that = this;
switch (_that) {
case _LessonContent() when $default != null:
return $default(_that.id,_that.order,_that.title,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LessonContent implements LessonContent {
  const _LessonContent({required this.id, required this.order, required this.title, this.subtitle = ''});
  factory _LessonContent.fromJson(Map<String, dynamic> json) => _$LessonContentFromJson(json);

@override final  String id;
@override final  int order;
@override final  String title;
@override@JsonKey() final  String subtitle;

/// Create a copy of LessonContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonContentCopyWith<_LessonContent> get copyWith => __$LessonContentCopyWithImpl<_LessonContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonContent&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,order,title,subtitle);

@override
String toString() {
  return 'LessonContent(id: $id, order: $order, title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$LessonContentCopyWith<$Res> implements $LessonContentCopyWith<$Res> {
  factory _$LessonContentCopyWith(_LessonContent value, $Res Function(_LessonContent) _then) = __$LessonContentCopyWithImpl;
@override @useResult
$Res call({
 String id, int order, String title, String subtitle
});




}
/// @nodoc
class __$LessonContentCopyWithImpl<$Res>
    implements _$LessonContentCopyWith<$Res> {
  __$LessonContentCopyWithImpl(this._self, this._then);

  final _LessonContent _self;
  final $Res Function(_LessonContent) _then;

/// Create a copy of LessonContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? order = null,Object? title = null,Object? subtitle = null,}) {
  return _then(_LessonContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GrammarContent {

 String get id; String get lessonId; String get title; String get pattern; String get explanationVi; List<ExampleSentence> get examples;
/// Create a copy of GrammarContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GrammarContentCopyWith<GrammarContent> get copyWith => _$GrammarContentCopyWithImpl<GrammarContent>(this as GrammarContent, _$identity);

  /// Serializes this GrammarContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GrammarContent&&(identical(other.id, id) || other.id == id)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.explanationVi, explanationVi) || other.explanationVi == explanationVi)&&const DeepCollectionEquality().equals(other.examples, examples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lessonId,title,pattern,explanationVi,const DeepCollectionEquality().hash(examples));

@override
String toString() {
  return 'GrammarContent(id: $id, lessonId: $lessonId, title: $title, pattern: $pattern, explanationVi: $explanationVi, examples: $examples)';
}


}

/// @nodoc
abstract mixin class $GrammarContentCopyWith<$Res>  {
  factory $GrammarContentCopyWith(GrammarContent value, $Res Function(GrammarContent) _then) = _$GrammarContentCopyWithImpl;
@useResult
$Res call({
 String id, String lessonId, String title, String pattern, String explanationVi, List<ExampleSentence> examples
});




}
/// @nodoc
class _$GrammarContentCopyWithImpl<$Res>
    implements $GrammarContentCopyWith<$Res> {
  _$GrammarContentCopyWithImpl(this._self, this._then);

  final GrammarContent _self;
  final $Res Function(GrammarContent) _then;

/// Create a copy of GrammarContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lessonId = null,Object? title = null,Object? pattern = null,Object? explanationVi = null,Object? examples = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,explanationVi: null == explanationVi ? _self.explanationVi : explanationVi // ignore: cast_nullable_to_non_nullable
as String,examples: null == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as List<ExampleSentence>,
  ));
}

}


/// Adds pattern-matching-related methods to [GrammarContent].
extension GrammarContentPatterns on GrammarContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GrammarContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GrammarContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GrammarContent value)  $default,){
final _that = this;
switch (_that) {
case _GrammarContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GrammarContent value)?  $default,){
final _that = this;
switch (_that) {
case _GrammarContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String lessonId,  String title,  String pattern,  String explanationVi,  List<ExampleSentence> examples)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GrammarContent() when $default != null:
return $default(_that.id,_that.lessonId,_that.title,_that.pattern,_that.explanationVi,_that.examples);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String lessonId,  String title,  String pattern,  String explanationVi,  List<ExampleSentence> examples)  $default,) {final _that = this;
switch (_that) {
case _GrammarContent():
return $default(_that.id,_that.lessonId,_that.title,_that.pattern,_that.explanationVi,_that.examples);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String lessonId,  String title,  String pattern,  String explanationVi,  List<ExampleSentence> examples)?  $default,) {final _that = this;
switch (_that) {
case _GrammarContent() when $default != null:
return $default(_that.id,_that.lessonId,_that.title,_that.pattern,_that.explanationVi,_that.examples);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GrammarContent implements GrammarContent {
  const _GrammarContent({required this.id, required this.lessonId, required this.title, required this.pattern, required this.explanationVi, final  List<ExampleSentence> examples = const <ExampleSentence>[]}): _examples = examples;
  factory _GrammarContent.fromJson(Map<String, dynamic> json) => _$GrammarContentFromJson(json);

@override final  String id;
@override final  String lessonId;
@override final  String title;
@override final  String pattern;
@override final  String explanationVi;
 final  List<ExampleSentence> _examples;
@override@JsonKey() List<ExampleSentence> get examples {
  if (_examples is EqualUnmodifiableListView) return _examples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_examples);
}


/// Create a copy of GrammarContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GrammarContentCopyWith<_GrammarContent> get copyWith => __$GrammarContentCopyWithImpl<_GrammarContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GrammarContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GrammarContent&&(identical(other.id, id) || other.id == id)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.explanationVi, explanationVi) || other.explanationVi == explanationVi)&&const DeepCollectionEquality().equals(other._examples, _examples));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lessonId,title,pattern,explanationVi,const DeepCollectionEquality().hash(_examples));

@override
String toString() {
  return 'GrammarContent(id: $id, lessonId: $lessonId, title: $title, pattern: $pattern, explanationVi: $explanationVi, examples: $examples)';
}


}

/// @nodoc
abstract mixin class _$GrammarContentCopyWith<$Res> implements $GrammarContentCopyWith<$Res> {
  factory _$GrammarContentCopyWith(_GrammarContent value, $Res Function(_GrammarContent) _then) = __$GrammarContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String lessonId, String title, String pattern, String explanationVi, List<ExampleSentence> examples
});




}
/// @nodoc
class __$GrammarContentCopyWithImpl<$Res>
    implements _$GrammarContentCopyWith<$Res> {
  __$GrammarContentCopyWithImpl(this._self, this._then);

  final _GrammarContent _self;
  final $Res Function(_GrammarContent) _then;

/// Create a copy of GrammarContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lessonId = null,Object? title = null,Object? pattern = null,Object? explanationVi = null,Object? examples = null,}) {
  return _then(_GrammarContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,explanationVi: null == explanationVi ? _self.explanationVi : explanationVi // ignore: cast_nullable_to_non_nullable
as String,examples: null == examples ? _self._examples : examples // ignore: cast_nullable_to_non_nullable
as List<ExampleSentence>,
  ));
}


}

// dart format on
