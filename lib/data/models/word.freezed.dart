// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Word {

 String get id; String get hanzi; String get pinyin; String get hanViet; String get meaningVi; int get level; String get lessonId; bool get mustWrite; String? get audioPath; List<ExampleSentence> get examples;
/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordCopyWith<Word> get copyWith => _$WordCopyWithImpl<Word>(this as Word, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Word&&(identical(other.id, id) || other.id == id)&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.hanViet, hanViet) || other.hanViet == hanViet)&&(identical(other.meaningVi, meaningVi) || other.meaningVi == meaningVi)&&(identical(other.level, level) || other.level == level)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.mustWrite, mustWrite) || other.mustWrite == mustWrite)&&(identical(other.audioPath, audioPath) || other.audioPath == audioPath)&&const DeepCollectionEquality().equals(other.examples, examples));
}


@override
int get hashCode => Object.hash(runtimeType,id,hanzi,pinyin,hanViet,meaningVi,level,lessonId,mustWrite,audioPath,const DeepCollectionEquality().hash(examples));

@override
String toString() {
  return 'Word(id: $id, hanzi: $hanzi, pinyin: $pinyin, hanViet: $hanViet, meaningVi: $meaningVi, level: $level, lessonId: $lessonId, mustWrite: $mustWrite, audioPath: $audioPath, examples: $examples)';
}


}

/// @nodoc
abstract mixin class $WordCopyWith<$Res>  {
  factory $WordCopyWith(Word value, $Res Function(Word) _then) = _$WordCopyWithImpl;
@useResult
$Res call({
 String id, String hanzi, String pinyin, String hanViet, String meaningVi, int level, String lessonId, bool mustWrite, String? audioPath, List<ExampleSentence> examples
});




}
/// @nodoc
class _$WordCopyWithImpl<$Res>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._self, this._then);

  final Word _self;
  final $Res Function(Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hanzi = null,Object? pinyin = null,Object? hanViet = null,Object? meaningVi = null,Object? level = null,Object? lessonId = null,Object? mustWrite = null,Object? audioPath = freezed,Object? examples = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,hanViet: null == hanViet ? _self.hanViet : hanViet // ignore: cast_nullable_to_non_nullable
as String,meaningVi: null == meaningVi ? _self.meaningVi : meaningVi // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,mustWrite: null == mustWrite ? _self.mustWrite : mustWrite // ignore: cast_nullable_to_non_nullable
as bool,audioPath: freezed == audioPath ? _self.audioPath : audioPath // ignore: cast_nullable_to_non_nullable
as String?,examples: null == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as List<ExampleSentence>,
  ));
}

}


/// Adds pattern-matching-related methods to [Word].
extension WordPatterns on Word {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Word value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Word() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Word value)  $default,){
final _that = this;
switch (_that) {
case _Word():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Word value)?  $default,){
final _that = this;
switch (_that) {
case _Word() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String hanzi,  String pinyin,  String hanViet,  String meaningVi,  int level,  String lessonId,  bool mustWrite,  String? audioPath,  List<ExampleSentence> examples)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.id,_that.hanzi,_that.pinyin,_that.hanViet,_that.meaningVi,_that.level,_that.lessonId,_that.mustWrite,_that.audioPath,_that.examples);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String hanzi,  String pinyin,  String hanViet,  String meaningVi,  int level,  String lessonId,  bool mustWrite,  String? audioPath,  List<ExampleSentence> examples)  $default,) {final _that = this;
switch (_that) {
case _Word():
return $default(_that.id,_that.hanzi,_that.pinyin,_that.hanViet,_that.meaningVi,_that.level,_that.lessonId,_that.mustWrite,_that.audioPath,_that.examples);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String hanzi,  String pinyin,  String hanViet,  String meaningVi,  int level,  String lessonId,  bool mustWrite,  String? audioPath,  List<ExampleSentence> examples)?  $default,) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.id,_that.hanzi,_that.pinyin,_that.hanViet,_that.meaningVi,_that.level,_that.lessonId,_that.mustWrite,_that.audioPath,_that.examples);case _:
  return null;

}
}

}

/// @nodoc


class _Word extends Word {
  const _Word({required this.id, required this.hanzi, required this.pinyin, required this.hanViet, required this.meaningVi, required this.level, required this.lessonId, required this.mustWrite, this.audioPath, final  List<ExampleSentence> examples = const <ExampleSentence>[]}): _examples = examples,super._();
  

@override final  String id;
@override final  String hanzi;
@override final  String pinyin;
@override final  String hanViet;
@override final  String meaningVi;
@override final  int level;
@override final  String lessonId;
@override final  bool mustWrite;
@override final  String? audioPath;
 final  List<ExampleSentence> _examples;
@override@JsonKey() List<ExampleSentence> get examples {
  if (_examples is EqualUnmodifiableListView) return _examples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_examples);
}


/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordCopyWith<_Word> get copyWith => __$WordCopyWithImpl<_Word>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Word&&(identical(other.id, id) || other.id == id)&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.hanViet, hanViet) || other.hanViet == hanViet)&&(identical(other.meaningVi, meaningVi) || other.meaningVi == meaningVi)&&(identical(other.level, level) || other.level == level)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.mustWrite, mustWrite) || other.mustWrite == mustWrite)&&(identical(other.audioPath, audioPath) || other.audioPath == audioPath)&&const DeepCollectionEquality().equals(other._examples, _examples));
}


@override
int get hashCode => Object.hash(runtimeType,id,hanzi,pinyin,hanViet,meaningVi,level,lessonId,mustWrite,audioPath,const DeepCollectionEquality().hash(_examples));

@override
String toString() {
  return 'Word(id: $id, hanzi: $hanzi, pinyin: $pinyin, hanViet: $hanViet, meaningVi: $meaningVi, level: $level, lessonId: $lessonId, mustWrite: $mustWrite, audioPath: $audioPath, examples: $examples)';
}


}

/// @nodoc
abstract mixin class _$WordCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$WordCopyWith(_Word value, $Res Function(_Word) _then) = __$WordCopyWithImpl;
@override @useResult
$Res call({
 String id, String hanzi, String pinyin, String hanViet, String meaningVi, int level, String lessonId, bool mustWrite, String? audioPath, List<ExampleSentence> examples
});




}
/// @nodoc
class __$WordCopyWithImpl<$Res>
    implements _$WordCopyWith<$Res> {
  __$WordCopyWithImpl(this._self, this._then);

  final _Word _self;
  final $Res Function(_Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hanzi = null,Object? pinyin = null,Object? hanViet = null,Object? meaningVi = null,Object? level = null,Object? lessonId = null,Object? mustWrite = null,Object? audioPath = freezed,Object? examples = null,}) {
  return _then(_Word(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,hanViet: null == hanViet ? _self.hanViet : hanViet // ignore: cast_nullable_to_non_nullable
as String,meaningVi: null == meaningVi ? _self.meaningVi : meaningVi // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,mustWrite: null == mustWrite ? _self.mustWrite : mustWrite // ignore: cast_nullable_to_non_nullable
as bool,audioPath: freezed == audioPath ? _self.audioPath : audioPath // ignore: cast_nullable_to_non_nullable
as String?,examples: null == examples ? _self._examples : examples // ignore: cast_nullable_to_non_nullable
as List<ExampleSentence>,
  ));
}


}

// dart format on
