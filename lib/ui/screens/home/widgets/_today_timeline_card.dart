part of '../home.dart';

/// Today's timeline preview card showing a quick list of scheduled tasks.
class _TodayTimelineCard extends StatelessWidget {
  final List<TaskX>? tasks;
  final VoidCallback? onViewAll;
  final ValueChanged<TaskX>? onTaskTap;

  const _TodayTimelineCard({
    super.key,
    this.tasks,
    this.onViewAll,
    this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks != null) {
      return _buildCard(context, tasks: tasks!);
    }

    final state = _ScreenState.s(context, true);

    return StreamBuilder<List<TaskX>>(
      stream: state.watchTodayTasks(),
      builder: (context, snapshot) {
        final taskList = snapshot.data ?? const [];
        return _buildCard(context, tasks: taskList);
      },
    );
  }

  Widget _buildCard(BuildContext context, {required List<TaskX> tasks}) {
    final state = _ScreenState.s(context);
    final now = DateTime.now();

    return Container(
      padding: Space.a.t20,
      decoration: BoxDecoration(
        color: AppTheme.c.subBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Timeline", style: AppText.b1b.cl(AppTheme.c.text)),
              GestureDetector(
                onTap: onViewAll ?? () => context.go(Routes.planner),
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'View All',
                  style: AppText.b2b.cl(AppTheme.c.primary),
                ),
              ),
            ],
          ),
          Space.y.t16,
          if (tasks.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: SpaceToken.t08),
              child: Text(
                'No scheduled tasks for today',
                style: AppText.b2.cl(AppTheme.c.subText),
              ),
            )
          else
            Column(
              children: tasks.map((task) {
                final isCompleted = task.isCompleted;
                final isCurrent = state.isTaskCurrent(task, now);
                final dotColor = (isCompleted || isCurrent)
                    ? Color(task.category.color)
                    : AppTheme.c.border;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: SpaceToken.t04),
                  child: GestureDetector(
                    onTap: () {
                      if (onTaskTap != null) {
                        onTaskTap!(task);
                      } else {
                        context.go(Routes.planner);
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Space.x.t12,
                        Expanded(
                          child: Text(
                            task.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: isCompleted
                                ? AppText.b2
                                      .cl(AppTheme.c.subText)
                                      .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      )
                                : AppText.b2.cl(AppTheme.c.text),
                          ),
                        ),
                        Space.x.t08,
                        Text(
                          state.formatTime(task.startTime),
                          style: AppText.l1.cl(AppTheme.c.subText),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
