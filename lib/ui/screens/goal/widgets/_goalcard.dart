part of '../goal.dart';

class _GoalCard extends StatelessWidget {
  final GoalItem goal;

  const _GoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);
    final progress = (goal.totalSessions > 0)
        ? (goal.completedSessions / goal.totalSessions).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: Space.a.t16,
      decoration: BoxDecoration(
        color: AppTheme.c.subBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.title,
                    style: AppText.b1b,
                  ),
                  Space.y.t04,
                  Text(
                    goal.category,
                    style: AppText.b2.cl(AppTheme.c.subText),
                  ),
                ],
              ),
              // Percentage Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SpaceToken.t12,
                  vertical: SpaceToken.t08,
                ),
                decoration: BoxDecoration(
                  color: goal.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${goal.percentage}%',
                  style: AppText.b2b.cl(goal.accentColor),
                ),
              ),
            ],
          ),
          Space.y.t16,

          // Linear Progress Indicator
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppTheme.c.border,
              valueColor: AlwaysStoppedAnimation<Color>(goal.accentColor),
            ),
          ),
          Space.y.t12,

          // Footer info + Action button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${goal.completedSessions} of ${goal.totalSessions} sessions',
                style: AppText.b2.cl(AppTheme.c.subText),
              ),
              GestureDetector(
                onTap: () => state.addSessionToToday(goal),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SpaceToken.t12,
                    vertical: SpaceToken.t04,
                  ),
                  decoration: BoxDecoration(
                    color: goal.accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 14, color: goal.accentColor),
                      Space.x.t04,
                      Text(
                        'Add to Today',
                        style: AppText.b2.w(6).cl(goal.accentColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
