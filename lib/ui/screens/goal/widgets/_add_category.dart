part of '../goal.dart';

class AddCategoryModal extends StatelessWidget {
  const AddCategoryModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Provider.value(
        value: _ScreenState.s(context),
        child: const AddCategoryModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);

    return FormBuilder(
      key: state.categoryFormKey,
      initialValue: _GoalFormData.initialCategoryValues(),
      child: Padding(
        padding: Space.a.t20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add New Category', style: AppText.h2),
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
