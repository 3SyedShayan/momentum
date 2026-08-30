part of 'task_repo.dart';

TaskData _toData(TaskX task) {
  return TaskData(
    id: task.id ?? 0,
    title: task.title,
    description: task.description,
    startTime: task.startTime,
    endTime: task.endTime,
    isCompleted: task.isCompleted,
    categoryId: task.category.id!,
  );
}

TaskX _fromData(TaskWithCategoryData task) {
  final taskData = task.task;
  final categoryData = task.category;
  return TaskX(
    id: taskData.id,
    title: taskData.title,
    description: taskData.description,
    startTime: taskData.startTime,
    endTime: taskData.endTime,
    isCompleted: taskData.isCompleted,
    category: CategoryX(
      id: categoryData.id,
      name: categoryData.name,
      icon: categoryData.icon,
      color: categoryData.color,
    ),
  );
}

TaskCompanion _toCompanion(TaskX task) {
  return TaskCompanion(
    id: (task.id != null && task.id != 0)
        ? Value(task.id!)
        : const Value.absent(),
    title: Value(task.title),
    description: task.description != null
        ? Value(task.description)
        : const Value.absent(),
    startTime: Value(task.startTime),
    endTime: Value(task.endTime),
    isCompleted: Value(task.isCompleted),
    categoryId: Value(task.category.id!),
  );
}
