part of '../goal.dart';

class _GoalCard extends StatelessWidget {
  final GoalX goal;

  const _GoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);
    final isDone = goal.isCompleted ?? false;
    final accentColor = Color(goal.category.color);
    final hasDetails = goal.details != null && goal.details!.trim().isNotEmpty;

    return Container(
      padding: Space.a.t16,
      decoration: BoxDecoration(
        color: AppTheme.c.subBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDone
              ? AppTheme.c.border.withValues(alpha: 0.5)
              : AppTheme.c.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SpaceToken.t12,
                  vertical: SpaceToken.t04,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: isDone ? 0.06 : 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: isDone
                          ? accentColor.withValues(alpha: 0.5)
                          : accentColor,
                      radius: 4,
                    ),
                    Space.x.t08,
                    Text(
                      goal.category.name,
                      style: AppText.l1b.cl(
                        isDone
                            ? accentColor.withValues(alpha: 0.6)
                            : accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (goal.id != null)
                GestureDetector(
                  onTap: () => _confirmDeleteGoal(context, state, goal),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: Space.a.t04,
                    child: Icon(
                      LucideIcons.trash_2,
                      size: 16,
                      color: AppTheme.c.subText.withValues(alpha: 0.6),
                    ),
                  ),
                ),
            ],
          ),
          Space.y.t12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => state.toggleGoalCompletion(goal),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: Space.t.t04 + Space.r.t12,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDone ? accentColor : Colors.transparent,
                      border: Border.all(
                        color: isDone
                            ? accentColor
                            : AppTheme.c.subText.withValues(alpha: 0.4),
                        width: 1.8,
                      ),
                    ),
                    child: isDone
                        ? const Icon(Icons.check, size: 13, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => state.toggleGoalCompletion(goal),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: AppText.b1b
                            .cl(isDone ? AppTheme.c.subText : AppTheme.c.text)
                            .copyWith(
                              decoration: isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                      ),
                      if (hasDetails) ...[
                        Space.y.t04,
                        Text(
                          goal.details!,
                          style: AppText.b2.cl(
                            isDone
                                ? AppTheme.c.subText.withValues(alpha: 0.5)
                                : AppTheme.c.subText,
                          ),
                        ),
                      ],
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

  void _confirmDeleteGoal(
    BuildContext context,
    _ScreenState state,
    GoalX goal,
  ) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Delete Goal'),
        content: Text('Are you sure you want to delete "${goal.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              if (goal.id != null) {
                state.deleteGoal(goal.id!);
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
