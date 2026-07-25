import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required String icon,
    required int color,
  }) = _Category; // Instantiation in another class

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

