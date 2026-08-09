// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryX _$CategoryXFromJson(Map<String, dynamic> json) => _CategoryX(
  id: json['id'] as String?,
  name: json['name'] as String,
  icon: json['icon'] as String,
  color: (json['color'] as num).toInt(),
);

Map<String, dynamic> _$CategoryXToJson(_CategoryX instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
    };
