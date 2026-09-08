part of '../goal.dart';

class _GoalFormData {
  static Map<String, dynamic> initialCategoryValues() {
    return {};
  }

  static Map<String, dynamic> initialGoalValues() {
    return {
      _GoalFormKeys.type: GoalType.weekly.name,
    };
  }
}
