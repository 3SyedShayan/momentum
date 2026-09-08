part of 'goal.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  GoalType selectedTab = GoalType.weekly;

  void setTab(GoalType tab) {
    if (selectedTab == tab) return;
    selectedTab = tab;
    notifyListeners();
  }

  Stream<List<GoalX>> watchAllGoals() {
    return GoalRepo.ins.watchAllGoals();
  }

  void deleteCategory(BuildContext context, CategoryX category) {
    if (category.id != null) {
      CategoryCubit().deleteCategory(category.id!);
    }
    if (context.mounted) context.pop();
  }

  void deleteGoal(int id) {
    GoalCubit().deleteGoal(id);
  }

  void toggleGoalCompletion(GoalX goal) {
    if (goal.id != null) {
      final newStatus = !(goal.isCompleted ?? false);
      GoalCubit().toggleGoalCompletion(goal.id!, newStatus);
    }
  }

  final categoryFormKey = GlobalKey<FormBuilderState>();
  final goalFormKey = GlobalKey<FormBuilderState>();
  void submitAddCategory(BuildContext context, {CategoryX? existingCategory}) {
    final form = categoryFormKey.currentState;
    if (form == null || !form.saveAndValidate()) return;
    final values = form.value;

    final category = CategoryX(
      id: existingCategory?.id,
      name: values[_CategoryFormKeys.title] as String? ?? '',
      icon: values[_CategoryFormKeys.icon] as String? ?? 'book',
      color: values[_CategoryFormKeys.color] as int? ?? 0xFFEC4899,
    );

    if (existingCategory != null) {
      CategoryCubit().updateCategory(category);
    } else {
      CategoryCubit().addCategory(category);
    }
    if (context.mounted) context.pop();
  }

  void submitAddGoal(BuildContext context) {
    final form = goalFormKey.currentState;
    if (form == null || !form.saveAndValidate()) return;
    final values = form.value;

    final goal = GoalX(
      title: values[_GoalFormKeys.title] as String? ?? '',
      details: values[_GoalFormKeys.details] as String?,
      category: values[_GoalFormKeys.category] as CategoryX,
      type: values[_GoalFormKeys.type] as GoalType? ?? GoalType.weekly,
    );
    GoalCubit().addGoal(goal);

    if (context.mounted) context.pop();
  }
}
