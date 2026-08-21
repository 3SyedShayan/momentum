import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/blocs/goals/goals_state.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/db/tables/goal_table.dart';
import 'package:momentum/core/models/goal/goal.dart';

part 'state.dart';

@immutable
class GoalCubit extends Cubit<GoalState> {
  GoalCubit() : super(GoalState.def());

  void changeTab(GoalType tab) {
    if (state.selectedTab == tab) return;

    emit(state.copyWith(selectedTab: tab));
  }
}
