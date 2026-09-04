part of '../task.dart';

class _TimelineGapItem extends StatelessWidget {
  final GapTimelineEntry gap;
  final bool isLast;

  const _TimelineGapItem({
    required this.gap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);
    final durationText = gap.formattedDuration;

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
                    state.formatTimeShort(gap.startTime),
                    style: AppText.b2b.cl(AppTheme.c.subText),
                  ),
                  Space.y.t04,
                  Text(
                    state.formatTimeShort(gap.endTime),
                    style: AppText.l1.cl(AppTheme.c.subText.withValues(alpha: 0.6)),
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
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.c.border,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.c.subText.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: AppTheme.c.border.withValues(alpha: 0.4),
                  ),
                ),
            ],
          ),
          Space.x.t12,
          // Gap Card
          Expanded(
            child: Padding(
              padding: Space.b.t16,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: state.canAddTask
                      ? () => AddTaskModal.show(
                            context,
                            initialStartHour: gap.startTime.hour,
                            initialEndHour: gap.endTime.hour,
                          )
                      : null,
                  child: Container(
                    padding: Space.a.t12,
                    decoration: BoxDecoration(
                      color: AppTheme.c.subBackground.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.c.border.withValues(alpha: 0.7),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppTheme.c.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            LucideIcons.plus,
                            size: 14,
                            color: AppTheme.c.primary,
                          ),
                        ),
                        Space.x.t12,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Available Slot ($durationText free)',
                                style: AppText.b2b.cl(AppTheme.c.text),
                              ),
                              if (state.canAddTask) ...[
                                Space.y.t04,
                                Text(
                                  'Tap to schedule a task',
                                  style: AppText.l1.cl(AppTheme.c.subText),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
