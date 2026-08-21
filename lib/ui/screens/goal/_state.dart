part of 'goal.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  GoalType selectedTab = GoalType.weekly;

  List<GoalX> get goals => allGoals;

  List<GoalX> get currentGoals =>
      allGoals.where((g) => g.type == selectedTab).toList();

  void setTab(GoalType tab) {
    if (selectedTab == tab) return;
    selectedTab = tab;
    notifyListeners();
  }

  void addSessionToToday(GoalX item) {
    final index = allGoals.indexWhere((g) => g.id == item.id);
    if (index != -1 && allGoals[index].percentageCompleted < 1.0) {
      final updated = allGoals[index];
      final newProgress = (updated.percentageCompleted + 0.25).clamp(0.0, 1.0);
      allGoals[index] = updated.copyWith(
        percentageCompleted: newProgress,
        isCompleted: newProgress >= 1.0,
      );
      notifyListeners();
    }
  }

  final categoryFormKey = GlobalKey<FormBuilderState>();
  final goalFormKey = GlobalKey<FormBuilderState>();
  void submitAddCategory(BuildContext context) {
    final form = categoryFormKey.currentState;
    if (form == null || !form.saveAndValidate()) return;
    final values = form.value;

    final category = CategoryX(
      id: null,
      name: values[_CategoryFormKeys.title] as String? ?? '',
      icon: values[_CategoryFormKeys.icon] as String? ?? 'book',
      color: values[_CategoryFormKeys.color] as int? ?? 0xFFEC4899,
    );

    GoalCubit().addCategory(category);
    if (context.mounted) context.pop();
  }

  void submitAddGoal(BuildContext context) {
    final form = goalFormKey.currentState;
    if (form == null || !form.saveAndValidate()) return;
    final values = form.value;
  }
}
