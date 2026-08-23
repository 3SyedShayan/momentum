part of '../goal.dart';

class _AllGoals extends StatelessWidget {
  const _AllGoals({super.key});
  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);
    ;
    return StreamBuilder(
      stream: state.watchAllGoals(),
      builder: (context, snapshot) {
        final allGoals = snapshot.data ?? [];
        final filteredGoals = allGoals
            .where((g) => g.type == state.selectedTab)
            .toList();

        if (filteredGoals.isEmpty) {
          return Center(
            child: Text(
              "No Goals Found",
              style: AppText.b2.cl(AppTheme.c.subText),
            ),
          );
        }

        return Column(
          children: filteredGoals.map((goal) {
            return Padding(
              padding: Space.b.t12,
              child: _GoalCard(goal: goal),
            );
          }).toList(),
        );
      },
    );
  }
}
