part of 'category_repo.dart';

// Data Source Layer - Talks dierectly with Database, raw Data Storage.
// Such as Firebase, Drift, etc.
// It only knows how and where data is stored.
// Dumb, dont know anything else.
// Never exposes business logic or domain models.
class CategoryProvider {
  static final _db = AppDatabase();
  static Future<void> addCategory(CategoryCompanion entry) {
    return _db.categoryDao.addCategory(entry);
  }

  static Future<void> deleteCategory(String id) {
    return _db.categoryDao.deleteCategory(id);
  }
}
