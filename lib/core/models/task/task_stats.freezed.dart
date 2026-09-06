// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DayTaskStats {

 double get completionPercentage; double get plannedHours; double get completedHours; double get remainingHours;
/// Create a copy of DayTaskStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayTaskStatsCopyWith<DayTaskStats> get copyWith => _$DayTaskStatsCopyWithImpl<DayTaskStats>(this as DayTaskStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayTaskStats&&(identical(other.completionPercentage, completionPercentage) || other.completionPercentage == completionPercentage)&&(identical(other.plannedHours, plannedHours) || other.plannedHours == plannedHours)&&(identical(other.completedHours, completedHours) || other.completedHours == completedHours)&&(identical(other.remainingHours, remainingHours) || other.remainingHours == remainingHours));
}


@override
int get hashCode => Object.hash(runtimeType,completionPercentage,plannedHours,completedHours,remainingHours);

@override
String toString() {
  return 'DayTaskStats(completionPercentage: $completionPercentage, plannedHours: $plannedHours, completedHours: $completedHours, remainingHours: $remainingHours)';
}


}

/// @nodoc
abstract mixin class $DayTaskStatsCopyWith<$Res>  {
  factory $DayTaskStatsCopyWith(DayTaskStats value, $Res Function(DayTaskStats) _then) = _$DayTaskStatsCopyWithImpl;
@useResult
$Res call({
 double completionPercentage, double plannedHours, double completedHours, double remainingHours
});




}
/// @nodoc
class _$DayTaskStatsCopyWithImpl<$Res>
    implements $DayTaskStatsCopyWith<$Res> {
  _$DayTaskStatsCopyWithImpl(this._self, this._then);

  final DayTaskStats _self;
  final $Res Function(DayTaskStats) _then;

/// Create a copy of DayTaskStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completionPercentage = null,Object? plannedHours = null,Object? completedHours = null,Object? remainingHours = null,}) {
  return _then(_self.copyWith(
completionPercentage: null == completionPercentage ? _self.completionPercentage : completionPercentage // ignore: cast_nullable_to_non_nullable
as double,plannedHours: null == plannedHours ? _self.plannedHours : plannedHours // ignore: cast_nullable_to_non_nullable
as double,completedHours: null == completedHours ? _self.completedHours : completedHours // ignore: cast_nullable_to_non_nullable
as double,remainingHours: null == remainingHours ? _self.remainingHours : remainingHours // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DayTaskStats].
extension DayTaskStatsPatterns on DayTaskStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayTaskStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayTaskStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayTaskStats value)  $default,){
final _that = this;
switch (_that) {
case _DayTaskStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayTaskStats value)?  $default,){
final _that = this;
switch (_that) {
case _DayTaskStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double completionPercentage,  double plannedHours,  double completedHours,  double remainingHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayTaskStats() when $default != null:
return $default(_that.completionPercentage,_that.plannedHours,_that.completedHours,_that.remainingHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double completionPercentage,  double plannedHours,  double completedHours,  double remainingHours)  $default,) {final _that = this;
switch (_that) {
case _DayTaskStats():
return $default(_that.completionPercentage,_that.plannedHours,_that.completedHours,_that.remainingHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double completionPercentage,  double plannedHours,  double completedHours,  double remainingHours)?  $default,) {final _that = this;
switch (_that) {
case _DayTaskStats() when $default != null:
return $default(_that.completionPercentage,_that.plannedHours,_that.completedHours,_that.remainingHours);case _:
  return null;

}
}

}

/// @nodoc


class _DayTaskStats implements DayTaskStats {
  const _DayTaskStats({this.completionPercentage = 0.0, this.plannedHours = 0.0, this.completedHours = 0.0, this.remainingHours = 0.0});
  

@override@JsonKey() final  double completionPercentage;
@override@JsonKey() final  double plannedHours;
@override@JsonKey() final  double completedHours;
@override@JsonKey() final  double remainingHours;

/// Create a copy of DayTaskStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayTaskStatsCopyWith<_DayTaskStats> get copyWith => __$DayTaskStatsCopyWithImpl<_DayTaskStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayTaskStats&&(identical(other.completionPercentage, completionPercentage) || other.completionPercentage == completionPercentage)&&(identical(other.plannedHours, plannedHours) || other.plannedHours == plannedHours)&&(identical(other.completedHours, completedHours) || other.completedHours == completedHours)&&(identical(other.remainingHours, remainingHours) || other.remainingHours == remainingHours));
}


@override
int get hashCode => Object.hash(runtimeType,completionPercentage,plannedHours,completedHours,remainingHours);

@override
String toString() {
  return 'DayTaskStats(completionPercentage: $completionPercentage, plannedHours: $plannedHours, completedHours: $completedHours, remainingHours: $remainingHours)';
}


}

/// @nodoc
abstract mixin class _$DayTaskStatsCopyWith<$Res> implements $DayTaskStatsCopyWith<$Res> {
  factory _$DayTaskStatsCopyWith(_DayTaskStats value, $Res Function(_DayTaskStats) _then) = __$DayTaskStatsCopyWithImpl;
@override @useResult
$Res call({
 double completionPercentage, double plannedHours, double completedHours, double remainingHours
});




}
/// @nodoc
class __$DayTaskStatsCopyWithImpl<$Res>
    implements _$DayTaskStatsCopyWith<$Res> {
  __$DayTaskStatsCopyWithImpl(this._self, this._then);

  final _DayTaskStats _self;
  final $Res Function(_DayTaskStats) _then;

/// Create a copy of DayTaskStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completionPercentage = null,Object? plannedHours = null,Object? completedHours = null,Object? remainingHours = null,}) {
  return _then(_DayTaskStats(
completionPercentage: null == completionPercentage ? _self.completionPercentage : completionPercentage // ignore: cast_nullable_to_non_nullable
as double,plannedHours: null == plannedHours ? _self.plannedHours : plannedHours // ignore: cast_nullable_to_non_nullable
as double,completedHours: null == completedHours ? _self.completedHours : completedHours // ignore: cast_nullable_to_non_nullable
as double,remainingHours: null == remainingHours ? _self.remainingHours : remainingHours // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
