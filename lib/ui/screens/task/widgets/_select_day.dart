part of '../task.dart';

class _SelectDay extends StatelessWidget {
  const _SelectDay();

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dayOptions = [
      (label: 'Yesterday', date: yesterday),
      (label: 'Today', date: today),
      (label: 'Tomorrow', date: tomorrow),
    ];

    return Container(
      padding: Space.a.t04,
      decoration: BoxDecoration(
        color: AppTheme.c.subBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: dayOptions.map((option) {
          final isSelected = _isSameDay(state.selectedDate, option.date);
          return _DayTabPill(
            label: option.label,
            isSelected: isSelected,
            onTap: () => state.setSelectedDate(option.date),
          );
        }).toList(),
      ),
    );
  }
}
