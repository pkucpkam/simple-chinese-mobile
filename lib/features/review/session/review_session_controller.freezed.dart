// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_session_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionState {

 SessionMode get mode; List<SessionTask> get tasks; DateTime get startedAt; int get index; int get answered; int get correct; int get xp;/// Số lần đã cho làm lại theo cardId (giới hạn để phiên không kéo dài).
 Map<int, int> get retries;
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStateCopyWith<SessionState> get copyWith => _$SessionStateCopyWithImpl<SessionState>(this as SessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.index, index) || other.index == index)&&(identical(other.answered, answered) || other.answered == answered)&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.xp, xp) || other.xp == xp)&&const DeepCollectionEquality().equals(other.retries, retries));
}


@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(tasks),startedAt,index,answered,correct,xp,const DeepCollectionEquality().hash(retries));

@override
String toString() {
  return 'SessionState(mode: $mode, tasks: $tasks, startedAt: $startedAt, index: $index, answered: $answered, correct: $correct, xp: $xp, retries: $retries)';
}


}

/// @nodoc
abstract mixin class $SessionStateCopyWith<$Res>  {
  factory $SessionStateCopyWith(SessionState value, $Res Function(SessionState) _then) = _$SessionStateCopyWithImpl;
@useResult
$Res call({
 SessionMode mode, List<SessionTask> tasks, DateTime startedAt, int index, int answered, int correct, int xp, Map<int, int> retries
});




}
/// @nodoc
class _$SessionStateCopyWithImpl<$Res>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._self, this._then);

  final SessionState _self;
  final $Res Function(SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? tasks = null,Object? startedAt = null,Object? index = null,Object? answered = null,Object? correct = null,Object? xp = null,Object? retries = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SessionMode,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<SessionTask>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,answered: null == answered ? _self.answered : answered // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,retries: null == retries ? _self.retries : retries // ignore: cast_nullable_to_non_nullable
as Map<int, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionState value)  $default,){
final _that = this;
switch (_that) {
case _SessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionState value)?  $default,){
final _that = this;
switch (_that) {
case _SessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SessionMode mode,  List<SessionTask> tasks,  DateTime startedAt,  int index,  int answered,  int correct,  int xp,  Map<int, int> retries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionState() when $default != null:
return $default(_that.mode,_that.tasks,_that.startedAt,_that.index,_that.answered,_that.correct,_that.xp,_that.retries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SessionMode mode,  List<SessionTask> tasks,  DateTime startedAt,  int index,  int answered,  int correct,  int xp,  Map<int, int> retries)  $default,) {final _that = this;
switch (_that) {
case _SessionState():
return $default(_that.mode,_that.tasks,_that.startedAt,_that.index,_that.answered,_that.correct,_that.xp,_that.retries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SessionMode mode,  List<SessionTask> tasks,  DateTime startedAt,  int index,  int answered,  int correct,  int xp,  Map<int, int> retries)?  $default,) {final _that = this;
switch (_that) {
case _SessionState() when $default != null:
return $default(_that.mode,_that.tasks,_that.startedAt,_that.index,_that.answered,_that.correct,_that.xp,_that.retries);case _:
  return null;

}
}

}

/// @nodoc


class _SessionState extends SessionState {
  const _SessionState({required this.mode, required final  List<SessionTask> tasks, required this.startedAt, this.index = 0, this.answered = 0, this.correct = 0, this.xp = 0, final  Map<int, int> retries = const <int, int>{}}): _tasks = tasks,_retries = retries,super._();
  

@override final  SessionMode mode;
 final  List<SessionTask> _tasks;
@override List<SessionTask> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

@override final  DateTime startedAt;
@override@JsonKey() final  int index;
@override@JsonKey() final  int answered;
@override@JsonKey() final  int correct;
@override@JsonKey() final  int xp;
/// Số lần đã cho làm lại theo cardId (giới hạn để phiên không kéo dài).
 final  Map<int, int> _retries;
/// Số lần đã cho làm lại theo cardId (giới hạn để phiên không kéo dài).
@override@JsonKey() Map<int, int> get retries {
  if (_retries is EqualUnmodifiableMapView) return _retries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_retries);
}


/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionStateCopyWith<_SessionState> get copyWith => __$SessionStateCopyWithImpl<_SessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionState&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.index, index) || other.index == index)&&(identical(other.answered, answered) || other.answered == answered)&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.xp, xp) || other.xp == xp)&&const DeepCollectionEquality().equals(other._retries, _retries));
}


@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(_tasks),startedAt,index,answered,correct,xp,const DeepCollectionEquality().hash(_retries));

@override
String toString() {
  return 'SessionState(mode: $mode, tasks: $tasks, startedAt: $startedAt, index: $index, answered: $answered, correct: $correct, xp: $xp, retries: $retries)';
}


}

/// @nodoc
abstract mixin class _$SessionStateCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory _$SessionStateCopyWith(_SessionState value, $Res Function(_SessionState) _then) = __$SessionStateCopyWithImpl;
@override @useResult
$Res call({
 SessionMode mode, List<SessionTask> tasks, DateTime startedAt, int index, int answered, int correct, int xp, Map<int, int> retries
});




}
/// @nodoc
class __$SessionStateCopyWithImpl<$Res>
    implements _$SessionStateCopyWith<$Res> {
  __$SessionStateCopyWithImpl(this._self, this._then);

  final _SessionState _self;
  final $Res Function(_SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? tasks = null,Object? startedAt = null,Object? index = null,Object? answered = null,Object? correct = null,Object? xp = null,Object? retries = null,}) {
  return _then(_SessionState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SessionMode,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<SessionTask>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,answered: null == answered ? _self.answered : answered // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,retries: null == retries ? _self._retries : retries // ignore: cast_nullable_to_non_nullable
as Map<int, int>,
  ));
}


}

// dart format on
