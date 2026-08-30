import 'package:freezed_annotation/freezed_annotation.dart';
import '../category/category.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class TaskX with _$TaskX {
  const factory TaskX({
    int? id,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    required bool isCompleted,
    required CategoryX category,
  }) = _TaskX;

  factory TaskX.fromJson(Map<String, dynamic> json) => _$TaskXFromJson(json);
}
