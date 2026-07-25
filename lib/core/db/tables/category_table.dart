import 'package:drift/drift.dart';

@DataClassName('CategoryData')
class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  IntColumn get color => integer()();
}
