// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryX {

 String? get id; String get name; String get icon; int get color;
/// Create a copy of CategoryX
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryXCopyWith<CategoryX> get copyWith => _$CategoryXCopyWithImpl<CategoryX>(this as CategoryX, _$identity);

  /// Serializes this CategoryX to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryX&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,color);

@override
String toString() {
  return 'CategoryX(id: $id, name: $name, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class $CategoryXCopyWith<$Res>  {
  factory $CategoryXCopyWith(CategoryX value, $Res Function(CategoryX) _then) = _$CategoryXCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String icon, int color
});




}
/// @nodoc
class _$CategoryXCopyWithImpl<$Res>
    implements $CategoryXCopyWith<$Res> {
  _$CategoryXCopyWithImpl(this._self, this._then);

  final CategoryX _self;
  final $Res Function(CategoryX) _then;

/// Create a copy of CategoryX
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? icon = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryX].
extension CategoryXPatterns on CategoryX {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryX value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryX() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryX value)  $default,){
final _that = this;
switch (_that) {
case _CategoryX():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryX value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryX() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String icon,  int color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryX() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String icon,  int color)  $default,) {final _that = this;
switch (_that) {
case _CategoryX():
return $default(_that.id,_that.name,_that.icon,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String icon,  int color)?  $default,) {final _that = this;
switch (_that) {
case _CategoryX() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryX implements CategoryX {
  const _CategoryX({required this.id, required this.name, required this.icon, required this.color});
  factory _CategoryX.fromJson(Map<String, dynamic> json) => _$CategoryXFromJson(json);

@override final  String? id;
@override final  String name;
@override final  String icon;
@override final  int color;

/// Create a copy of CategoryX
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryXCopyWith<_CategoryX> get copyWith => __$CategoryXCopyWithImpl<_CategoryX>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryXToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryX&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,color);

@override
String toString() {
  return 'CategoryX(id: $id, name: $name, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class _$CategoryXCopyWith<$Res> implements $CategoryXCopyWith<$Res> {
  factory _$CategoryXCopyWith(_CategoryX value, $Res Function(_CategoryX) _then) = __$CategoryXCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String icon, int color
});




}
/// @nodoc
class __$CategoryXCopyWithImpl<$Res>
    implements _$CategoryXCopyWith<$Res> {
  __$CategoryXCopyWithImpl(this._self, this._then);

  final _CategoryX _self;
  final $Res Function(_CategoryX) _then;

/// Create a copy of CategoryX
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? icon = null,Object? color = null,}) {
  return _then(_CategoryX(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
