import 'package:drift/drift.dart';
import 'package:momentum/core/db/database.dart';
import 'package:momentum/core/models/category/category.dart';

part 'category_parser.dart';
part 'category_mocks.dart';
part 'category_provider.dart';

// Single Source of truth for Public Interface, UI, Blocs and Cubits

class CategoryRepo {
  static CategoryRepo get ins => _instance;

  CategoryRepo._();

  static final _instance = CategoryRepo._();
  Future<void> addCategory(CategoryX category) {
    final comp = _toCompanion(category);
    return CategoryProvider.addCategory(comp);
  }

  Future<void> deleteCategory(String id) {
    return CategoryProvider.deleteCategory(id);
  }

  Stream<List<CategoryX>> watchCategories() {
    return CategoryProvider.watchAllCategories().map(
      (list) => list.map(_fromData).toList(),
    );
  }
}
