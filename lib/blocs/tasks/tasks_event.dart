import '../../models/task_model.dart';

abstract class TasksEvent {
  const TasksEvent();
}

class SubscribeTasks extends TasksEvent {
  final String uid;
  const SubscribeTasks(this.uid);
}

class TasksUpdated extends TasksEvent {
  final List<TaskModel> tasks;
  const TasksUpdated(this.tasks);
}

class AddTaskRequested extends TasksEvent {
  final String uid;
  final TaskModel task;
  const AddTaskRequested(this.uid, this.task);
}

class UpdateTaskRequested extends TasksEvent {
  final String uid;
  final TaskModel task;
  const UpdateTaskRequested(this.uid, this.task);
}

class DeleteTaskRequested extends TasksEvent {
  final String uid;
  final String taskId;
  const DeleteTaskRequested(this.uid, this.taskId);
}
