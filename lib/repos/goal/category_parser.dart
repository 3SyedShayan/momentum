part of 'category_repo.dart';

CategoryCompanion _toCompanion(CategoryX category) {
  return CategoryCompanion(
    name: Value(category.name),
    icon: Value(category.icon),
    color: Value(category.color),
    // id is intentionally absent — the DAO derives it from the name
  );
}

CategoryX _fromData(CategoryData data) {
  return CategoryX(
    id: data.id,
    name: data.name,
    icon: data.icon,
    color: data.color,
  );
}
