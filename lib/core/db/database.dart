import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../models/goal/goal.dart' show GoalType;
import 'tables/goal_table.dart';
import 'tables/category_table.dart';
import 'converters.dart';

part 'database.g.dart';
part 'daos/category_dao.dart';
part 'daos/goal_dao.dart';

@DriftDatabase(tables: [Category, Goal], daos: [CategoryDao, GoalDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'app_db'));

  @override
  int get schemaVersion => 1;
}
