part of 'task.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final categoryFormKey = GlobalKey<FormBuilderState>();
  final taskFormKey = GlobalKey<FormBuilderState>();

  DateTime selectedDate = DateTime.now();
  bool get canAddTask {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    final maxDate = DateTime(today.year, today.month, today.day + 2);
    return !target.isBefore(today) && !target.isAfter(maxDate);
  }

  Stream<List<TaskX>> watchAllTasks(DateTime date) {
    return TaskRepo.ins.watchAllTasks(date);
  }

  Stream<List<CategoryX>> watchAllCategories() {
    return CategoryRepo.ins.watchAllCategories();
  }

  Set<int> getOccupiedHours(List<TaskX> tasks) {
    return PlannerEngine.getOccupiedHours(tasks, forDate: selectedDate);
  }

  List<int> getAvailableEndHours(int startHour, Set<int> occupiedHours) {
    return PlannerEngine.getAvailableEndHours(
      startHour: startHour,
      occupiedHours: occupiedHours,
    );
  }

  void submitAddTask(
    BuildContext context, {
    required int startHour,
    required int endHour,
    required Set<int> occupiedHours,
  }) {
    if (!canAddTask) return;
    final form = taskFormKey.currentState;
    if (form == null || !form.saveAndValidate()) return;
    final isValid = PlannerEngine.isRangeAvailable(
      startHour: startHour,
      endHour: endHour,
      occupiedHours: occupiedHours,
    );
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Time slot is already occupied.')),
      );
      return;
    }

    final values = form.value;

    final title = values[_TaskFormKeys.title] as String? ?? '';
    final description = values[_TaskFormKeys.description] as String?;
    final category = values[_TaskFormKeys.category] as CategoryX;

    final task = TaskX(
      title: title,
      description: description,
      category: category,
      startTime: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        startHour,
      ),
      endTime: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        endHour,
      ),
      isCompleted: false,
    );

    TaskCubit().addTask(task);

    if (context.mounted) context.pop();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  // void changeDate(DateTime date) => setSelectedDate(date);

  void toggleTaskCompletion(TaskX task) {
    final updated = task.copyWith(isCompleted: !task.isCompleted);
    TaskCubit().updateTask(updated);
  }

  void submitAddCategory(BuildContext context, {CategoryX? existingCategory}) {
    final form = categoryFormKey.currentState;
    if (form == null || !form.saveAndValidate()) return;
    final values = form.value;

    final category = CategoryX(
      id: existingCategory?.id,
      name: values[_CategoryFormKeys.title] as String? ?? '',
      icon: values[_CategoryFormKeys.icon] as String? ?? 'book',
      color: values[_CategoryFormKeys.color] as int? ?? 0xFF3B82F6,
    );

    if (existingCategory != null) {
      CategoryCubit().updateCategory(category);
    } else {
      CategoryCubit().addCategory(category);
    }
    if (context.mounted) context.pop();
  }

  String formatTimeShort(DateTime time) {
    final hour = time.hour > 12
        ? time.hour - 12
        : (time.hour == 0 ? 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
