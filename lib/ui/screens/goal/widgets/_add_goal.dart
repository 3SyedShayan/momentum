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
    return SingleChildScrollView(
      child: FormBuilder(
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
                name: _GoalFormKeys.details,
                heading: 'Details',
                placeholder: 'e.g., Run 5k daily.',
                validators: FormBuilderValidators.required(),
              ),
              Space.y.t20,
              // Category Selector in _add_goal.dart
              FormBuilderField<CategoryX>(
                name: _GoalFormKeys.category,
                validator: FormBuilderValidators.required(
                  errorText: 'Please select a category',
                ),
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Category', style: AppText.b1b),
                      Space.y.t08,
                      StreamBuilder<List<CategoryX>>(
                        stream: CategoryRepo.ins.watchAllCategories(),
                        builder: (context, snapshot) {
                          final categories = snapshot.data ?? [];
                          if (categories.isEmpty) {
                            return Text(
                              'No categories available. Please create one first.',
                              style: AppText.b2.cl(AppTheme.c.subText),
                            );
                          }

                          return Wrap(
                            spacing: SpaceToken.t08,
                            runSpacing: SpaceToken.t08,
                            children: categories.map((cat) {
                              final isSelected = field.value?.id == cat.id;

                              return GestureDetector(
                                onTap: () => field.didChange(cat),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SpaceToken.t12,
                                    vertical: SpaceToken.t08,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Color(
                                            cat.color,
                                          ).withValues(alpha: 0.15)
                                        : AppTheme.c.subBackground,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? Color(cat.color)
                                          : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(cat.color),
                                        radius: 5,
                                      ),
                                      Space.x.t08,
                                      Text(
                                        cat.name,
                                        style: AppText.b2
                                            .w(isSelected ? 6 : 4)
                                            .cl(
                                              isSelected
                                                  ? AppTheme.c.text
                                                  : AppTheme.c.subText,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      if (field.hasError) ...[
                        Space.y.t04,
                        Text(
                          field.errorText!,
                          style: AppText.b1.cl(Colors.red),
                        ),
                      ],
                    ],
                  );
                },
              ),

              Space.y.t20,
              const _GoalTypeField(),
              Space.y.t20,

              AppButton(
                label: 'Save Goal',
                onTap: () => state.submitAddGoal(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
