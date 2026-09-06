part of '../progress.dart';

class DayProgress {
  final int date;
  final int level;
  final int completed;
  final int total;
  final int focusHours;
  final String summary;

  const DayProgress({
    required this.date,
    required this.level,
    required this.completed,
    required this.total,
    required this.focusHours,
    required this.summary,
  });

  static String getSummaryForLevel(int level) {
    switch (level) {
      case 3:
        return 'Excellent day. Stayed focused and completed nearly everything planned.';
      case 2:
        return 'Good progress today. Completed most of the important tasks.';
      case 1:
        return 'Light day — started slowly but made some progress.';
      default:
        return 'Rest day. No sessions recorded.';
    }
  }

  static int getFocusHoursForLevel(int level) {
    switch (level) {
      case 3:
        return 7;
      case 2:
        return 5;
      case 1:
        return 2;
      default:
        return 0;
    }
  }
}

List<DayProgress> generateDummyProgress() {
  final random = Random(42);
  final List<DayProgress> list = [];

  for (int d = 1; d <= 31; d++) {
    final r = random.nextDouble();
    final level = r < 0.15
        ? 0
        : r < 0.35
            ? 1
            : r < 0.65
                ? 2
                : 3;
    final total = random.nextInt(4) + 4; // 4..7
    final completed = level == 0
        ? 0
        : level == 1
            ? (total * 0.3).round()
            : level == 2
                ? (total * 0.6).round()
                : (total * 0.9).round();

    list.add(
      DayProgress(
        date: d,
        level: level,
        completed: completed,
        total: total,
        focusHours: DayProgress.getFocusHoursForLevel(level),
        summary: DayProgress.getSummaryForLevel(level),
      ),
    );
  }

  return list;
}
