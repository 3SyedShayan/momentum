import '../../models/task_model.dart';

abstract class TasksState {
  const TasksState();
}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<TaskModel> tasks;
  const TasksLoaded(this.tasks);
}

class TasksError extends TasksState {
  final String message;
  const TasksError(this.message);
}
