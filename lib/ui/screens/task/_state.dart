part of 'task.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final categoryFormKey = GlobalKey<FormBuilderState>();
  final taskFormKey = GlobalKey<FormBuilderState>();

  Stream<List<TaskX>> watchAllTasks() {
    return TaskRepo.ins.watchAllTasks();
  }

  Stream<List<CategoryX>> watchAllCategories() {
    return CategoryRepo.ins.watchAllCategories();
  }

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

  void submitAddTask(BuildContext context) {
    final form = taskFormKey.currentState;
    if (form == null || !form.saveAndValidate()) return;
    final values = form.value;

    final title = values[_TaskFormKeys.title] as String? ?? '';
    final description = values[_TaskFormKeys.description] as String?;
    final category = values[_TaskFormKeys.category] as CategoryX;
    final startTime =
        values[_TaskFormKeys.startTime] as DateTime? ?? DateTime.now();
    final endTime =
        values[_TaskFormKeys.endTime] as DateTime? ??
        startTime.add(const Duration(hours: 1));

    final task = TaskX(
      id: 0,
      title: title,
      description: description,
      category: category,
      startTime: startTime,
      endTime: endTime,
      isCompleted: false,
    );

    TaskCubit().addTask(task);

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
