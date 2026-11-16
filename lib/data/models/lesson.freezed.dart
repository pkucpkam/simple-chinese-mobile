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

// dart format on
