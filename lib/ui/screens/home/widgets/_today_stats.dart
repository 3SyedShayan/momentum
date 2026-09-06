part of '../home.dart';

/// Today's stats card containing the circular progress bar and metrics breakdown.
class _TodayStats extends StatelessWidget {
  final double? completionPercentage;
  final double? plannedHours;
  final double? completedHours;
  final double? remainingHours;
  final VoidCallback? onTap;
  final VoidCallback? onPlannedTap;
  final VoidCallback? onCompletedTap;
  final VoidCallback? onRemainingTap;

  const _TodayStats({
    super.key,
    this.completionPercentage,
    this.plannedHours,
    this.completedHours,
    this.remainingHours,
    this.onTap,
    this.onPlannedTap,
    this.onCompletedTap,
    this.onRemainingTap,
  });

  @override
  Widget build(BuildContext context) {
    if (completionPercentage != null &&
        plannedHours != null &&
        completedHours != null &&
        remainingHours != null) {
      return _buildCard(
        context,
        completionPercentage: completionPercentage!,
        plannedHours: plannedHours!,
        completedHours: completedHours!,
        remainingHours: remainingHours!,
      );
    }

    final state = _ScreenState.s(context, true);

    return StreamBuilder<DayTaskStats>(
      stream: state.watchTodayStats(),
      builder: (context, snapshot) {
        final data = snapshot.data ?? const DayTaskStats();
        return _buildCard(
          context,
          completionPercentage:
              completionPercentage ?? data.completionPercentage,
          plannedHours: plannedHours ?? data.plannedHours,
          completedHours: completedHours ?? data.completedHours,
          remainingHours: remainingHours ?? data.remainingHours,
        );
      },
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required double completionPercentage,
    required double plannedHours,
    required double completedHours,
    required double remainingHours,
  }) {
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
