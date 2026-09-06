part of '../database.dart';

typedef TaskWithCategoryData = ({TaskData task, CategoryData category});

@DriftAccessor(tables: [Task, Category])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);

  Stream<List<TaskWithCategoryData>> watchAllTasks(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    final query =
        (select(task)..where(
              (t) =>
                  t.startTime.isBiggerOrEqualValue(startOfDay) &
                  t.startTime.isSmallerThanValue(endOfDay),
            ))
            .join([innerJoin(category, category.id.equalsExp(task.categoryId))])
          ..orderBy([
            OrderingTerm.asc(task.startTime),
            OrderingTerm.asc(task.endTime),
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
