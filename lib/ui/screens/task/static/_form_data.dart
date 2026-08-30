part of '../task.dart';

class _TaskFormData {
  static Map<String, dynamic> initialCategoryValues() {
    if (!kDebugMode) return {};
    return {
      _CategoryFormKeys.title: 'Fitness',
      _CategoryFormKeys.color: '0xFF4CAF50',
    };
  }

  static Map<String, dynamic> initialTaskValues() {
    if (!kDebugMode) return {};
    final now = DateTime.now();
    return {
      _TaskFormKeys.title: 'Review Project Roadmap',
      _TaskFormKeys.description:
          'Analyze milestones and prioritize sprint tasks.',
      _TaskFormKeys.startTime: DateTime(now.year, now.month, now.day, 1, 0),
      _TaskFormKeys.endTime: DateTime(now.year, now.month, now.day, 10, 0),
    };
  }
}
