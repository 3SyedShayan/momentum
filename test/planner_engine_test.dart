import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/models/category/category.dart';
import 'package:momentum/core/models/task/task.dart';
import 'package:momentum/core/utils/planner_engine.dart';

void main() {
  const dummyCategory = CategoryX(
    id: '1',
    name: 'Work',
    icon: 'work',
    color: 0xFF3B82F6,
  );

  TaskX createTask({
    required int id,
    required String title,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return TaskX(
      id: id,
      title: title,
      startTime: startTime,
      endTime: endTime,
      isCompleted: false,
      category: dummyCategory,
    );
  }

  group('PlannerEngine.buildTimelineEntries', () {
    test('returns empty list when tasks are empty', () {
      final result = PlannerEngine.buildTimelineEntries([]);
      expect(result, isEmpty);
    });

    test(
      'returns only TaskTimelineEntry when consecutive tasks have no gap',
      () {
        final t1 = createTask(
          id: 1,
          title: 'Task 1',
          startTime: DateTime(2026, 9, 4, 9, 0),
          endTime: DateTime(2026, 9, 4, 10, 0),
        );
        final t2 = createTask(
          id: 2,
          title: 'Task 2',
          startTime: DateTime(2026, 9, 4, 10, 0),
          endTime: DateTime(2026, 9, 4, 11, 0),
        );

        final entries = PlannerEngine.buildTimelineEntries([t1, t2]);
        expect(entries.length, 2);
        expect(entries[0], isA<TaskTimelineEntry>());
        expect(entries[1], isA<TaskTimelineEntry>());
      },
    );

    test(
      'inserts GapTimelineEntry with correct duration between spaced tasks',
      () {
        final t1 = createTask(
          id: 1,
          title: 'Task 1',
          startTime: DateTime(2026, 9, 4, 9, 0),
          endTime: DateTime(2026, 9, 4, 10, 0),
        );
        final t2 = createTask(
          id: 2,
          title: 'Task 2',
          startTime: DateTime(2026, 9, 4, 13, 0),
          endTime: DateTime(2026, 9, 4, 15, 0),
        );

        // Pass in reverse order to ensure sorting works as well
        final entries = PlannerEngine.buildTimelineEntries([t2, t1]);
        expect(entries.length, 3);
        expect(entries[0], isA<TaskTimelineEntry>());
        expect(entries[1], isA<GapTimelineEntry>());
        expect(entries[2], isA<TaskTimelineEntry>());

        final gap = entries[1] as GapTimelineEntry;
        expect(gap.startTime, DateTime(2026, 9, 4, 10, 0));
        expect(gap.endTime, DateTime(2026, 9, 4, 13, 0));
        expect(gap.durationInMinutes, 180);
        expect(gap.formattedDuration, '3 hrs');
      },
    );
  });

  group('PlannerEngine.getDayStats and tasks.dayStats', () {
    test('returns zero metrics when tasks are empty', () {
      final stats = <TaskX>[].dayStats;
      expect(stats.plannedHours, 0.0);
      expect(stats.completedHours, 0.0);
      expect(stats.remainingHours, 0.0);
      expect(stats.completionPercentage, 0.0);
    });

    test('calculates correct metrics with mixed completed and pending tasks', () {
      final t1 = TaskX(
        id: 1,
        title: 'Completed Task',
        startTime: DateTime(2026, 9, 4, 9, 0),
        endTime: DateTime(2026, 9, 4, 11, 0), // 2 hours
        isCompleted: true,
        category: dummyCategory,
      );
      final t2 = TaskX(
        id: 2,
        title: 'Pending Task',
        startTime: DateTime(2026, 9, 4, 13, 0),
        endTime: DateTime(2026, 9, 4, 15, 0), // 2 hours
        isCompleted: false,
        category: dummyCategory,
      );

      final stats = [t1, t2].dayStats;
      expect(stats.completedHours, 2.0);
      expect(stats.remainingHours, 2.0);
      expect(stats.plannedHours, 4.0);
      expect(stats.completionPercentage, 0.5);
    });
  });

  group('PlannerEngine.getPastHours and isTimePassed', () {
    test('returns all 24 hours when target date is before today', () {
      final now = DateTime(2026, 9, 8, 14, 30);
      final yesterday = DateTime(2026, 9, 7);
      final pastHours = PlannerEngine.getPastHours(
        forDate: yesterday,
        currentTime: now,
      );

      expect(pastHours.length, 24);
      expect(pastHours, containsAll(List.generate(24, (i) => i)));
    });

    test('returns empty set when target date is in the future', () {
      final now = DateTime(2026, 9, 8, 14, 30);
      final tomorrow = DateTime(2026, 9, 9);
      final pastHours = PlannerEngine.getPastHours(
        forDate: tomorrow,
        currentTime: now,
      );

      expect(pastHours, isEmpty);
    });

    test('returns hours before current time for today', () {
      // At 14:30 (2:30 PM), hours 0 through 14 have started before now
      final now = DateTime(2026, 9, 8, 14, 30);
      final today = DateTime(2026, 9, 8);
      final pastHours = PlannerEngine.getPastHours(
        forDate: today,
        currentTime: now,
      );

      // Hours 0..14 should be past
      for (int h = 0; h <= 14; h++) {
        expect(pastHours.contains(h), isTrue, reason: 'Hour $h should be past');
      }
      // Hours 15..23 should NOT be past
      for (int h = 15; h < 24; h++) {
        expect(
          pastHours.contains(h),
          isFalse,
          reason: 'Hour $h should not be past',
        );
      }
    });

    test('isTimePassed correctly detects past vs future moments', () {
      final now = DateTime(2026, 9, 8, 14, 30);
      expect(
        PlannerEngine.isTimePassed(DateTime(2026, 9, 8, 14, 0), now),
        isTrue,
      );
      expect(
        PlannerEngine.isTimePassed(DateTime(2026, 9, 8, 15, 0), now),
        isFalse,
      );
    });
  });

  group('PlannerEngine.isRangeAvailable with pastHours', () {
    test('rejects range when it overlaps with past hours', () {
      final occupiedHours = <int>{18};
      final pastHours = <int>{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14};

      // Range 10-12 is in pastHours
      expect(
        PlannerEngine.isRangeAvailable(
          startHour: 10,
          endHour: 12,
          occupiedHours: occupiedHours,
          pastHours: pastHours,
        ),
        isFalse,
      );

      // Range 14-16 overlaps with hour 14 in pastHours
      expect(
        PlannerEngine.isRangeAvailable(
          startHour: 14,
          endHour: 16,
          occupiedHours: occupiedHours,
          pastHours: pastHours,
        ),
        isFalse,
      );

      // Range 15-17 is free of both pastHours and occupiedHours
      expect(
        PlannerEngine.isRangeAvailable(
          startHour: 15,
          endHour: 17,
          occupiedHours: occupiedHours,
          pastHours: pastHours,
        ),
        isTrue,
      );
    });
  });
}
