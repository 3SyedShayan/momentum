part of '../goal.dart';

class AddCategoryModal extends StatelessWidget {
  const AddCategoryModal({super.key, this.category});
  final CategoryX? category;

  static Future<void> show(BuildContext context, {CategoryX? category}) {
    final state = _ScreenState.s(context);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ChangeNotifierProvider.value(
        value: state,
        child: AddCategoryModal(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);
    final isEditing = category != null;

    final initialValue = isEditing
        ? {
            _CategoryFormKeys.title: category!.name,
            _CategoryFormKeys.color: category!.color,
            _CategoryFormKeys.icon: category!.icon,
          }
        : _GoalFormData.initialCategoryValues();

    return FormBuilder(
      key: state.categoryFormKey,
      initialValue: initialValue,
      child: Padding(
        padding: Space.a.t20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditing ? 'Edit Category' : 'Add New Category',
                  style: AppText.h2,
                ),
                if (isEditing)
                  IconButton(
                    icon: const Icon(
                      LucideIcons.trash_2,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: () =>
                        confirmDelete(context, category!),
                  ),
              ],
            ),
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

            Space.y.t20,
            AppButton(
              label: isEditing ? 'Update Category' : 'Save Category',
              onTap: () => state.submitAddCategory(
                context,
                existingCategory: category,
              ),
            ),
            if (isEditing) ...[
              Space.y.t12,
              AppButton(
                label: 'Delete Category',
                style: AppButtonStyle.error,
                icon: LucideIcons.trash_2,
                onTap: () =>
                    confirmDelete(context, category!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static void confirmDelete(
    BuildContext context,
    CategoryX category,
  ) {
    final state = _ScreenState.s(context);
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text('Are you sure you want to delete "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              state.deleteCategory(context, category);
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
