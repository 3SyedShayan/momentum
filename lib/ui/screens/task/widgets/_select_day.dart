part of '../task.dart';

class _SelectDay extends StatelessWidget {
  const _SelectDay();

  String _getDayLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = target.difference(today).inDays;

    if (diff == 0) return 'Today';
    if (diff == -1) return 'Yesterday';
    if (diff == 1) return 'Tomorrow';

    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final weekday = weekdays[target.weekday - 1];
    final month = months[target.month - 1];
    return '$weekday, $month ${target.day}';
  }

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final minDate = DateTime(
      today.year,
      today.month,
      today.day - 1,
    ); // Yesterday
    final maxDate = DateTime(
      today.year,
      today.month,
      today.day + 2,
    ); // Next 2 days

    final currentTarget = DateTime(
      state.selectedDate.year,
      state.selectedDate.month,
      state.selectedDate.day,
    );

    final canGoPrevious = currentTarget.isAfter(minDate);
    final canGoNext = currentTarget.isBefore(maxDate);

    return Container(
      padding: Space.a.t04,
      decoration: BoxDecoration(
        color: AppTheme.c.subBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.c.border.withValues(alpha: 0.8)),
      ),
      child: Row(
        children: [
          _DayTabPill(
            icon: LucideIcons.chevron_left,
            isSelected: false,
            isEnabled: canGoPrevious,
            onTap: () {
              if (!canGoPrevious) return;
              final prev = DateTime(
                currentTarget.year,
                currentTarget.month,
                currentTarget.day - 1,
              );
              state.setSelectedDate(prev);
            },
          ),
          _DayTabPill(
            label: _getDayLabel(state.selectedDate),
            isSelected: true,
            onTap: () {
              state.setSelectedDate(today);
            },
          ),
          _DayTabPill(
            icon: LucideIcons.chevron_right,
            isSelected: false,
            isEnabled: canGoNext,
            onTap: () {
              if (!canGoNext) return;
              final next = DateTime(
                currentTarget.year,
                currentTarget.month,
                currentTarget.day + 1,
              );
              state.setSelectedDate(next);
            },
          ),
        ],
      ),
    );
  }
}
