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
          // Left Time Column (matching 52 width)
          SizedBox(
            width: 52,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    state.formatTimeShort(gap.startTime),
                    style: AppText.b2b.cl(
                      AppTheme.c.subText.withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: AppTheme.c.border.withValues(alpha: 0.6),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          Space.x.t08,
          // Gap Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
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
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.c.subBackground.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.c.border.withValues(alpha: 0.7),
                        width: 1.5,
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
                        Space.x.t08,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Available Slot ($durationText)',
                                style: AppText.b2b.cl(AppTheme.c.text),
                              ),
                              if (state.canAddTask) ...[
                                Space.y.t04,
                                Text(
                                  'Tap to schedule a time block',
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
