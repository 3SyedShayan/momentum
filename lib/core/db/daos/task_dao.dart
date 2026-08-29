part of '../database.dart';

typedef TaskWithCategoryData = ({TaskData task, CategoryData category});

@DriftAccessor(tables: [Task, Category])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);

  // Watch all tasks in real-time ordered by category name, then start time
  Stream<List<TaskWithCategoryData>> watchAllTasks() {
    final query =
        select(task).join([
          innerJoin(category, category.id.equalsExp(task.categoryId)),
        ])..orderBy([
          OrderingTerm.asc(category.name),
          OrderingTerm.asc(task.startTime),
        ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return (task: row.readTable(task), category: row.readTable(category));
      }).toList();
    });
  }

  Future<int> addTask(TaskCompanion entry) {
    return into(task).insert(entry);
  }

  Future<int> updateTask(TaskCompanion entry) {
    return (update(
      task,
    )..where((t) => t.id.equals(entry.id.value))).write(entry);
  }

  Future<int> deleteTask(int id) {
    return (delete(task)..where((t) => t.id.equals(id))).go();
  }
}
