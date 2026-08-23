// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalX _$GoalXFromJson(Map<String, dynamic> json) => _GoalX(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String,
  category: CategoryX.fromJson(json['category'] as Map<String, dynamic>),
  percentageCompleted: (json['percentageCompleted'] as num?)?.toDouble(),
  details: json['details'] as String?,
  type: $enumDecode(_$GoalTypeEnumMap, json['type']),
  isCompleted: json['isCompleted'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$GoalXToJson(_GoalX instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'category': instance.category,
  'percentageCompleted': instance.percentageCompleted,
  'details': instance.details,
  'type': _$GoalTypeEnumMap[instance.type]!,
  'isCompleted': instance.isCompleted,
  'createdAt': instance.createdAt?.toIso8601String(),
};

const _$GoalTypeEnumMap = {
  GoalType.monthly: 'monthly',
  GoalType.weekly: 'weekly',
};
