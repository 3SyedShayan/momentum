import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/category/category.dart';
import '../../repositories/momentum_repository.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final MomentumRepository _momentumRepository;
  StreamSubscription<List<Category>>? _categoriesSubscription;

  CategoriesBloc({required MomentumRepository momentumRepository})
      : _momentumRepository = momentumRepository,
        super(CategoriesInitial()) {
    on<SubscribeCategories>(_onSubscribeCategories);
    on<CategoriesUpdated>(_onCategoriesUpdated);
    on<AddCategoryRequested>(_onAddCategoryRequested);
    on<DeleteCategoryRequested>(_onDeleteCategoryRequested);
  }

  Future<void> _onSubscribeCategories(
    SubscribeCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    await _categoriesSubscription?.cancel();
    _categoriesSubscription =
        _momentumRepository.getCategories(event.uid).listen(
      (categories) {
        add(CategoriesUpdated(categories));
      },
      onError: (error) {
        emit(CategoriesError(error.toString()));
      },
    );
  }

  void _onCategoriesUpdated(
    CategoriesUpdated event,
    Emitter<CategoriesState> emit,
  ) {
    emit(CategoriesLoaded(event.categories));
  }

  Future<void> _onAddCategoryRequested(
    AddCategoryRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      await _momentumRepository.addCategory(event.uid, event.category);
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> _onDeleteCategoryRequested(
    DeleteCategoryRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      await _momentumRepository.deleteCategory(event.uid, event.categoryId);
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
