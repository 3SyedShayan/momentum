part of 'cubit.dart';

class CategoryState extends Equatable {
  final BlocState<CategoryX> addCategory;
  final BlocState<CategoryX> updateCategory;
  final BlocState<CategoryX> deleteCategory;

  const CategoryState({
    required this.addCategory,
    required this.updateCategory,
    required this.deleteCategory,
  });

  CategoryState.def()
    : addCategory = BlocState(),
      updateCategory = BlocState(),
      deleteCategory = BlocState();

  @override
  List<Object?> get props => [addCategory, updateCategory, deleteCategory];

  CategoryState copyWith({
    BlocState<CategoryX>? addCategory,
    BlocState<CategoryX>? updateCategory,
    BlocState<CategoryX>? deleteCategory,
  }) {
    return CategoryState(
      addCategory: addCategory ?? this.addCategory,
      updateCategory: updateCategory ?? this.updateCategory,
      deleteCategory: deleteCategory ?? this.deleteCategory,
    );
  }
}
