part of '../goal.dart';

class _GoalTypeField extends StatelessWidget {
  const _GoalTypeField();

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<GoalType>(
      name: _GoalFormKeys.type,
      initialValue: GoalType.weekly,
      validator: FormBuilderValidators.required(),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Goal Type', style: AppText.b1b),
            Space.y.t08,
            Container(
              padding: Space.a.t04,
              decoration: BoxDecoration(
                color: AppTheme.c.subBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _GoalTypePill(
                    label: 'Weekly',
                    isSelected: field.value == GoalType.weekly,
                    onTap: () => field.didChange(GoalType.weekly),
                  ),
                  _GoalTypePill(
                    label: 'Monthly',
                    isSelected: field.value == GoalType.monthly,
                    onTap: () => field.didChange(GoalType.monthly),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GoalTypePill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GoalTypePill({
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
          padding: Space.v.t08,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.c.background : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
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
            style: AppText.b2
                .w(isSelected ? 6 : 4)
                .cl(isSelected ? AppTheme.c.text : AppTheme.c.subText),
          ),
        ),
      ),
    );
  }
}
