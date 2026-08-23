import 'package:drift/drift.dart';
import '../../models/goal/goal.dart' show GoalType;
import 'category_table.dart';
import '../converters.dart';

@DataClassName('GoalData')
class Goal extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get categoryId => text().references(Category, #id)();
  RealColumn get percentageCompleted =>
      real().withDefault(const Constant(0.0))();
  TextColumn get details => text().nullable()();
  TextColumn get type =>
      text().map(const EnumConverter<GoalType>(GoalType.values))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
