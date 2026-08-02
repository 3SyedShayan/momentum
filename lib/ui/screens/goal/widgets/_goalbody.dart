part of '../goal.dart';

// ignore: unused_element
class _GoalBody extends StatelessWidget {
  const _GoalBody();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return BlocBuilder<GoalsBloc, GoalsState>(
      builder: (context, state) {
        if (state is GoalsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GoalsLoaded && state.goals.isNotEmpty) {
          final mappedGoals = state.goals.map(_goalModelToGoalX).toList();
          final weeklyGoals = mappedGoals
              .where((g) => g.type == GoalType.weekly)
              .toList();
          final monthlyGoals = mappedGoals
              .where((g) => g.type == GoalType.monthly)
              .toList();

          return TabBarView(
            children: [
              _GoalListView(items: weeklyGoals, title: 'Weekly Progress'),
              _GoalListView(items: monthlyGoals, title: 'Monthly Progress'),
            ],
          );
        }

        final weeklyDummy = screenState.goals
            .where((g) => g.type == GoalType.weekly)
            .toList();
        final monthlyDummy = screenState.goals
            .where((g) => g.type == GoalType.monthly)
            .toList();

        return TabBarView(
          children: [
            _GoalListView(items: weeklyDummy, title: 'Weekly Progress'),
            _GoalListView(items: monthlyDummy, title: 'Monthly Progress'),
          ],
        );
      },
    );
  }
}

GoalX _goalModelToGoalX(dynamic model) {
  final categoryId = (model.categoryId as String?) ?? '';
  final category = allCategories.firstWhere(
    (c) => c.id == categoryId,
    orElse: () => const Category(
      id: '',
      name: 'General',
      icon: 'folder',
      color: 0xFF1A56DB,
    ),
  );
  return GoalX(
    id: int.tryParse(model.id.toString()) ?? 0,
    title: model.title.toString(),
    category: category,
    percentageCompleted: (model.progressPercentage as double?) ?? 0.0,
    color: category.color,
    type: model.type == 'monthly' ? GoalType.monthly : GoalType.weekly,
    isCompleted: ((model.progressPercentage as double?) ?? 0.0) >= 1.0,
    createdAt: DateTime.now(),
  );
}

class _GoalListView extends StatelessWidget {
  final List<GoalX> items;
  final String title;

  const _GoalListView({required this.items, required this.title});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No goals set for this section.',
          style: AppText.b1.cl(AppTheme.c.subText),
        ),
      );
    }

    return ListView.builder(
      padding: Space.a.t16,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final goal = items[index];
        final titleStr = goal.title;
        final categoryStr = goal.category.name;
        final progress = goal.percentageCompleted.clamp(0.0, 1.0);
        final percentText = '${(progress * 100).toInt()}%';
        final accent = Color(goal.color);
        final isCompleted = goal.isCompleted;

        return Container(
          margin: Space.z.b(16),
          padding: Space.a.t16,
          decoration: BoxDecoration(
            color: AppTheme.c.subBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.c.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: Space.z.h(10).v(4),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      categoryStr.isEmpty ? 'General' : categoryStr,
                      style: AppText.l1b.cl(accent),
                    ),
                  ),
                  Text(percentText, style: AppText.b1b.cl(accent)),
                ],
              ),
              Space.y.t12,
              Text(titleStr, style: AppText.b1b),
              Space.y.t12,
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppTheme.c.border,
                  valueColor: AlwaysStoppedAnimation<Color>(accent),
                  minHeight: 8,
                ),
              ),
              Space.y.t16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isCompleted ? 'Completed' : 'In Progress',
                    style: AppText.b2.cl(AppTheme.c.subText),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
