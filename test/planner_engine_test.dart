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
}
