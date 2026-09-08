part of 'cubit.dart';

class TaskState extends Equatable {
  final BlocState<TaskX> addTask;
  final BlocState<TaskX> removeTask;
  final BlocState<TaskX> updateTask;
  final BlocState<TaskX> getTasks;

  final List<TaskX> tasks;

  const TaskState({
    required this.addTask,
    this.tasks = const [],
    required this.removeTask,
    required this.updateTask,
    required this.getTasks,
  });

  TaskState.def()
    : addTask = BlocState(),
      getTasks = BlocState(),
      removeTask = BlocState(),
      updateTask = BlocState(),
      tasks = const [];

  TaskState copyWith({
    BlocState<TaskX>? addTask,
    List<TaskX>? tasks,
    BlocState<TaskX>? removeTask,
    BlocState<TaskX>? updateTask,
    BlocState<TaskX>? getTasks,
  }) {
    return TaskState(
      addTask: addTask ?? this.addTask,
      tasks: tasks ?? this.tasks,
      removeTask: removeTask ?? this.removeTask,
      updateTask: updateTask ?? this.updateTask,
      getTasks: getTasks ?? this.getTasks,
    );
  }

  @override
  List<Object?> get props => [addTask, tasks, removeTask, updateTask, getTasks];
}
