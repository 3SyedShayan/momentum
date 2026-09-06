part of '../progress.dart';

sealed class ProgressColors {
  /// Heatmap intensity level colors: Level 0 (lowest) to Level 3 (highest)
  static const List<Color> heatmapLevels = [
    Color(0xFFF1F5F9), // Level 0: Rest / none
    Color(0xFFBFDBFE), // Level 1: Light
    Color(0xFF60A5FA), // Level 2: Moderate
    Color(0xFF2563EB), // Level 3: Intense / Completed
  ];

  static const streakOrange = Color(0xFFF97316);
  static const thisWeekBlue = Color(0xFF2563EB);
  static const thisMonthEmerald = Color(0xFF059669);

  static const reflectionStart = Color(0xFFFAF5FF);
  static const reflectionEnd = Color(0xFFEFF6FF);
  static const reflectionBorder = Color(0xFFEDE9FE);
  static const reflectionIconBox = Color(0xFFEDE9FE);
  static const reflectionPrimary = Color(0xFF7C3AED);
}
