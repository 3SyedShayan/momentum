import 'package:momentum/core/models/task/task.dart';

sealed class TimelineEntry {
  final DateTime startTime;
  final DateTime endTime;
  const TimelineEntry({required this.startTime, required this.endTime});
}

class TaskTimelineEntry extends TimelineEntry {
  final TaskX task;
  TaskTimelineEntry(this.task)
      : super(startTime: task.startTime, endTime: task.endTime);
}

class GapTimelineEntry extends TimelineEntry {
  GapTimelineEntry({required super.startTime, required super.endTime});

  int get durationInMinutes => endTime.difference(startTime).inMinutes;

  String get formattedDuration {
    final mins = durationInMinutes;
    final hours = mins ~/ 60;
    final rem = mins % 60;
    if (hours > 0 && rem > 0) {
      return '${hours}h ${rem}m';
    } else if (hours > 0) {
      return hours == 1 ? '1 hr' : '$hours hrs';
    } else {
      return '$mins mins';
    }
  }
}

class PlannerEngine {
  static const int totalHours = 24;

  static List<TimelineEntry> buildTimelineEntries(List<TaskX> tasks) {
    if (tasks.isEmpty) return const [];

    final sortedTasks = List<TaskX>.from(tasks)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    final entries = <TimelineEntry>[];

    for (int i = 0; i < sortedTasks.length; i++) {
      final current = sortedTasks[i];
      entries.add(TaskTimelineEntry(current));

      if (i < sortedTasks.length - 1) {
        final next = sortedTasks[i + 1];
        if (next.startTime.isAfter(current.endTime)) {
          entries.add(GapTimelineEntry(
            startTime: current.endTime,
            endTime: next.startTime,
          ));
        }
      }
    }

    return entries;
  }

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
