import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String categoryId;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;
  final int durationPlanned; // in minutes
  final int durationCompleted; // in minutes

  TaskModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
    required this.durationPlanned,
    required this.durationCompleted,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, String id) {
    return TaskModel(
      id: id,
      title: map['title'] ?? '',
      categoryId: map['categoryId'] ?? '',
      startTime: (map['startTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endTime: (map['endTime'] as Timestamp?)?.toDate() ?? DateTime.now().add(const Duration(hours: 1)),
      isCompleted: map['isCompleted'] ?? false,
      durationPlanned: map['durationPlanned'] ?? 60,
      durationCompleted: map['durationCompleted'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'categoryId': categoryId,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'isCompleted': isCompleted,
      'durationPlanned': durationPlanned,
      'durationCompleted': durationCompleted,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? categoryId,
    DateTime? startTime,
    DateTime? endTime,
    bool? isCompleted,
    int? durationPlanned,
    int? durationCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isCompleted: isCompleted ?? this.isCompleted,
      durationPlanned: durationPlanned ?? this.durationPlanned,
      durationCompleted: durationCompleted ?? this.durationCompleted,
    );
  }
}
