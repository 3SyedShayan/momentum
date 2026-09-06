part of '../home.dart';

/// Circular progress indicator widget showing completion percentage.
class _TodayCircularBar extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const _TodayCircularBar({
    super.key,
    this.progress = 0.75,
    this.size = 110,
    this.strokeWidth = 10,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final activeColor = color ?? AppTheme.c.primary;
    final trackColor = backgroundColor ?? AppTheme.c.border;
    final percent = (clampedProgress * 100).round();

    return GestureDetector(
      onTap: onTap ?? () {},
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: clampedProgress,
                strokeWidth: strokeWidth,
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation<Color>(activeColor),
                backgroundColor: trackColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$percent%', style: AppText.h2b),
                Text('Complete', style: AppText.l1.cl(AppTheme.c.subText)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Breakdown stat item showing colored bullet, title, and hours.
class _BreakdownItem extends StatelessWidget {
  final String title;
  final double hours;
  final Color color;
  final VoidCallback? onTap;

  const _BreakdownItem({
    required this.title,
    required this.hours,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap ?? () {},
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Space.x.t12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.b2.cl(AppTheme.c.subText)),
                Text('${hours.toStringAsFixed(1)}h', style: AppText.b1b),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Today's stats card containing the circular progress bar and metrics breakdown.
class _TodayStats extends StatelessWidget {
  final double completionPercentage;
  final double plannedHours;
  final double completedHours;
  final double remainingHours;
  final VoidCallback? onTap;
  final VoidCallback? onPlannedTap;
  final VoidCallback? onCompletedTap;
  final VoidCallback? onRemainingTap;

  const _TodayStats({
    super.key,
    this.completionPercentage = 0.75,
    this.plannedHours = 5.5,
    this.completedHours = 4.0,
    this.remainingHours = 1.5,
    this.onTap,
    this.onPlannedTap,
    this.onCompletedTap,
    this.onRemainingTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: Space.a.t20,
        decoration: BoxDecoration(
          color: AppTheme.c.subBackground,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.c.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Today's Completion", style: AppText.h3b),
                    Space.y.t04,
                    Text(
                      'Daily goal overview',
                      style: AppText.b2.cl(AppTheme.c.subText),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SpaceToken.t12,
                    vertical: SpaceToken.t04,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.c.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${(completionPercentage.clamp(0.0, 1.0) * 100).round()}% done',
                    style: AppText.b2b.cl(AppTheme.c.primary),
                  ),
                ),
              ],
            ),
            Space.y.t20,

            // Circular Bar + Breakdown metrics
            Row(
              children: [
                _TodayCircularBar(progress: completionPercentage, onTap: () {}),
                Space.x.t24,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _BreakdownItem(
                        title: 'Planned',
                        hours: plannedHours,
                        color: AppTheme.c.primary,
                        onTap: onPlannedTap ?? () {},
                      ),
                      Space.y.t12,
                      _BreakdownItem(
                        title: 'Completed',
                        hours: completedHours,
                        color: AppTheme.c.success,
                        onTap: onCompletedTap ?? () {},
                      ),
                      Space.y.t12,
                      _BreakdownItem(
                        title: 'Remaining',
                        hours: remainingHours,
                        color: AppTheme.c.warning,
                        onTap: onRemainingTap ?? () {},
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
}
