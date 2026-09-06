part of '../progress.dart';

class _HeatmapCard extends StatelessWidget {
  const _HeatmapCard();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);
    final weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Container(
      padding: EdgeInsets.all(SpaceToken.t20),
      decoration: BoxDecoration(
        color: AppTheme.c.specBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.c.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Month & Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.currentMonthYear,
                style: AppText.b1b.cl(AppTheme.c.text),
              ),
              Row(
                children: [
                  Text(
                    'Less',
                    style: AppText.l1.cl(AppTheme.c.subText),
                  ),
                  Space.x.t08,
                  Row(
                    children: ProgressColors.heatmapLevels.map((color) {
                      return Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }).toList(),
                  ),
                  Space.x.t08,
                  Text(
                    'More',
                    style: AppText.l1.cl(AppTheme.c.subText),
                  ),
                ],
              ),
            ],
          ),
          Space.y.t16,

          // Weekdays header row
          Row(
            children: weekdays.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: AppText.b2b.cl(AppTheme.c.subText.withValues(alpha: 0.5)),
                  ),
                ),
              );
            }).toList(),
          ),
          Space.y.t08,

          // Calendar heatmap grid (7 columns)
          _HeatmapGrid(
            offset: state.firstDayOffset,
            days: state.monthDays,
            selectedDay: state.selectedDay,
            onSelectDay: state.selectDay,
          ),

          // Detail card for selected day
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: state.selectedDay != null
                ? _DayDetailCard(day: state.selectedDay!)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _HeatmapGrid extends StatelessWidget {
  final int offset;
  final List<DayProgress> days;
  final DayProgress? selectedDay;
  final ValueChanged<DayProgress?> onSelectDay;

  const _HeatmapGrid({
    required this.offset,
    required this.days,
    required this.selectedDay,
    required this.onSelectDay,
  });

  @override
  Widget build(BuildContext context) {
    final totalCells = offset + days.length;
    final totalRows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(totalRows, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.5),
          child: Row(
            children: List.generate(7, (colIndex) {
              final cellIndex = rowIndex * 7 + colIndex;
              final dayIndex = cellIndex - offset;

              if (dayIndex < 0 || dayIndex >= days.length) {
                return const Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: SizedBox.shrink(),
                  ),
                );
              }

              final day = days[dayIndex];
              final isSelected = selectedDay?.date == day.date;
              final color = ProgressColors.heatmapLevels[day.level];

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.5),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: InkWell(
                      onTap: () {
                        onSelectDay(isSelected ? null : day);
                      },
                      borderRadius: BorderRadius.circular(6),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(6),
                          border: isSelected
                              ? Border.all(
                                  color: AppTheme.c.primary,
                                  width: 2.0,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
