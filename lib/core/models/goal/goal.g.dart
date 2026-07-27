// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalX _$GoalXFromJson(Map<String, dynamic> json) => _GoalX(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  percentageCompleted: (json['percentageCompleted'] as num?)?.toDouble() ?? 0.0,
  color: (json['color'] as num).toInt(),
  details: json['details'] as String?,
  type: $enumDecode(_$GoalTypeEnumMap, json['type']),
  isCompleted: json['isCompleted'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$GoalXToJson(_GoalX instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'category': instance.category,
  'percentageCompleted': instance.percentageCompleted,
  'color': instance.color,
  'details': instance.details,
  'type': _$GoalTypeEnumMap[instance.type]!,
  'isCompleted': instance.isCompleted,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$GoalTypeEnumMap = {
  GoalType.monthly: 'monthly',
  GoalType.weekly: 'weekly',
};
