// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskX _$TaskXFromJson(Map<String, dynamic> json) => _TaskX(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  isCompleted: json['isCompleted'] as bool,
  category: CategoryX.fromJson(json['category'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TaskXToJson(_TaskX instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'isCompleted': instance.isCompleted,
  'category': instance.category,
};
