part of '../database.dart';

@DriftAccessor(tables: [Category])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(AppDatabase db) : super(db);

  // --- Viewing / Reading ---

  /// Watch all categories in real-time ordered by name
  Stream<List<CategoryData>> watchAllCategories() {
    return (select(
      category,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  /// Get all categories once
  Future<List<CategoryData>> getAllCategories() {
    return (select(category)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  /// Get a single category by its ID
  Future<CategoryData?> getCategoryById(int id) {
    return (select(category)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  // --- Adding / Inserting ---

  /// Add a new category
  Future<int> addCategory(CategoryCompanion entry) {
    return into(category).insert(entry);
  }

  // --- Removing / Deleting ---

  /// Delete a category by its ID
  Future<int> deleteCategory(int id) {
    return (delete(category)..where((t) => t.id.equals(id))).go();
  }

  // --- Updating ---

  /// Update an existing category
  Future<bool> updateCategory(CategoryData entry) {
    return update(category).replace(entry);
  }
}
