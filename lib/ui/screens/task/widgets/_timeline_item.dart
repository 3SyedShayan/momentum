part of '../task.dart';

class _TimelineItem extends StatelessWidget {
  final TaskX task;

  const _TimelineItem({required this.task});

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);
    final catColor = Color(task.category.color);
    final now = DateTime.now();
    final isActive = !task.isCompleted &&
        now.isAfter(task.startTime) &&
        now.isBefore(task.endTime);

    final itemColor = task.isCompleted
        ? AppTheme.c.subBackground.withValues(alpha: 0.6)
        : (isActive
            ? catColor.withValues(alpha: 0.08)
            : AppTheme.c.subBackground);

    final borderSideColor = isActive
        ? catColor
        : (task.isCompleted ? AppTheme.c.border : AppTheme.c.border);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Time Column
          SizedBox(
            width: 72,
            child: Padding(
              padding: Space.v.t12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.formatTimeShort(task.startTime),
                    style: AppText.b1b.cl(
                      task.isCompleted
                          ? AppTheme.c.subText
                          : AppTheme.c.text,
                    ),
                  ),
                  Space.y.t04,
                  Text(
                    state.formatTimeShort(task.endTime),
                    style: AppText.l1.cl(AppTheme.c.subText),
                  ),
                ],
              ),
            ),
          ),
          // Connector dot & line
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: task.isCompleted
                      ? AppTheme.c.subText
                      : catColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.c.background,
                    width: 2,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: AppTheme.c.border,
                ),
              ),
            ],
          ),
          Space.x.t12,
          // Task Card
          Expanded(
            child: Padding(
              padding: Space.b.t16,
              child: Container(
                padding: Space.a.t16,
                decoration: BoxDecoration(
                  color: itemColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: borderSideColor,
                    width: isActive ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style: AppText.b1b
                                    .cl(
                                      task.isCompleted
                                          ? AppTheme.c.subText
                                          : AppTheme.c.text,
                                    )
                                    .copyWith(
                                      decoration: task.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                              ),
                              if (task.description != null &&
                                  task.description!.isNotEmpty) ...[
                                Space.y.t04,
                                Text(
                                  task.description!,
                                  style: AppText.b2.cl(AppTheme.c.subText),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Checkbox(
                          value: task.isCompleted,
                          activeColor: AppTheme.c.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          onChanged: (_) => state.toggleTaskCompletion(task),
                        ),
                      ],
                    ),
                    if (isActive) ...[
                      Space.y.t08,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.65,
                          backgroundColor: catColor.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(catColor),
                          minHeight: 6,
                        ),
                      ),
                      Space.y.t04,
                      Text(
                        'In progress...',
                        style: AppText.l1b.cl(catColor),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
