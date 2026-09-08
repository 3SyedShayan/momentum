part of '../task.dart';

class _TimelineGapItem extends StatelessWidget {
  final GapTimelineEntry gap;
  final bool isLast;

  const _TimelineGapItem({required this.gap, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);
    final durationText = gap.formattedDuration;

    final now = DateTime.now();
    final isToday =
        state.selectedDate.year == now.year &&
        state.selectedDate.month == now.month &&
        state.selectedDate.day == now.day;
    final isPastDay = DateTime(
      state.selectedDate.year,
      state.selectedDate.month,
      state.selectedDate.day,
    ).isBefore(DateTime(now.year, now.month, now.day));

    final earliestStartHour = isToday
        ? ((now.minute == 0 && now.second == 0) ? now.hour : now.hour + 1)
        : (isPastDay ? 24 : gap.startTime.hour);

    final effectiveStartHour = isToday
        ? (gap.startTime.hour < earliestStartHour
              ? earliestStartHour
              : gap.startTime.hour)
        : gap.startTime.hour;

    final isGapPassed =
        isPastDay || (isToday && effectiveStartHour >= gap.endTime.hour);
    final canSchedule = state.canAddTask && !isGapPassed;

    if (isGapPassed) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Time Column showing just the time ending
            // SizedBox(
            //   width: 52,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(top: 2),
            //         child: Text(
            //           state.formatTimeShort(gap.startTime),
            //           style: AppText.b2.cl(
            //             AppTheme.c.subText.withValues(alpha: 0.5),
            //           ),
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ),
            //       if (!isLast)
            //         Expanded(
            //           child: Container(
            //             width: 1.5,
            //             color: AppTheme.c.border.withValues(alpha: 0.5),
            //             margin: const EdgeInsets.symmetric(vertical: 2),
            //           ),
            //         ),
            //     ],
            //   ),
            // ),
            // Space.x.t08,
            // Empty right side - no past slot card, just spacing
            // const Expanded(child: SizedBox(height: 24)),
          ],
        ),
      );
    }

    final availableDurationText =
        (isToday && gap.startTime.hour < effectiveStartHour)
        ? (gap.endTime.hour - effectiveStartHour == 1
              ? '1 hr'
              : '${gap.endTime.hour - effectiveStartHour} hrs')
        : durationText;

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
          // Available Gap Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: canSchedule
                      ? () => AddTaskModal.show(
                          context,
                          initialStartHour: effectiveStartHour,
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
                                'Available Slot ($availableDurationText)',
                                style: AppText.b2b.cl(AppTheme.c.text),
                              ),
                              Space.y.t04,
                              Text(
                                'Tap to schedule a time block',
                                style: AppText.l1.cl(
                                  AppTheme.c.subText.withValues(alpha: 0.9),
                                ),
                              ),
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
