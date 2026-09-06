part of '../home.dart';

class _GoalMetric {
  final String label;
  final int completed;
  final int total;
  final Color color;
  final Color badgeBg;
  final IconData icon;

  const _GoalMetric({
    required this.label,
    required this.completed,
    required this.total,
    required this.color,
    required this.badgeBg,
    required this.icon,
  });

  double get progress => total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;
}

/// 2-column grid row showing weekly and monthly goal completion summary.
class _GoalsSummary extends StatelessWidget {
  final _GoalMetric? weekly;
  final _GoalMetric? monthly;
  final VoidCallback? onWeeklyTap;
  final VoidCallback? onMonthlyTap;

  const _GoalsSummary({
    super.key,
    this.weekly,
    this.monthly,
    this.onWeeklyTap,
    this.onMonthlyTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveWeekly = weekly ??
        const _GoalMetric(
          label: 'Weekly',
          completed: 0,
          total: 0,
          color: Color(0xff10B981),
          badgeBg: Color(0xffECFDF5),
          icon: LucideIcons.target,
        );

    final effectiveMonthly = monthly ??
        const _GoalMetric(
          label: 'Monthly',
          completed: 0,
          total: 0,
          color: Color(0xff8B5CF6),
          badgeBg: Color(0xffF5F3FF),
          icon: LucideIcons.trending_up,
        );

    return Row(
      children: [
        Expanded(
          child: _GoalSummaryItemCard(
            metric: effectiveWeekly,
            onTap: onWeeklyTap,
          ),
        ),
        Space.x.t12,
        Expanded(
          child: _GoalSummaryItemCard(
            metric: effectiveMonthly,
            onTap: onMonthlyTap,
          ),
        ),
      ],
    );
  }
}

class _GoalSummaryItemCard extends StatelessWidget {
  final _GoalMetric metric;
  final VoidCallback? onTap;

  const _GoalSummaryItemCard({
    required this.metric,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: Space.a.t16,
        decoration: BoxDecoration(
          color: AppTheme.c.subBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.c.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: metric.badgeBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    metric.icon,
                    size: 14,
                    color: metric.color,
                  ),
                ),
                Space.x.t08,
                Text(
                  metric.label,
                  style: AppText.b2b.cl(AppTheme.c.subText),
                ),
              ],
            ),
            Space.y.t12,
            Text(
              '${metric.completed} / ${metric.total}',
              style: AppText.h2b.cl(AppTheme.c.text),
            ),
            Space.y.t04,
            Text(
              'Goals Complete',
              style: AppText.l1.cl(AppTheme.c.subText),
            ),
            Space.y.t08,
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: metric.progress,
                minHeight: 6,
                backgroundColor: AppTheme.c.border,
                valueColor: AlwaysStoppedAnimation<Color>(metric.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
