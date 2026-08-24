import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../models/goal/goal.dart' show GoalType;
import 'tables/goal_table.dart';
import 'tables/category_table.dart';
import 'tables/task_table.dart';
import 'converters.dart';

part 'database.g.dart';
part 'daos/category_dao.dart';
part 'daos/goal_dao.dart';
part 'daos/task_dao.dart';

@DriftDatabase(tables: [Category, Goal, Task], daos: [CategoryDao, GoalDao, TaskDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(driftDatabase(name: 'app_db'));

  static final AppDatabase instance = AppDatabase._();

  factory AppDatabase() => instance;

  @override
  int get schemaVersion => 1;
}
