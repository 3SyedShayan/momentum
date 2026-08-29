part of '../task.dart';

class _AllTasks extends StatelessWidget {
  const _AllTasks();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);

    return StreamBuilder<List<TaskX>>(
      stream: state.watchAllTasks(),
      builder: (context, snapshot) {
        final tasks = snapshot.data ?? [];

        if (tasks.isEmpty) {
          return Padding(
            padding: Space.v.t32,
            child: Center(
              child: Text(
                'No tasks planned. Tap + to add.',
                style: AppText.b1.cl(AppTheme.c.subText),
              ),
            ),
          );
        }

        return Column(
          children: tasks.map((task) {
            return _TimelineItem(task: task);
          }).toList(),
        );
      },
    );
  }
}
