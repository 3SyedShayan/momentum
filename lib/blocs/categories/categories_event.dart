import '../../core/models/category/category.dart';

abstract class CategoriesEvent {
  const CategoriesEvent();
}

class SubscribeCategories extends CategoriesEvent {
  final String uid;
  const SubscribeCategories(this.uid);
}

class CategoriesUpdated extends CategoriesEvent {
  final List<Category> categories;
  const CategoriesUpdated(this.categories);
}

class AddCategoryRequested extends CategoriesEvent {
  final String uid;
  final Category category;
  const AddCategoryRequested(this.uid, this.category);
}

class DeleteCategoryRequested extends CategoriesEvent {
  final String uid;
  final String categoryId;
  const DeleteCategoryRequested(this.uid, this.categoryId);
}
