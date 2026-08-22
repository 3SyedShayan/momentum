part of '../goal.dart';

class AddGoal extends StatelessWidget {
  const AddGoal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: _ScreenState.s(context),
        child: const AddGoal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);
    return FormBuilder(
      key: state.goalFormKey,
      initialValue: _GoalFormData.initialGoalValues(),
      child: Padding(
        padding: Space.a.t20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add New Goal', style: AppText.h2),
            Space.y.t16,
            AppFormTextInput(
              name: _GoalFormKeys.title,
              heading: 'Goal Title',
              placeholder: 'e.g., Workout 4x a week',
              validators: FormBuilderValidators.required(),
            ),

            Space.y.t20,
            AppFormTextInput(
              name: _GoalFormKeys.targetSessions,
              heading: 'Target Sessions',
              placeholder: 'e.g., 4',
              validators: FormBuilderValidators.required(),
            ),
            Space.y.t20,
            AppFormTextInput(
              name: _GoalFormKeys.type,
              heading: 'Goal Type',
              placeholder: 'e.g., monthly or weekly',
              validators: FormBuilderValidators.required(),
            ),

            Space.y.t20,

            AppButton(
              label: 'Save Goal',
              onTap: () => state.submitAddGoal(),
            ),
          ],
        ),
      ),
    );
  }
}
