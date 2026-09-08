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
    if (target.isBefore(today) || target.isAfter(maxDate)) {
      return false;
    }
    if (target.isAtSameMomentAs(today)) {
      final pastHours = getPastHours();
      if (pastHours.length >= 24) {
        return false;
      }
    }
    return true;
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

  Set<int> getPastHours() {
    return PlannerEngine.getPastHours(forDate: selectedDate);
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

    final startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startHour,
    );
    final endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      endHour,
    );

    final now = DateTime.now();
    if (startDateTime.isBefore(now)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot add task for a time that has already passed.'),
        ),
      );
      return;
    }

    final pastHours = getPastHours();
    final isValid = PlannerEngine.isRangeAvailable(
      startHour: startHour,
      endHour: endHour,
      occupiedHours: occupiedHours,
      pastHours: pastHours,
    );
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Time slot is unavailable or occupied.')),
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
      startTime: startDateTime,
      endTime: endDateTime,
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
