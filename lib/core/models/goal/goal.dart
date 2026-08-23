import 'package:freezed_annotation/freezed_annotation.dart';
import '../category/category.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

enum GoalType { monthly, weekly }

@freezed
abstract class GoalX with _$GoalX {
  const factory GoalX({
    int? id,
    required String title,
    required CategoryX category,
    double? percentageCompleted,
    String? details,
    required GoalType type,
    bool? isCompleted,
    DateTime? createdAt,
  }) = _GoalX;

  factory GoalX.fromJson(Map<String, dynamic> json) => _$GoalXFromJson(json);
}
