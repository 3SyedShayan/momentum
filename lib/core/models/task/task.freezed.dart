// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskX {

 int get id; String get title; String? get description; DateTime get startTime; DateTime get endTime; bool get isCompleted; CategoryX get category;
/// Create a copy of TaskX
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskXCopyWith<TaskX> get copyWith => _$TaskXCopyWithImpl<TaskX>(this as TaskX, _$identity);

  /// Serializes this TaskX to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskX&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,startTime,endTime,isCompleted,category);

@override
String toString() {
  return 'TaskX(id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted, category: $category)';
}


}

/// @nodoc
abstract mixin class $TaskXCopyWith<$Res>  {
  factory $TaskXCopyWith(TaskX value, $Res Function(TaskX) _then) = _$TaskXCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description, DateTime startTime, DateTime endTime, bool isCompleted, CategoryX category
});


$CategoryXCopyWith<$Res> get category;

}
/// @nodoc
class _$TaskXCopyWithImpl<$Res>
    implements $TaskXCopyWith<$Res> {
  _$TaskXCopyWithImpl(this._self, this._then);

  final TaskX _self;
  final $Res Function(TaskX) _then;

/// Create a copy of TaskX
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? isCompleted = null,Object? category = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryX,
  ));
}
/// Create a copy of TaskX
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryXCopyWith<$Res> get category {
  
  return $CategoryXCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskX].
extension TaskXPatterns on TaskX {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskX value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskX() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskX value)  $default,){
final _that = this;
switch (_that) {
case _TaskX():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskX value)?  $default,){
final _that = this;
switch (_that) {
case _TaskX() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? description,  DateTime startTime,  DateTime endTime,  bool isCompleted,  CategoryX category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskX() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.startTime,_that.endTime,_that.isCompleted,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? description,  DateTime startTime,  DateTime endTime,  bool isCompleted,  CategoryX category)  $default,) {final _that = this;
switch (_that) {
case _TaskX():
return $default(_that.id,_that.title,_that.description,_that.startTime,_that.endTime,_that.isCompleted,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? description,  DateTime startTime,  DateTime endTime,  bool isCompleted,  CategoryX category)?  $default,) {final _that = this;
switch (_that) {
case _TaskX() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.startTime,_that.endTime,_that.isCompleted,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskX implements TaskX {
  const _TaskX({required this.id, required this.title, this.description, required this.startTime, required this.endTime, required this.isCompleted, required this.category});
  factory _TaskX.fromJson(Map<String, dynamic> json) => _$TaskXFromJson(json);

@override final  int id;
@override final  String title;
@override final  String? description;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  bool isCompleted;
@override final  CategoryX category;

/// Create a copy of TaskX
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskXCopyWith<_TaskX> get copyWith => __$TaskXCopyWithImpl<_TaskX>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskXToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskX&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,startTime,endTime,isCompleted,category);

@override
String toString() {
  return 'TaskX(id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted, category: $category)';
}


}

/// @nodoc
abstract mixin class _$TaskXCopyWith<$Res> implements $TaskXCopyWith<$Res> {
  factory _$TaskXCopyWith(_TaskX value, $Res Function(_TaskX) _then) = __$TaskXCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description, DateTime startTime, DateTime endTime, bool isCompleted, CategoryX category
});


@override $CategoryXCopyWith<$Res> get category;

}
/// @nodoc
class __$TaskXCopyWithImpl<$Res>
    implements _$TaskXCopyWith<$Res> {
  __$TaskXCopyWithImpl(this._self, this._then);

  final _TaskX _self;
  final $Res Function(_TaskX) _then;

/// Create a copy of TaskX
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? isCompleted = null,Object? category = null,}) {
  return _then(_TaskX(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryX,
  ));
}

/// Create a copy of TaskX
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
