import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/category_table.dart';
part 'database.g.dart';
part 'daos/category_dao.dart';

@DriftDatabase(tables: [Category], daos: [CategoryDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'app_db'));

  @override
  int get schemaVersion => 1;
}

