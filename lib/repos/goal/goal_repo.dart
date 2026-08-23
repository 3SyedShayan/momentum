import 'package:drift/drift.dart';
import 'package:momentum/core/db/database.dart';
import 'package:momentum/core/models/category/category.dart';
import 'package:momentum/core/models/goal/goal.dart';
part 'goal_parser.dart';
part 'goal_provider.dart';
part 'goal_mocks.dart';

class GoalRepo {
  static GoalRepo get ins => _instance;
  GoalRepo._();

  static final _instance = GoalRepo._();

  Stream<List<GoalX>> watchAllGoals() {
    return GoalProvider.watchAllGoals().map(
      (list) => list.map((e) => _fromData(e.goal, e.category)).toList(),
    );
  }

  Future<void> addGoal(GoalX goal) {
    final comp = _toCompanion(goal);
    return GoalProvider.addGoal(comp);
  }
}
