// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'srs_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SrsCard {

 int get id; String get wordId; CardSkill get skill; double get stability; double get difficulty; DateTime get due; CardState get state; int? get step; int get reps; int get lapses; DateTime? get lastReview;
/// Create a copy of SrsCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SrsCardCopyWith<SrsCard> get copyWith => _$SrsCardCopyWithImpl<SrsCard>(this as SrsCard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SrsCard&&(identical(other.id, id) || other.id == id)&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.skill, skill) || other.skill == skill)&&(identical(other.stability, stability) || other.stability == stability)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.due, due) || other.due == due)&&(identical(other.state, state) || other.state == state)&&(identical(other.step, step) || other.step == step)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.lapses, lapses) || other.lapses == lapses)&&(identical(other.lastReview, lastReview) || other.lastReview == lastReview));
}


@override
int get hashCode => Object.hash(runtimeType,id,wordId,skill,stability,difficulty,due,state,step,reps,lapses,lastReview);

@override
String toString() {
  return 'SrsCard(id: $id, wordId: $wordId, skill: $skill, stability: $stability, difficulty: $difficulty, due: $due, state: $state, step: $step, reps: $reps, lapses: $lapses, lastReview: $lastReview)';
}


}

/// @nodoc
abstract mixin class $SrsCardCopyWith<$Res>  {
  factory $SrsCardCopyWith(SrsCard value, $Res Function(SrsCard) _then) = _$SrsCardCopyWithImpl;
@useResult
$Res call({
 int id, String wordId, CardSkill skill, double stability, double difficulty, DateTime due, CardState state, int? step, int reps, int lapses, DateTime? lastReview
});




}
/// @nodoc
class _$SrsCardCopyWithImpl<$Res>
    implements $SrsCardCopyWith<$Res> {
  _$SrsCardCopyWithImpl(this._self, this._then);

  final SrsCard _self;
  final $Res Function(SrsCard) _then;

/// Create a copy of SrsCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? wordId = null,Object? skill = null,Object? stability = null,Object? difficulty = null,Object? due = null,Object? state = null,Object? step = freezed,Object? reps = null,Object? lapses = null,Object? lastReview = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,skill: null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as CardSkill,stability: null == stability ? _self.stability : stability // ignore: cast_nullable_to_non_nullable
as double,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as double,due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as DateTime,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CardState,step: freezed == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int?,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,lapses: null == lapses ? _self.lapses : lapses // ignore: cast_nullable_to_non_nullable
as int,lastReview: freezed == lastReview ? _self.lastReview : lastReview // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SrsCard].
extension SrsCardPatterns on SrsCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SrsCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SrsCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SrsCard value)  $default,){
final _that = this;
switch (_that) {
case _SrsCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SrsCard value)?  $default,){
final _that = this;
switch (_that) {
case _SrsCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String wordId,  CardSkill skill,  double stability,  double difficulty,  DateTime due,  CardState state,  int? step,  int reps,  int lapses,  DateTime? lastReview)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SrsCard() when $default != null:
return $default(_that.id,_that.wordId,_that.skill,_that.stability,_that.difficulty,_that.due,_that.state,_that.step,_that.reps,_that.lapses,_that.lastReview);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String wordId,  CardSkill skill,  double stability,  double difficulty,  DateTime due,  CardState state,  int? step,  int reps,  int lapses,  DateTime? lastReview)  $default,) {final _that = this;
switch (_that) {
case _SrsCard():
return $default(_that.id,_that.wordId,_that.skill,_that.stability,_that.difficulty,_that.due,_that.state,_that.step,_that.reps,_that.lapses,_that.lastReview);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String wordId,  CardSkill skill,  double stability,  double difficulty,  DateTime due,  CardState state,  int? step,  int reps,  int lapses,  DateTime? lastReview)?  $default,) {final _that = this;
switch (_that) {
case _SrsCard() when $default != null:
return $default(_that.id,_that.wordId,_that.skill,_that.stability,_that.difficulty,_that.due,_that.state,_that.step,_that.reps,_that.lapses,_that.lastReview);case _:
  return null;

}
}

}

/// @nodoc


class _SrsCard extends SrsCard {
  const _SrsCard({required this.id, required this.wordId, required this.skill, this.stability = 0, this.difficulty = 0, required this.due, this.state = CardState.fresh, this.step, this.reps = 0, this.lapses = 0, this.lastReview}): super._();
  

@override final  int id;
@override final  String wordId;
@override final  CardSkill skill;
@override@JsonKey() final  double stability;
@override@JsonKey() final  double difficulty;
@override final  DateTime due;
@override@JsonKey() final  CardState state;
@override final  int? step;
@override@JsonKey() final  int reps;
@override@JsonKey() final  int lapses;
@override final  DateTime? lastReview;

/// Create a copy of SrsCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SrsCardCopyWith<_SrsCard> get copyWith => __$SrsCardCopyWithImpl<_SrsCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SrsCard&&(identical(other.id, id) || other.id == id)&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.skill, skill) || other.skill == skill)&&(identical(other.stability, stability) || other.stability == stability)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.due, due) || other.due == due)&&(identical(other.state, state) || other.state == state)&&(identical(other.step, step) || other.step == step)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.lapses, lapses) || other.lapses == lapses)&&(identical(other.lastReview, lastReview) || other.lastReview == lastReview));
}


@override
int get hashCode => Object.hash(runtimeType,id,wordId,skill,stability,difficulty,due,state,step,reps,lapses,lastReview);

@override
String toString() {
  return 'SrsCard(id: $id, wordId: $wordId, skill: $skill, stability: $stability, difficulty: $difficulty, due: $due, state: $state, step: $step, reps: $reps, lapses: $lapses, lastReview: $lastReview)';
}


}

/// @nodoc
abstract mixin class _$SrsCardCopyWith<$Res> implements $SrsCardCopyWith<$Res> {
  factory _$SrsCardCopyWith(_SrsCard value, $Res Function(_SrsCard) _then) = __$SrsCardCopyWithImpl;
@override @useResult
$Res call({
 int id, String wordId, CardSkill skill, double stability, double difficulty, DateTime due, CardState state, int? step, int reps, int lapses, DateTime? lastReview
});




}
/// @nodoc
class __$SrsCardCopyWithImpl<$Res>
    implements _$SrsCardCopyWith<$Res> {
  __$SrsCardCopyWithImpl(this._self, this._then);

  final _SrsCard _self;
  final $Res Function(_SrsCard) _then;

/// Create a copy of SrsCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? wordId = null,Object? skill = null,Object? stability = null,Object? difficulty = null,Object? due = null,Object? state = null,Object? step = freezed,Object? reps = null,Object? lapses = null,Object? lastReview = freezed,}) {
  return _then(_SrsCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,skill: null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as CardSkill,stability: null == stability ? _self.stability : stability // ignore: cast_nullable_to_non_nullable
as double,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as double,due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as DateTime,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CardState,step: freezed == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int?,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,lapses: null == lapses ? _self.lapses : lapses // ignore: cast_nullable_to_non_nullable
as int,lastReview: freezed == lastReview ? _self.lastReview : lastReview // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$StudyItem {

 SrsCard get card; Word get word;
/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyItemCopyWith<StudyItem> get copyWith => _$StudyItemCopyWithImpl<StudyItem>(this as StudyItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyItem&&(identical(other.card, card) || other.card == card)&&(identical(other.word, word) || other.word == word));
}


@override
int get hashCode => Object.hash(runtimeType,card,word);

@override
String toString() {
  return 'StudyItem(card: $card, word: $word)';
}


}

/// @nodoc
abstract mixin class $StudyItemCopyWith<$Res>  {
  factory $StudyItemCopyWith(StudyItem value, $Res Function(StudyItem) _then) = _$StudyItemCopyWithImpl;
@useResult
$Res call({
 SrsCard card, Word word
});


$SrsCardCopyWith<$Res> get card;$WordCopyWith<$Res> get word;

}
/// @nodoc
class _$StudyItemCopyWithImpl<$Res>
    implements $StudyItemCopyWith<$Res> {
  _$StudyItemCopyWithImpl(this._self, this._then);

  final StudyItem _self;
  final $Res Function(StudyItem) _then;

/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? card = null,Object? word = null,}) {
  return _then(_self.copyWith(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as SrsCard,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as Word,
  ));
}
/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SrsCardCopyWith<$Res> get card {
  
  return $SrsCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordCopyWith<$Res> get word {
  
  return $WordCopyWith<$Res>(_self.word, (value) {
    return _then(_self.copyWith(word: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudyItem].
extension StudyItemPatterns on StudyItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyItem value)  $default,){
final _that = this;
switch (_that) {
case _StudyItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyItem value)?  $default,){
final _that = this;
switch (_that) {
case _StudyItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SrsCard card,  Word word)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyItem() when $default != null:
return $default(_that.card,_that.word);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SrsCard card,  Word word)  $default,) {final _that = this;
switch (_that) {
case _StudyItem():
return $default(_that.card,_that.word);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SrsCard card,  Word word)?  $default,) {final _that = this;
switch (_that) {
case _StudyItem() when $default != null:
return $default(_that.card,_that.word);case _:
  return null;

}
}

}

/// @nodoc


class _StudyItem implements StudyItem {
  const _StudyItem({required this.card, required this.word});
  

@override final  SrsCard card;
@override final  Word word;

/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyItemCopyWith<_StudyItem> get copyWith => __$StudyItemCopyWithImpl<_StudyItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyItem&&(identical(other.card, card) || other.card == card)&&(identical(other.word, word) || other.word == word));
}


@override
int get hashCode => Object.hash(runtimeType,card,word);

@override
String toString() {
  return 'StudyItem(card: $card, word: $word)';
}


}

/// @nodoc
abstract mixin class _$StudyItemCopyWith<$Res> implements $StudyItemCopyWith<$Res> {
  factory _$StudyItemCopyWith(_StudyItem value, $Res Function(_StudyItem) _then) = __$StudyItemCopyWithImpl;
@override @useResult
$Res call({
 SrsCard card, Word word
});


@override $SrsCardCopyWith<$Res> get card;@override $WordCopyWith<$Res> get word;

}
/// @nodoc
class __$StudyItemCopyWithImpl<$Res>
    implements _$StudyItemCopyWith<$Res> {
  __$StudyItemCopyWithImpl(this._self, this._then);

  final _StudyItem _self;
  final $Res Function(_StudyItem) _then;

/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? card = null,Object? word = null,}) {
  return _then(_StudyItem(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as SrsCard,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as Word,
  ));
}

/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SrsCardCopyWith<$Res> get card {
  
  return $SrsCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}/// Create a copy of StudyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordCopyWith<$Res> get word {
  
  return $WordCopyWith<$Res>(_self.word, (value) {
    return _then(_self.copyWith(word: value));
  });
}
}

/// @nodoc
mixin _$DeckStats {

/// Thẻ đã học và đã đến hạn.
 int get due;/// Thẻ mới còn được phép học hôm nay (đã trừ giới hạn ngày).
 int get newAvailable;/// Thẻ mới đã học hôm nay.
 int get newToday; int get dailyNewLimit;/// Tổng số thẻ trong bộ.
 int get total; int get reviewsToday;
/// Create a copy of DeckStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeckStatsCopyWith<DeckStats> get copyWith => _$DeckStatsCopyWithImpl<DeckStats>(this as DeckStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeckStats&&(identical(other.due, due) || other.due == due)&&(identical(other.newAvailable, newAvailable) || other.newAvailable == newAvailable)&&(identical(other.newToday, newToday) || other.newToday == newToday)&&(identical(other.dailyNewLimit, dailyNewLimit) || other.dailyNewLimit == dailyNewLimit)&&(identical(other.total, total) || other.total == total)&&(identical(other.reviewsToday, reviewsToday) || other.reviewsToday == reviewsToday));
}


@override
int get hashCode => Object.hash(runtimeType,due,newAvailable,newToday,dailyNewLimit,total,reviewsToday);

@override
String toString() {
  return 'DeckStats(due: $due, newAvailable: $newAvailable, newToday: $newToday, dailyNewLimit: $dailyNewLimit, total: $total, reviewsToday: $reviewsToday)';
}


}

/// @nodoc
abstract mixin class $DeckStatsCopyWith<$Res>  {
  factory $DeckStatsCopyWith(DeckStats value, $Res Function(DeckStats) _then) = _$DeckStatsCopyWithImpl;
@useResult
$Res call({
 int due, int newAvailable, int newToday, int dailyNewLimit, int total, int reviewsToday
});




}
/// @nodoc
class _$DeckStatsCopyWithImpl<$Res>
    implements $DeckStatsCopyWith<$Res> {
  _$DeckStatsCopyWithImpl(this._self, this._then);

  final DeckStats _self;
  final $Res Function(DeckStats) _then;

/// Create a copy of DeckStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? due = null,Object? newAvailable = null,Object? newToday = null,Object? dailyNewLimit = null,Object? total = null,Object? reviewsToday = null,}) {
  return _then(_self.copyWith(
due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as int,newAvailable: null == newAvailable ? _self.newAvailable : newAvailable // ignore: cast_nullable_to_non_nullable
as int,newToday: null == newToday ? _self.newToday : newToday // ignore: cast_nullable_to_non_nullable
as int,dailyNewLimit: null == dailyNewLimit ? _self.dailyNewLimit : dailyNewLimit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,reviewsToday: null == reviewsToday ? _self.reviewsToday : reviewsToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DeckStats].
extension DeckStatsPatterns on DeckStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeckStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeckStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeckStats value)  $default,){
final _that = this;
switch (_that) {
case _DeckStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeckStats value)?  $default,){
final _that = this;
switch (_that) {
case _DeckStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int due,  int newAvailable,  int newToday,  int dailyNewLimit,  int total,  int reviewsToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeckStats() when $default != null:
return $default(_that.due,_that.newAvailable,_that.newToday,_that.dailyNewLimit,_that.total,_that.reviewsToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int due,  int newAvailable,  int newToday,  int dailyNewLimit,  int total,  int reviewsToday)  $default,) {final _that = this;
switch (_that) {
case _DeckStats():
return $default(_that.due,_that.newAvailable,_that.newToday,_that.dailyNewLimit,_that.total,_that.reviewsToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int due,  int newAvailable,  int newToday,  int dailyNewLimit,  int total,  int reviewsToday)?  $default,) {final _that = this;
switch (_that) {
case _DeckStats() when $default != null:
return $default(_that.due,_that.newAvailable,_that.newToday,_that.dailyNewLimit,_that.total,_that.reviewsToday);case _:
  return null;

}
}

}

/// @nodoc


class _DeckStats implements DeckStats {
  const _DeckStats({required this.due, required this.newAvailable, required this.newToday, required this.dailyNewLimit, required this.total, required this.reviewsToday});
  

/// Thẻ đã học và đã đến hạn.
@override final  int due;
/// Thẻ mới còn được phép học hôm nay (đã trừ giới hạn ngày).
@override final  int newAvailable;
/// Thẻ mới đã học hôm nay.
@override final  int newToday;
@override final  int dailyNewLimit;
/// Tổng số thẻ trong bộ.
@override final  int total;
@override final  int reviewsToday;

/// Create a copy of DeckStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeckStatsCopyWith<_DeckStats> get copyWith => __$DeckStatsCopyWithImpl<_DeckStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeckStats&&(identical(other.due, due) || other.due == due)&&(identical(other.newAvailable, newAvailable) || other.newAvailable == newAvailable)&&(identical(other.newToday, newToday) || other.newToday == newToday)&&(identical(other.dailyNewLimit, dailyNewLimit) || other.dailyNewLimit == dailyNewLimit)&&(identical(other.total, total) || other.total == total)&&(identical(other.reviewsToday, reviewsToday) || other.reviewsToday == reviewsToday));
}


@override
int get hashCode => Object.hash(runtimeType,due,newAvailable,newToday,dailyNewLimit,total,reviewsToday);

@override
String toString() {
  return 'DeckStats(due: $due, newAvailable: $newAvailable, newToday: $newToday, dailyNewLimit: $dailyNewLimit, total: $total, reviewsToday: $reviewsToday)';
}


}

/// @nodoc
abstract mixin class _$DeckStatsCopyWith<$Res> implements $DeckStatsCopyWith<$Res> {
  factory _$DeckStatsCopyWith(_DeckStats value, $Res Function(_DeckStats) _then) = __$DeckStatsCopyWithImpl;
@override @useResult
$Res call({
 int due, int newAvailable, int newToday, int dailyNewLimit, int total, int reviewsToday
});




}
/// @nodoc
class __$DeckStatsCopyWithImpl<$Res>
    implements _$DeckStatsCopyWith<$Res> {
  __$DeckStatsCopyWithImpl(this._self, this._then);

  final _DeckStats _self;
  final $Res Function(_DeckStats) _then;

/// Create a copy of DeckStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? due = null,Object? newAvailable = null,Object? newToday = null,Object? dailyNewLimit = null,Object? total = null,Object? reviewsToday = null,}) {
  return _then(_DeckStats(
due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as int,newAvailable: null == newAvailable ? _self.newAvailable : newAvailable // ignore: cast_nullable_to_non_nullable
as int,newToday: null == newToday ? _self.newToday : newToday // ignore: cast_nullable_to_non_nullable
as int,dailyNewLimit: null == dailyNewLimit ? _self.dailyNewLimit : dailyNewLimit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,reviewsToday: null == reviewsToday ? _self.reviewsToday : reviewsToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
