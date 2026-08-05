part of '../goal.dart';

class AddGoal extends StatelessWidget {
  const AddGoal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Provider.value(
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
              name: _CategoryFormKeys.title,
              heading: 'Category Title',
              placeholder: 'e.g., Health & Fitness',
              validators: FormBuilderValidators.required(),
            ),
            Space.y.t20,
            AppButton(
              label: 'Save Category',
              onTap: () => state.submitAddCategory(context),
            ),
          ],
        ),
      ),
    );
  }
}
