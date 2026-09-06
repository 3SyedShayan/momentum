part of '../home.dart';

/// Today's completion card showing progress ring and hours breakdown.
class _TodayCompletionCard extends StatelessWidget {
  final double completionPercentage;
  final double plannedHours;
  final double completedHours;
  final double remainingHours;
  final VoidCallback? onTap;

  const _TodayCompletionCard({
    super.key,
    this.completionPercentage = 0.0,
    this.plannedHours = 0.0,
    this.completedHours = 0.0,
    this.remainingHours = 0.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: Space.a.t20,
        decoration: BoxDecoration(
          color: AppTheme.c.subBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.c.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TODAY'S COMPLETION",
              style: AppText.b2b.cl(AppTheme.c.subText),
            ),
            Space.y.t20,
            Row(
              children: [
                _TodayCircularBar(
                  progress: completionPercentage,
                  onTap: () {},
                ),
                Space.x.t24,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMetricItem(
                        label: 'Planned',
                        value: '${plannedHours.toStringAsFixed(1)}h',
                        valueColor: AppTheme.c.text,
                      ),
                      Space.y.t16,
                      _buildMetricItem(
                        label: 'Completed',
                        value: '${completedHours.toStringAsFixed(1)}h',
                        valueColor: AppTheme.c.primary,
                      ),
                      Space.y.t16,
                      _buildMetricItem(
                        label: 'Remaining',
                        value: '${remainingHours.toStringAsFixed(1)}h',
                        valueColor: AppTheme.c.subText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.l1.cl(AppTheme.c.subText),
        ),
        Space.y.t04,
        Text(
          value,
          style: AppText.h3b.cl(valueColor),
        ),
      ],
    );
  }
}
