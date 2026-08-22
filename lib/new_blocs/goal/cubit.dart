import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/models/goal/goal.dart';
import 'package:momentum/services/fault/faults.dart';
import 'package:momentum/services/logging/app_log.dart';

part 'state.dart';

class GoalCubit extends Cubit<GoalState> {
  GoalCubit() : super(GoalState.def());
}
