part of 'cubit.dart';

class GoalState extends Equatable {
  final BlocState<GoalX> addGoal;
  final BlocState<GoalX> removeGoal;
  final BlocState<GoalX> updateGoal;

  final List<GoalX> goals;

  const GoalState({
    required this.addGoal,
    this.goals = const [],
    required this.removeGoal,
    required this.updateGoal,
  });

  GoalState.def()
    : addGoal = BlocState(),
      removeGoal = BlocState(),
      updateGoal = BlocState(),
      goals = const [];

  GoalState copyWith({
    BlocState<GoalX>? addGoal,

    List<GoalX>? goals,
    BlocState<GoalX>? removeGoal,
    BlocState<GoalX>? updateGoal,
  }) {
    return GoalState(
      addGoal: addGoal ?? this.addGoal,
      goals: goals ?? this.goals,
      removeGoal: removeGoal ?? this.removeGoal,
      updateGoal: updateGoal ?? this.updateGoal,
    );
  }

  @override
  List<Object?> get props => [addGoal, goals];
}
