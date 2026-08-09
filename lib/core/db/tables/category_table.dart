import 'package:drift/drift.dart';

@DataClassName('CategoryData')
class Category extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  IntColumn get color => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
