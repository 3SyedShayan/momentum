import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/models/task/task.dart';

part 'state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskState.def());
}
