import 'package:drift/drift.dart';
import 'package:momentum/core/db/database.dart';
import 'package:momentum/core/models/category/category.dart';
import 'package:momentum/core/models/task/task.dart';

part 'task_parser.dart';
part 'task_provider.dart';

class TaskRepo {
  static TaskRepo get ins => _instance;
  TaskRepo._();

  static final _instance = TaskRepo._();

  Stream<List<TaskX>> watchAllTasks() {
    return TaskProvider.watchAllTasks().map((tasks) {
      return tasks.map((task) => _fromData(task)).toList();
    });
  }

  Future<void> addTask(TaskX task) async {
    await TaskProvider.addTask(_toCompanion(task));
  }

  Future<void> updateTask(TaskX task) async {
    await TaskProvider.updateTask(_toCompanion(task));
  }

  Future<void> deleteTask(int id) async {
    await TaskProvider.deleteTask(id);
  }
}
