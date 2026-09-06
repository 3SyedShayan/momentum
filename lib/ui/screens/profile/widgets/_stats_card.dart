part of '../profile.dart';

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);

    final stats = [
      {'label': 'Total Hours Planned', 'value': '${state.totalHoursPlanned}h'},
      {'label': 'Total Hours Completed', 'value': '${state.totalHoursCompleted}h'},
      {'label': 'Weekly Completion Avg', 'value': state.weeklyCompletionAvg},
      {'label': 'Monthly Completion Avg', 'value': state.monthlyCompletionAvg},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR STATS',
          style: AppText.b2b.cl(AppTheme.c.subText).copyWith(
            letterSpacing: 1.0,
            fontSize: 11,
          ),
        ),
        Space.y.t08,
        Container(
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
            children: stats.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == stats.length - 1;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SpaceToken.t20,
                      vertical: SpaceToken.t16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['label']!,
                          style: AppText.b1.cl(AppTheme.c.subText),
                        ),
                        Text(
                          item['value']!,
                          style: AppText.b1b.cl(AppTheme.c.text),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.c.border.withValues(alpha: 0.5),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
