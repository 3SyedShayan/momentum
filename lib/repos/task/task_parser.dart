part of 'task_repo.dart';

TaskData _toData(TaskX task) {
  return TaskData(
    id: task.id,
    title: task.title,
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
    id: Value(task.id),
    title: Value(task.title),
    startTime: Value(task.startTime),
    endTime: Value(task.endTime),
    isCompleted: Value(task.isCompleted),
    categoryId: Value(task.category.id!),
  );
}
