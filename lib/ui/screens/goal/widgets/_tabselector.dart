part of '../goal.dart';

class _GoalTabSelector extends StatelessWidget {
  const _GoalTabSelector();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);

    return Container(
      padding: Space.a.t04,
      decoration: BoxDecoration(
        color: AppTheme.c.subBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _TabPill(
            label: 'Weekly Goals',
            isSelected: state.selectedTab == GoalFrequency.weekly,
            onTap: () => state.setTab(GoalFrequency.weekly),
          ),
          _TabPill(
            label: 'Monthly Goals',
            isSelected: state.selectedTab == GoalFrequency.monthly,
            onTap: () => state.setTab(GoalFrequency.monthly),
          ),
        ],
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: Space.v.t12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.c.background : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            style: AppText.b1
                .w(isSelected ? 6 : 4)
                .cl(isSelected ? AppTheme.c.text : AppTheme.c.subText),
          ),
        ),
      ),
    );
  }
}
