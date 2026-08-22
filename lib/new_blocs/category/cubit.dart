import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/models/category/category.dart';
import 'package:momentum/repos/category/category_repo.dart';
import 'package:momentum/services/fault/faults.dart';
import 'package:momentum/services/logging/app_log.dart';

part 'state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState.def());

  void addCategory(CategoryX category) async {
    emit(state.copyWith(addCategory: state.addCategory.toLoading()));
    try {
      await CategoryRepo.ins.addCategory(category);
      emit(
        state.copyWith(
          addCategory: state.addCategory.toSuccess(data: category),
        ),
      );
    } catch (e, stack) {
      e.appLog(level: AppLogLevel.error, tag: 'CategoryCubit');
      emit(
        state.copyWith(
          addCategory: state.addCategory.toFailed(
            fault: Fault.fromObjectAndStackTrace(e, stack),
          ),
        ),
      );
    }
  }

  void updateCategory(CategoryX category) async {
    emit(state.copyWith(updateCategory: state.updateCategory.toLoading()));
    try {
      await CategoryRepo.ins.updateCategory(category);
      emit(
        state.copyWith(
          updateCategory: state.updateCategory.toSuccess(data: category),
        ),
      );
    } catch (e, stack) {
      e.appLog(level: AppLogLevel.error, tag: 'CategoryCubit');
      emit(
        state.copyWith(
          updateCategory: state.updateCategory.toFailed(
            fault: Fault.fromObjectAndStackTrace(e, stack),
          ),
        ),
      );
    }
  }

  void deleteCategory(String id) async {
    emit(state.copyWith(deleteCategory: state.deleteCategory.toLoading()));
    try {
      await CategoryRepo.ins.deleteCategory(id);
      emit(state.copyWith(deleteCategory: state.deleteCategory.toSuccess()));
    } catch (e, stack) {
      e.appLog(level: AppLogLevel.error, tag: 'CategoryCubit');
      emit(
        state.copyWith(
          deleteCategory: state.deleteCategory.toFailed(
            fault: Fault.fromObjectAndStackTrace(e, stack),
          ),
        ),
      );
    }
  }
}
