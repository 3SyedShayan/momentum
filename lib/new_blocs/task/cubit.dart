import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/models/task/task.dart';
import 'package:momentum/repos/task/task_repo.dart';

part 'state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskState.def());

  // void getTasks() async {
  //   emit(
  //     state.copyWith(
  //       getTasks: state.getTasks.toLoading(),
  //     ),
  //   );
  //   await TaskRepo.ins.watchAllTasks().listen((tasks) {
  //     emit(state.copyWith(getTasks: BlocState(data: tasks)));
  //   }).asFuture();
  // }

  void addTask(TaskX task) async {
    emit(state.copyWith(addTask: state.addTask.toLoading()));
    await TaskRepo.ins.addTask(task);
    emit(
      state.copyWith(
        addTask: state.addTask.toSuccess(),
        tasks: [...state.tasks, task],
      ),
    );
  }

  void updateTask(TaskX task) async {
    emit(state.copyWith(updateTask: state.updateTask.toLoading()));
    await TaskRepo.ins.updateTask(task);
    emit(state.copyWith(updateTask: state.updateTask.toSuccess()));
  }

  void deleteTask(int id) async {
    emit(state.copyWith(removeTask: state.removeTask.toLoading()));
    await TaskRepo.ins.deleteTask(id);
    emit(state.copyWith(removeTask: state.removeTask.toSuccess()));
  }
}
