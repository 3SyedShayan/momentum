import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class CategoryX with _$CategoryX {
  const factory CategoryX({
    required String? id,
    required String name,
    required String icon,
    required int color,
  }) = _CategoryX; // Instantiation in another class

  factory CategoryX.fromJson(Map<String, dynamic> json) =>
      _$CategoryXFromJson(json);
}
