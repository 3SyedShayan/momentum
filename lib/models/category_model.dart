import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String colorHex;

  CategoryModel({
    required this.id,
    required this.name,
    required this.colorHex,
  });

  Color get color {
    final hex = colorHex.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    }
    return Colors.blue;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      name: map['name'] ?? '',
      colorHex: map['colorHex'] ?? '#1A56DB',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'colorHex': colorHex,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? colorHex,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
    );
  }
}
