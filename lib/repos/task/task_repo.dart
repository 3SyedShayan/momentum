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

  Stream<List<TaskX>> watchAllTasks(DateTime date) {
    return TaskProvider.watchAllTasks(date).map((tasks) {
      final list = tasks.map((task) => _fromData(task)).toList();
      list.sort((a, b) {
        final cmp = a.startTime.compareTo(b.startTime);
        if (cmp != 0) return cmp;
        return a.endTime.compareTo(b.endTime);
      });
      return list;
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
