part of 'cubit.dart';

class GoalState extends Equatable {
  final BlocState<GoalX> add;
  final GoalType selectedTab;
  final List<GoalX> goals;

  const GoalState({
    required this.add,
    this.selectedTab = GoalType.weekly,
    this.goals = const [],
  });

  GoalState.def()
    : add = BlocState(),
      selectedTab = GoalType.weekly,
      goals = const [];

  GoalState copyWith({
    BlocState<GoalX>? add,
    GoalType? selectedTab,
    List<GoalX>? goals,
  }) {
    return GoalState(
      add: add ?? this.add,
      selectedTab: selectedTab ?? this.selectedTab,
      goals: goals ?? this.goals,
    );
  }

  @override
  List<Object?> get props => [add, selectedTab, goals];
}
