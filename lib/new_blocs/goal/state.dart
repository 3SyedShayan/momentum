part of 'cubit.dart';

class GoalState extends Equatable {
  final BlocState<CategoryX> addCategory;
  final BlocState<GoalX> addGoal;
  final GoalType selectedTab;
  final List<GoalX> goals;

  const GoalState({
    required this.addCategory,
    required this.addGoal,
    this.selectedTab = GoalType.weekly,
    this.goals = const [],
  });

  GoalState.def()
    : addCategory = BlocState(),
      addGoal = BlocState(),
      selectedTab = GoalType.weekly,
      goals = const [];

  GoalState copyWith({
    BlocState<CategoryX>? addCategory,
    BlocState<GoalX>? addGoal,
    GoalType? selectedTab,
    List<GoalX>? goals,
  }) {
    return GoalState(
      addCategory: addCategory ?? this.addCategory,
      addGoal: addGoal ?? this.addGoal,
      selectedTab: selectedTab ?? this.selectedTab,
      goals: goals ?? this.goals,
    );
  }

  @override
  List<Object?> get props => [addCategory, addGoal, selectedTab, goals];
}
