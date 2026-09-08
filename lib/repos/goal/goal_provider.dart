part of 'goal_repo.dart';

class GoalProvider {
  static final _db = AppDatabase();
  static Stream<List<GoalWithCategoryData>> watchAllGoals() {
    return _db.goalDao.watchGoalsWithCategories();
  }

  static Future<int> addGoal(GoalCompanion entry) {
    return _db.goalDao.addGoal(entry);
  }

  static Future<int> deleteGoal(int id) {
    return _db.goalDao.deleteGoal(id);
  }

  static Future<int> setGoalCompletion(int id, bool isCompleted) {
    return _db.goalDao.setGoalCompletion(id, isCompleted);
  }
}
