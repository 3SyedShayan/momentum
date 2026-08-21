part of '../goal.dart';

class _GoalFormData {
  // static Map<String, dynamic> initialCategoryValues() {
  //   if (!kDebugMode) return {};
  //   return {
  //     _CategoryFormKeys.title: 'Fitness',
  //     _CategoryFormKeys.color: '0xFF4CAF50',
  //   };
  // }

  static Map<String, dynamic> initialGoalValues() {
    if (!kDebugMode) return {};
    return {
      _GoalFormKeys.title: 'Workout 4x a week',
      _GoalFormKeys.type: GoalType.weekly,
      _GoalFormKeys.targetSessions: '4',
    };
  }
}
