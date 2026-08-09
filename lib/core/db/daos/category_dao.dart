part of '../database.dart';

@DriftAccessor(tables: [Category])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  String _deriveId(String name) => name.toLowerCase().trim();

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

  /// Get a single category by its ID (lowercased name)
  Future<CategoryData?> getCategoryById(String id) {
    return (select(category)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Check if a category already exists using name → id lookup.
  /// Lowercases and trims the name, then checks by derived ID.
  Future<bool> categoryExistsByName(String name) async {
    final id = _deriveId(name);
    final result = await (select(
      category,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return result != null;
  }

  // --- Adding / Inserting ---

  /// Add a new category. The ID is automatically derived from the name
  /// (lowercase + trim). If a category with that ID already exists,
  /// its icon and color are updated instead.
  Future<String> addCategory(CategoryCompanion entry) async {
    final id = _deriveId(entry.name.value);

    final existing = await (select(
      category,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (existing != null) {
      // Category exists — update icon and color
      await (update(category)..where((t) => t.id.equals(id))).write(
        CategoryCompanion(icon: entry.icon, color: entry.color),
      );
      return id;
    }

    // Insert new category with derived ID
    await into(category).insert(entry.copyWith(id: Value(id)));
    return id;
  }

  // --- Removing / Deleting ---

  /// Delete a category by its ID
  Future<int> deleteCategory(String id) {
    return (delete(category)..where((t) => t.id.equals(id))).go();
  }

  // --- Updating ---

  /// Update an existing category
  Future<bool> updateCategory(CategoryData entry) {
    return update(category).replace(entry);
  }
}
