part of '../home.dart';

class _TimelineTask {
  final String id;
  final String title;
  final String start;
  final String end;
  final String category;
  final Color categoryColor;
  final String status; // 'completed', 'current', 'upcoming'

  const _TimelineTask({
    required this.id,
    required this.title,
    required this.start,
    this.end = '',
    this.category = '',
    this.categoryColor = const Color(0xff2563EB),
    this.status = 'upcoming',
  });
}

/// Today's timeline preview card showing a quick list of scheduled tasks.
class _TodayTimelineCard extends StatelessWidget {
  final List<_TimelineTask> tasks;
  final VoidCallback? onViewAll;
  final ValueChanged<_TimelineTask>? onTaskTap;

  const _TodayTimelineCard({
    super.key,
    this.tasks = const [],
    this.onViewAll,
    this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Today's Timeline",
                style: AppText.b1b.cl(AppTheme.c.text),
              ),
              GestureDetector(
                onTap: onViewAll ?? () {},
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
                final isCompleted = task.status == 'completed';
                final isCurrent = task.status == 'current';
                final dotColor = (isCompleted || isCurrent)
                    ? task.categoryColor
                    : AppTheme.c.border;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: SpaceToken.t04),
                  child: GestureDetector(
                    onTap: () => onTaskTap?.call(task),
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
                                ? AppText.b2.cl(AppTheme.c.subText).copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    )
                                : AppText.b2.cl(AppTheme.c.text),
                          ),
                        ),
                        Space.x.t08,
                        Text(
                          task.start,
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
