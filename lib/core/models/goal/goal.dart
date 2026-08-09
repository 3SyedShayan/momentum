import 'package:freezed_annotation/freezed_annotation.dart';
import '../category/category.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

enum GoalType { monthly, weekly }

@freezed
abstract class GoalX with _$GoalX {
  const factory GoalX({
    required int id,
    required String title,
    required CategoryX category,
    @Default(0.0) double percentageCompleted,
    required int color,
    String? details,
    required GoalType type,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
  }) = _GoalX;

  factory GoalX.fromJson(Map<String, dynamic> json) => _$GoalXFromJson(json);
}
