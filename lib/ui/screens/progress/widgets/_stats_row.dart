part of '../progress.dart';

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.flame,
                  size: 14,
                  color: ProgressColors.streakOrange,
                ),
                Space.x.t04,
                Text(
                  'Streak',
                  style: AppText.b2b.cl(AppTheme.c.subText),
                ),
              ],
            ),
            value: '${state.streakDays}',
            valueColor: AppTheme.c.text,
            unit: 'days',
          ),
        ),
        Space.x.t12,
        Expanded(
          child: _StatCard(
            header: Text(
              'This Week',
              style: AppText.b2b.cl(AppTheme.c.subText),
              textAlign: TextAlign.center,
            ),
            value: '${state.weeklyCompletionPercent}%',
            valueColor: ProgressColors.thisWeekBlue,
            unit: 'completion',
          ),
        ),
        Space.x.t12,
        Expanded(
          child: _StatCard(
            header: Text(
              'This Month',
              style: AppText.b2b.cl(AppTheme.c.subText),
              textAlign: TextAlign.center,
            ),
            value: '${state.monthlyCompletionPercent}%',
            valueColor: ProgressColors.thisMonthEmerald,
            unit: 'completion',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final Widget header;
  final String value;
  final Color valueColor;
  final String unit;

  const _StatCard({
    required this.header,
    required this.value,
    required this.valueColor,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SpaceToken.t12,
        vertical: SpaceToken.t16,
      ),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          header,
          Space.y.t04,
          Text(
            value,
            style: AppText.h1b.cl(valueColor),
          ),
          Space.y.t04,
          Text(
            unit,
            style: AppText.l1.cl(AppTheme.c.subText),
          ),
        ],
      ),
    );
  }
}
