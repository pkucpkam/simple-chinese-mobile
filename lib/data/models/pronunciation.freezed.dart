// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pronunciation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Syllable {

/// Cách viết không dấu: "zhang", "nü", "yue".
 String get syllable;/// Thanh mẫu ("" nếu không có).
 String get initial;/// Vận mẫu gốc theo bảng ("ü", "iu", "ui"...).
 String get finalPart;/// Thanh (1..4) → chữ Hán đại diện để phát âm.
 Map<int, String> get tones;
/// Create a copy of Syllable
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyllableCopyWith<Syllable> get copyWith => _$SyllableCopyWithImpl<Syllable>(this as Syllable, _$identity);

  /// Serializes this Syllable to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Syllable&&(identical(other.syllable, syllable) || other.syllable == syllable)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.finalPart, finalPart) || other.finalPart == finalPart)&&const DeepCollectionEquality().equals(other.tones, tones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,syllable,initial,finalPart,const DeepCollectionEquality().hash(tones));

@override
String toString() {
  return 'Syllable(syllable: $syllable, initial: $initial, finalPart: $finalPart, tones: $tones)';
}


}

/// @nodoc
abstract mixin class $SyllableCopyWith<$Res>  {
  factory $SyllableCopyWith(Syllable value, $Res Function(Syllable) _then) = _$SyllableCopyWithImpl;
@useResult
$Res call({
 String syllable, String initial, String finalPart, Map<int, String> tones
});




}
/// @nodoc
class _$SyllableCopyWithImpl<$Res>
    implements $SyllableCopyWith<$Res> {
  _$SyllableCopyWithImpl(this._self, this._then);

  final Syllable _self;
  final $Res Function(Syllable) _then;

/// Create a copy of Syllable
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? syllable = null,Object? initial = null,Object? finalPart = null,Object? tones = null,}) {
  return _then(_self.copyWith(
syllable: null == syllable ? _self.syllable : syllable // ignore: cast_nullable_to_non_nullable
as String,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as String,finalPart: null == finalPart ? _self.finalPart : finalPart // ignore: cast_nullable_to_non_nullable
as String,tones: null == tones ? _self.tones : tones // ignore: cast_nullable_to_non_nullable
as Map<int, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Syllable].
extension SyllablePatterns on Syllable {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Syllable value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Syllable() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Syllable value)  $default,){
final _that = this;
switch (_that) {
case _Syllable():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Syllable value)?  $default,){
final _that = this;
switch (_that) {
case _Syllable() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String syllable,  String initial,  String finalPart,  Map<int, String> tones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Syllable() when $default != null:
return $default(_that.syllable,_that.initial,_that.finalPart,_that.tones);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String syllable,  String initial,  String finalPart,  Map<int, String> tones)  $default,) {final _that = this;
switch (_that) {
case _Syllable():
return $default(_that.syllable,_that.initial,_that.finalPart,_that.tones);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String syllable,  String initial,  String finalPart,  Map<int, String> tones)?  $default,) {final _that = this;
switch (_that) {
case _Syllable() when $default != null:
return $default(_that.syllable,_that.initial,_that.finalPart,_that.tones);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Syllable extends Syllable {
  const _Syllable({required this.syllable, required this.initial, required this.finalPart, required final  Map<int, String> tones}): _tones = tones,super._();
  factory _Syllable.fromJson(Map<String, dynamic> json) => _$SyllableFromJson(json);

/// Cách viết không dấu: "zhang", "nü", "yue".
@override final  String syllable;
/// Thanh mẫu ("" nếu không có).
@override final  String initial;
/// Vận mẫu gốc theo bảng ("ü", "iu", "ui"...).
@override final  String finalPart;
/// Thanh (1..4) → chữ Hán đại diện để phát âm.
 final  Map<int, String> _tones;
/// Thanh (1..4) → chữ Hán đại diện để phát âm.
@override Map<int, String> get tones {
  if (_tones is EqualUnmodifiableMapView) return _tones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tones);
}


/// Create a copy of Syllable
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyllableCopyWith<_Syllable> get copyWith => __$SyllableCopyWithImpl<_Syllable>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyllableToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Syllable&&(identical(other.syllable, syllable) || other.syllable == syllable)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.finalPart, finalPart) || other.finalPart == finalPart)&&const DeepCollectionEquality().equals(other._tones, _tones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,syllable,initial,finalPart,const DeepCollectionEquality().hash(_tones));

@override
String toString() {
  return 'Syllable(syllable: $syllable, initial: $initial, finalPart: $finalPart, tones: $tones)';
}


}

/// @nodoc
abstract mixin class _$SyllableCopyWith<$Res> implements $SyllableCopyWith<$Res> {
  factory _$SyllableCopyWith(_Syllable value, $Res Function(_Syllable) _then) = __$SyllableCopyWithImpl;
@override @useResult
$Res call({
 String syllable, String initial, String finalPart, Map<int, String> tones
});




}
/// @nodoc
class __$SyllableCopyWithImpl<$Res>
    implements _$SyllableCopyWith<$Res> {
  __$SyllableCopyWithImpl(this._self, this._then);

  final _Syllable _self;
  final $Res Function(_Syllable) _then;

/// Create a copy of Syllable
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? syllable = null,Object? initial = null,Object? finalPart = null,Object? tones = null,}) {
  return _then(_Syllable(
syllable: null == syllable ? _self.syllable : syllable // ignore: cast_nullable_to_non_nullable
as String,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as String,finalPart: null == finalPart ? _self.finalPart : finalPart // ignore: cast_nullable_to_non_nullable
as String,tones: null == tones ? _self._tones : tones // ignore: cast_nullable_to_non_nullable
as Map<int, String>,
  ));
}


}


/// @nodoc
mixin _$TonePairWord {

 String get hanzi; String get pinyin; String get vi;
/// Create a copy of TonePairWord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonePairWordCopyWith<TonePairWord> get copyWith => _$TonePairWordCopyWithImpl<TonePairWord>(this as TonePairWord, _$identity);

  /// Serializes this TonePairWord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonePairWord&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.vi, vi) || other.vi == vi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hanzi,pinyin,vi);

@override
String toString() {
  return 'TonePairWord(hanzi: $hanzi, pinyin: $pinyin, vi: $vi)';
}


}

/// @nodoc
abstract mixin class $TonePairWordCopyWith<$Res>  {
  factory $TonePairWordCopyWith(TonePairWord value, $Res Function(TonePairWord) _then) = _$TonePairWordCopyWithImpl;
@useResult
$Res call({
 String hanzi, String pinyin, String vi
});




}
/// @nodoc
class _$TonePairWordCopyWithImpl<$Res>
    implements $TonePairWordCopyWith<$Res> {
  _$TonePairWordCopyWithImpl(this._self, this._then);

  final TonePairWord _self;
  final $Res Function(TonePairWord) _then;

/// Create a copy of TonePairWord
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


/// Adds pattern-matching-related methods to [TonePairWord].
extension TonePairWordPatterns on TonePairWord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TonePairWord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TonePairWord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TonePairWord value)  $default,){
final _that = this;
switch (_that) {
case _TonePairWord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TonePairWord value)?  $default,){
final _that = this;
switch (_that) {
case _TonePairWord() when $default != null:
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
case _TonePairWord() when $default != null:
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
case _TonePairWord():
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
case _TonePairWord() when $default != null:
return $default(_that.hanzi,_that.pinyin,_that.vi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TonePairWord implements TonePairWord {
  const _TonePairWord({required this.hanzi, required this.pinyin, required this.vi});
  factory _TonePairWord.fromJson(Map<String, dynamic> json) => _$TonePairWordFromJson(json);

@override final  String hanzi;
@override final  String pinyin;
@override final  String vi;

/// Create a copy of TonePairWord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TonePairWordCopyWith<_TonePairWord> get copyWith => __$TonePairWordCopyWithImpl<_TonePairWord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TonePairWordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TonePairWord&&(identical(other.hanzi, hanzi) || other.hanzi == hanzi)&&(identical(other.pinyin, pinyin) || other.pinyin == pinyin)&&(identical(other.vi, vi) || other.vi == vi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hanzi,pinyin,vi);

@override
String toString() {
  return 'TonePairWord(hanzi: $hanzi, pinyin: $pinyin, vi: $vi)';
}


}

/// @nodoc
abstract mixin class _$TonePairWordCopyWith<$Res> implements $TonePairWordCopyWith<$Res> {
  factory _$TonePairWordCopyWith(_TonePairWord value, $Res Function(_TonePairWord) _then) = __$TonePairWordCopyWithImpl;
@override @useResult
$Res call({
 String hanzi, String pinyin, String vi
});




}
/// @nodoc
class __$TonePairWordCopyWithImpl<$Res>
    implements _$TonePairWordCopyWith<$Res> {
  __$TonePairWordCopyWithImpl(this._self, this._then);

  final _TonePairWord _self;
  final $Res Function(_TonePairWord) _then;

/// Create a copy of TonePairWord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hanzi = null,Object? pinyin = null,Object? vi = null,}) {
  return _then(_TonePairWord(
hanzi: null == hanzi ? _self.hanzi : hanzi // ignore: cast_nullable_to_non_nullable
as String,pinyin: null == pinyin ? _self.pinyin : pinyin // ignore: cast_nullable_to_non_nullable
as String,vi: null == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ConfusableGroup {

 String get id; String get title; String get tipVi; List<List<String>> get items;
/// Create a copy of ConfusableGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfusableGroupCopyWith<ConfusableGroup> get copyWith => _$ConfusableGroupCopyWithImpl<ConfusableGroup>(this as ConfusableGroup, _$identity);

  /// Serializes this ConfusableGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfusableGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.tipVi, tipVi) || other.tipVi == tipVi)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,tipVi,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ConfusableGroup(id: $id, title: $title, tipVi: $tipVi, items: $items)';
}


}

/// @nodoc
abstract mixin class $ConfusableGroupCopyWith<$Res>  {
  factory $ConfusableGroupCopyWith(ConfusableGroup value, $Res Function(ConfusableGroup) _then) = _$ConfusableGroupCopyWithImpl;
@useResult
$Res call({
 String id, String title, String tipVi, List<List<String>> items
});




}
/// @nodoc
class _$ConfusableGroupCopyWithImpl<$Res>
    implements $ConfusableGroupCopyWith<$Res> {
  _$ConfusableGroupCopyWithImpl(this._self, this._then);

  final ConfusableGroup _self;
  final $Res Function(ConfusableGroup) _then;

/// Create a copy of ConfusableGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? tipVi = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tipVi: null == tipVi ? _self.tipVi : tipVi // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<List<String>>,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfusableGroup].
extension ConfusableGroupPatterns on ConfusableGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfusableGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfusableGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfusableGroup value)  $default,){
final _that = this;
switch (_that) {
case _ConfusableGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfusableGroup value)?  $default,){
final _that = this;
switch (_that) {
case _ConfusableGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String tipVi,  List<List<String>> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfusableGroup() when $default != null:
return $default(_that.id,_that.title,_that.tipVi,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String tipVi,  List<List<String>> items)  $default,) {final _that = this;
switch (_that) {
case _ConfusableGroup():
return $default(_that.id,_that.title,_that.tipVi,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String tipVi,  List<List<String>> items)?  $default,) {final _that = this;
switch (_that) {
case _ConfusableGroup() when $default != null:
return $default(_that.id,_that.title,_that.tipVi,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfusableGroup implements ConfusableGroup {
  const _ConfusableGroup({required this.id, required this.title, required this.tipVi, required final  List<List<String>> items}): _items = items;
  factory _ConfusableGroup.fromJson(Map<String, dynamic> json) => _$ConfusableGroupFromJson(json);

@override final  String id;
@override final  String title;
@override final  String tipVi;
 final  List<List<String>> _items;
@override List<List<String>> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ConfusableGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfusableGroupCopyWith<_ConfusableGroup> get copyWith => __$ConfusableGroupCopyWithImpl<_ConfusableGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfusableGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfusableGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.tipVi, tipVi) || other.tipVi == tipVi)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,tipVi,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ConfusableGroup(id: $id, title: $title, tipVi: $tipVi, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ConfusableGroupCopyWith<$Res> implements $ConfusableGroupCopyWith<$Res> {
  factory _$ConfusableGroupCopyWith(_ConfusableGroup value, $Res Function(_ConfusableGroup) _then) = __$ConfusableGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String tipVi, List<List<String>> items
});




}
/// @nodoc
class __$ConfusableGroupCopyWithImpl<$Res>
    implements _$ConfusableGroupCopyWith<$Res> {
  __$ConfusableGroupCopyWithImpl(this._self, this._then);

  final _ConfusableGroup _self;
  final $Res Function(_ConfusableGroup) _then;

/// Create a copy of ConfusableGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? tipVi = null,Object? items = null,}) {
  return _then(_ConfusableGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tipVi: null == tipVi ? _self.tipVi : tipVi // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<List<String>>,
  ));
}


}


/// @nodoc
mixin _$PronunciationDrills {

 List<TonePairWord> get tonePairs; List<ConfusableGroup> get confusables;
/// Create a copy of PronunciationDrills
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PronunciationDrillsCopyWith<PronunciationDrills> get copyWith => _$PronunciationDrillsCopyWithImpl<PronunciationDrills>(this as PronunciationDrills, _$identity);

  /// Serializes this PronunciationDrills to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PronunciationDrills&&const DeepCollectionEquality().equals(other.tonePairs, tonePairs)&&const DeepCollectionEquality().equals(other.confusables, confusables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tonePairs),const DeepCollectionEquality().hash(confusables));

@override
String toString() {
  return 'PronunciationDrills(tonePairs: $tonePairs, confusables: $confusables)';
}


}

/// @nodoc
abstract mixin class $PronunciationDrillsCopyWith<$Res>  {
  factory $PronunciationDrillsCopyWith(PronunciationDrills value, $Res Function(PronunciationDrills) _then) = _$PronunciationDrillsCopyWithImpl;
@useResult
$Res call({
 List<TonePairWord> tonePairs, List<ConfusableGroup> confusables
});




}
/// @nodoc
class _$PronunciationDrillsCopyWithImpl<$Res>
    implements $PronunciationDrillsCopyWith<$Res> {
  _$PronunciationDrillsCopyWithImpl(this._self, this._then);

  final PronunciationDrills _self;
  final $Res Function(PronunciationDrills) _then;

/// Create a copy of PronunciationDrills
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tonePairs = null,Object? confusables = null,}) {
  return _then(_self.copyWith(
tonePairs: null == tonePairs ? _self.tonePairs : tonePairs // ignore: cast_nullable_to_non_nullable
as List<TonePairWord>,confusables: null == confusables ? _self.confusables : confusables // ignore: cast_nullable_to_non_nullable
as List<ConfusableGroup>,
  ));
}

}


/// Adds pattern-matching-related methods to [PronunciationDrills].
extension PronunciationDrillsPatterns on PronunciationDrills {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PronunciationDrills value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PronunciationDrills() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PronunciationDrills value)  $default,){
final _that = this;
switch (_that) {
case _PronunciationDrills():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PronunciationDrills value)?  $default,){
final _that = this;
switch (_that) {
case _PronunciationDrills() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TonePairWord> tonePairs,  List<ConfusableGroup> confusables)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PronunciationDrills() when $default != null:
return $default(_that.tonePairs,_that.confusables);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TonePairWord> tonePairs,  List<ConfusableGroup> confusables)  $default,) {final _that = this;
switch (_that) {
case _PronunciationDrills():
return $default(_that.tonePairs,_that.confusables);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TonePairWord> tonePairs,  List<ConfusableGroup> confusables)?  $default,) {final _that = this;
switch (_that) {
case _PronunciationDrills() when $default != null:
return $default(_that.tonePairs,_that.confusables);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PronunciationDrills implements PronunciationDrills {
  const _PronunciationDrills({required final  List<TonePairWord> tonePairs, required final  List<ConfusableGroup> confusables}): _tonePairs = tonePairs,_confusables = confusables;
  factory _PronunciationDrills.fromJson(Map<String, dynamic> json) => _$PronunciationDrillsFromJson(json);

 final  List<TonePairWord> _tonePairs;
@override List<TonePairWord> get tonePairs {
  if (_tonePairs is EqualUnmodifiableListView) return _tonePairs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tonePairs);
}

 final  List<ConfusableGroup> _confusables;
@override List<ConfusableGroup> get confusables {
  if (_confusables is EqualUnmodifiableListView) return _confusables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_confusables);
}


/// Create a copy of PronunciationDrills
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PronunciationDrillsCopyWith<_PronunciationDrills> get copyWith => __$PronunciationDrillsCopyWithImpl<_PronunciationDrills>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PronunciationDrillsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PronunciationDrills&&const DeepCollectionEquality().equals(other._tonePairs, _tonePairs)&&const DeepCollectionEquality().equals(other._confusables, _confusables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tonePairs),const DeepCollectionEquality().hash(_confusables));

@override
String toString() {
  return 'PronunciationDrills(tonePairs: $tonePairs, confusables: $confusables)';
}


}

/// @nodoc
abstract mixin class _$PronunciationDrillsCopyWith<$Res> implements $PronunciationDrillsCopyWith<$Res> {
  factory _$PronunciationDrillsCopyWith(_PronunciationDrills value, $Res Function(_PronunciationDrills) _then) = __$PronunciationDrillsCopyWithImpl;
@override @useResult
$Res call({
 List<TonePairWord> tonePairs, List<ConfusableGroup> confusables
});




}
/// @nodoc
class __$PronunciationDrillsCopyWithImpl<$Res>
    implements _$PronunciationDrillsCopyWith<$Res> {
  __$PronunciationDrillsCopyWithImpl(this._self, this._then);

  final _PronunciationDrills _self;
  final $Res Function(_PronunciationDrills) _then;

/// Create a copy of PronunciationDrills
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tonePairs = null,Object? confusables = null,}) {
  return _then(_PronunciationDrills(
tonePairs: null == tonePairs ? _self._tonePairs : tonePairs // ignore: cast_nullable_to_non_nullable
as List<TonePairWord>,confusables: null == confusables ? _self._confusables : confusables // ignore: cast_nullable_to_non_nullable
as List<ConfusableGroup>,
  ));
}


}

// dart format on
