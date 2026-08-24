import 'package:drift/drift.dart';
import 'category_table.dart';

@DataClassName("TaskData")
class Task extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get categoryId => text().references(Category, #id)();
}

