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
          final weeklyGoals = state.goals
              .where((g) => g.type == 'weekly')
              .toList();
          final monthlyGoals = state.goals
              .where((g) => g.type == 'monthly')
              .toList();

          return TabBarView(
            children: [
              _GoalListView(models: weeklyGoals, title: 'Weekly Progress'),
              _GoalListView(models: monthlyGoals, title: 'Monthly Progress'),
            ],
          );
        }

        final weeklyDummy = screenState.goals
            .where((g) => g.frequency == GoalFrequency.weekly)
            .toList();
        final monthlyDummy = screenState.goals
            .where((g) => g.frequency == GoalFrequency.monthly)
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

class _GoalListView extends StatelessWidget {
  final List<GoalModel>? models;
  final List<GoalItem>? items;
  final String title;

  const _GoalListView({this.models, this.items, required this.title});

  @override
  Widget build(BuildContext context) {
    final count = models?.length ?? items?.length ?? 0;

    if (count == 0) {
      return Center(
        child: Text(
          'No goals set for this section.',
          style: AppText.b1.cl(AppTheme.c.subText),
        ),
      );
    }

    return ListView.builder(
      padding: Space.a.t16,
      itemCount: count,
      itemBuilder: (context, index) {
        final titleStr = models != null
            ? models![index].title
            : items![index].title;
        final categoryStr = models != null
            ? models![index].categoryId
            : items![index].category;
        final completed = models != null
            ? models![index].completedSessions
            : items![index].completedSessions;
        final total = models != null
            ? models![index].totalSessions
            : items![index].totalSessions;
        final progress = models != null
            ? models![index].progressPercentage
            : (total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0);
        final percentText = '${(progress * 100).toInt()}%';
        final accent = items != null
            ? items![index].accentColor
            : AppTheme.c.primary;

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
                    '$completed of $total sessions',
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
