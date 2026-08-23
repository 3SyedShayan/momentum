// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalX {

 int? get id; String get title; CategoryX get category; double? get percentageCompleted; String? get details; GoalType get type; bool? get isCompleted; DateTime? get createdAt;
/// Create a copy of GoalX
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalXCopyWith<GoalX> get copyWith => _$GoalXCopyWithImpl<GoalX>(this as GoalX, _$identity);

  /// Serializes this GoalX to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalX&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.percentageCompleted, percentageCompleted) || other.percentageCompleted == percentageCompleted)&&(identical(other.details, details) || other.details == details)&&(identical(other.type, type) || other.type == type)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,percentageCompleted,details,type,isCompleted,createdAt);

@override
String toString() {
  return 'GoalX(id: $id, title: $title, category: $category, percentageCompleted: $percentageCompleted, details: $details, type: $type, isCompleted: $isCompleted, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $GoalXCopyWith<$Res>  {
  factory $GoalXCopyWith(GoalX value, $Res Function(GoalX) _then) = _$GoalXCopyWithImpl;
@useResult
$Res call({
 int? id, String title, CategoryX category, double? percentageCompleted, String? details, GoalType type, bool? isCompleted, DateTime? createdAt
});


$CategoryXCopyWith<$Res> get category;

}
/// @nodoc
class _$GoalXCopyWithImpl<$Res>
    implements $GoalXCopyWith<$Res> {
  _$GoalXCopyWithImpl(this._self, this._then);

  final GoalX _self;
  final $Res Function(GoalX) _then;

/// Create a copy of GoalX
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? category = null,Object? percentageCompleted = freezed,Object? details = freezed,Object? type = null,Object? isCompleted = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryX,percentageCompleted: freezed == percentageCompleted ? _self.percentageCompleted : percentageCompleted // ignore: cast_nullable_to_non_nullable
as double?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,isCompleted: freezed == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of GoalX
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryXCopyWith<$Res> get category {
  
  return $CategoryXCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [GoalX].
extension GoalXPatterns on GoalX {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalX value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalX() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalX value)  $default,){
final _that = this;
switch (_that) {
case _GoalX():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalX value)?  $default,){
final _that = this;
switch (_that) {
case _GoalX() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String title,  CategoryX category,  double? percentageCompleted,  String? details,  GoalType type,  bool? isCompleted,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalX() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.percentageCompleted,_that.details,_that.type,_that.isCompleted,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String title,  CategoryX category,  double? percentageCompleted,  String? details,  GoalType type,  bool? isCompleted,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _GoalX():
return $default(_that.id,_that.title,_that.category,_that.percentageCompleted,_that.details,_that.type,_that.isCompleted,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String title,  CategoryX category,  double? percentageCompleted,  String? details,  GoalType type,  bool? isCompleted,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _GoalX() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.percentageCompleted,_that.details,_that.type,_that.isCompleted,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalX implements GoalX {
  const _GoalX({this.id, required this.title, required this.category, this.percentageCompleted, this.details, required this.type, this.isCompleted, this.createdAt});
  factory _GoalX.fromJson(Map<String, dynamic> json) => _$GoalXFromJson(json);

@override final  int? id;
@override final  String title;
@override final  CategoryX category;
@override final  double? percentageCompleted;
@override final  String? details;
@override final  GoalType type;
@override final  bool? isCompleted;
@override final  DateTime? createdAt;

/// Create a copy of GoalX
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalXCopyWith<_GoalX> get copyWith => __$GoalXCopyWithImpl<_GoalX>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalXToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalX&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.percentageCompleted, percentageCompleted) || other.percentageCompleted == percentageCompleted)&&(identical(other.details, details) || other.details == details)&&(identical(other.type, type) || other.type == type)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,percentageCompleted,details,type,isCompleted,createdAt);

@override
String toString() {
  return 'GoalX(id: $id, title: $title, category: $category, percentageCompleted: $percentageCompleted, details: $details, type: $type, isCompleted: $isCompleted, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GoalXCopyWith<$Res> implements $GoalXCopyWith<$Res> {
  factory _$GoalXCopyWith(_GoalX value, $Res Function(_GoalX) _then) = __$GoalXCopyWithImpl;
@override @useResult
$Res call({
 int? id, String title, CategoryX category, double? percentageCompleted, String? details, GoalType type, bool? isCompleted, DateTime? createdAt
});


@override $CategoryXCopyWith<$Res> get category;

}
/// @nodoc
class __$GoalXCopyWithImpl<$Res>
    implements _$GoalXCopyWith<$Res> {
  __$GoalXCopyWithImpl(this._self, this._then);

  final _GoalX _self;
  final $Res Function(_GoalX) _then;

/// Create a copy of GoalX
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? category = null,Object? percentageCompleted = freezed,Object? details = freezed,Object? type = null,Object? isCompleted = freezed,Object? createdAt = freezed,}) {
  return _then(_GoalX(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryX,percentageCompleted: freezed == percentageCompleted ? _self.percentageCompleted : percentageCompleted // ignore: cast_nullable_to_non_nullable
as double?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,isCompleted: freezed == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of GoalX
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryXCopyWith<$Res> get category {
  
  return $CategoryXCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}

// dart format on
