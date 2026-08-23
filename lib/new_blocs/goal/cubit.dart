import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/models/goal/goal.dart';
import 'package:momentum/repos/goal/goal_repo.dart';
import 'package:momentum/services/fault/faults.dart';
import 'package:momentum/services/logging/app_log.dart';

part 'state.dart';

class GoalCubit extends Cubit<GoalState> {
  GoalCubit() : super(GoalState.def());

  void addGoal(GoalX goal) async {
    emit(state.copyWith(addGoal: state.addGoal.toLoading()));

    try {
      await GoalRepo.ins.addGoal(goal);
      emit(state.copyWith(addGoal: state.addGoal.toSuccess(data: goal)));
    } catch (e, stack) {
      e.appLog(level: AppLogLevel.error, tag: 'GoalCubit');
      emit(
        state.copyWith(
          addGoal: state.addGoal.toFailed(
            fault: Fault.fromObjectAndStackTrace(e, stack),
          ),
        ),
      );
    }
  }
}
