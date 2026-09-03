part of 'task_repo.dart';

class TaskProvider {
  static final _db = AppDatabase();

  static Stream<List<TaskWithCategoryData>> watchAllTasks(DateTime date) {
    return _db.taskDao.watchAllTasks(date);
  }

  static Future<int> addTask(TaskCompanion entry) {
    return _db.taskDao.addTask(entry);
  }

  static Future<int> updateTask(TaskCompanion entry) {
    return _db.taskDao.updateTask(entry);
  }

  static Future<int> deleteTask(int id) {
    return _db.taskDao.deleteTask(id);
  }
}
