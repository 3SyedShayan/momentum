part of '../database.dart';

typedef GoalWithCategoryData = ({GoalData goal, CategoryData category});

@DriftAccessor(tables: [Goal, Category])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  GoalDao(super.db);

  // --- Viewing / Reading ---

  /// Watch all goals in real-time ordered by creation date (newest first)
  Stream<List<GoalData>> watchAllGoals() {
    return (select(
      goal,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  }

  /// Get all goals once
  Future<List<GoalData>> getAllGoals() {
    return (select(
      goal,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  }

  /// Add a new goal
  Future<int> addGoal(GoalCompanion entry) {
    return into(goal).insert(entry);
  }

  // --- Removing / Deleting ---

  /// Delete a goal by its ID
  Future<int> deleteGoal(int id) {
    return (delete(goal)..where((t) => t.id.equals(id))).go();
  }

  // --- Updating ---

  /// Update an existing goal
  Future<bool> updateGoal(GoalData entry) {
    return update(goal).replace(entry);
  }

  Stream<List<GoalWithCategoryData>> watchGoalsWithCategories() {
    final query = select(goal).join([
      innerJoin(category, category.id.equalsExp(goal.categoryId)),
    ])..orderBy([OrderingTerm.desc(goal.createdAt)]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return (goal: row.readTable(goal), category: row.readTable(category));
      }).toList();
    });
  }
}
