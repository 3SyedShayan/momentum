import 'package:momentum/core/models/task/task.dart';

class PlannerEngine {
  static const int totalHours = 24;
  static Set<int> getOccupiedHours(
    List<TaskX> tasks, {
    DateTime? forDate,
    int? excludeTaskId,
  }) {
    final occupiedHours = <int>{};
    final targetDate = forDate ?? DateTime.now();

    for (final task in tasks) {
      if (excludeTaskId != null &&
          task.id != null &&
          task.id == excludeTaskId) {
        continue;
      }
      final isSameDay =
          task.startTime.year == targetDate.year &&
          task.startTime.month == targetDate.month &&
          task.startTime.day == targetDate.day;
      if (isSameDay) {
        final startHour = task.startTime.hour;
        var endHour = task.endTime.hour;

        if (task.endTime.day != task.startTime.day && endHour == 0) {
          endHour = 24;
        }
        for (int h = startHour; h < endHour && h < 24; h++) {
          occupiedHours.add(h);
        }
      }
    }
    return occupiedHours;
  }

  static List<int> getAvailableEndHours({
    required int startHour,
    required Set<int> occupiedHours,
  }) {
    final available = <int>[];

    if (occupiedHours.contains(startHour)) {
      return available;
    }

    for (int h = startHour + 1; h <= 24; h++) {
      if (occupiedHours.contains(h - 1)) {
        break;
      }
      available.add(h);
    }

    return available;
  }

  static bool isRangeAvailable({
    required int startHour,
    required int endHour,
    required Set<int> occupiedHours,
  }) {
    if (endHour <= startHour) return false;

    for (int h = startHour; h < endHour; h++) {
      if (occupiedHours.contains(h)) {
        return false;
      }
    }

    return true;
  }
}
