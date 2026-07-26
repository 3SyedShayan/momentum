import 'package:drift/drift.dart';
import 'dart:convert';

class EnumConverter<T extends Enum> extends TypeConverter<T, String> {
  final List<T> values;
  const EnumConverter(this.values);

  @override
  T fromSql(String fromDb) => values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(T value) => value.name;
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List).cast<String>();

  @override
  String toSql(List<String> value) => jsonEncode(value);
}
