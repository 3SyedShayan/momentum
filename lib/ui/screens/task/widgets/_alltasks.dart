part of '../task.dart';

class _AllTasks extends StatelessWidget {
  const _AllTasks();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);

    return StreamBuilder<List<TaskX>>(
      stream: state.watchAllTasks(state.selectedDate),
      builder: (context, snapshot) {
        final tasks = snapshot.data ?? [];

        if (tasks.isEmpty) {
          return Padding(
            padding: Space.v.t32,
            child: Center(
              child: Text(
                state.canAddTask
                    ? 'No tasks planned. Tap + to add.'
                    : 'No tasks recorded for this day.',
                style: AppText.b1.cl(AppTheme.c.subText),
              ),
            ),
          );
        }

        final entries = PlannerEngine.buildTimelineEntries(tasks);

        return Column(
          children: entries.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == entries.length - 1;

            return switch (item) {
              TaskTimelineEntry(:final task) => _TimelineItem(
                  task: task,
                  isLast: isLast,
                ),
              GapTimelineEntry() => _TimelineGapItem(
                  gap: item,
                  isLast: isLast,
                ),
            };
          }).toList(),
        );
      },
    );
  }
}
