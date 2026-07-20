import '../../models/goal_model.dart';

abstract class GoalsState {
  const GoalsState();
}

class GoalsInitial extends GoalsState {}

class GoalsLoading extends GoalsState {}

class GoalsLoaded extends GoalsState {
  final List<GoalModel> goals;
  const GoalsLoaded(this.goals);
}

class GoalsError extends GoalsState {
  final String message;
  const GoalsError(this.message);
}
