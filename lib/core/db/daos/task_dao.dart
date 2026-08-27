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
}
