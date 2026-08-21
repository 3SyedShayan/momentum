part of '../goal.dart';

class AddCategoryModal extends StatelessWidget {
  const AddCategoryModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ChangeNotifierProvider.value(
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
            AppFormIconInput(
              name: _CategoryFormKeys.icon,
              heading: 'App Icon',
              placeholder: 'Select an Icon',
              validators: FormBuilderValidators.required(),
              icons: categoryIconOptions
                  .map((e) => AppIconOption(key: e.key, icon: e.icon))
                  .toList(),
            ),
            Space.y.t20,
            FormBuilderField<int>(
              name: _CategoryFormKeys.color,
              initialValue: categoryColorOptions.first,
              builder: (field) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoryColorOptions.map((colorValue) {
                      final isSelected = field.value == colorValue;
                      return GestureDetector(
                        onTap: () => field.didChange(colorValue),
                        child: Padding(
                          padding: Space.r.t12,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Color(colorValue),
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: Colors.white, width: 3)
                                  : null,
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Color(
                                          colorValue,
                                        ).withValues(alpha: 0.5),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 18,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
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
