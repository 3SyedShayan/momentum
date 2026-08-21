part of 'cubit.dart';

class GoalState extends Equatable {
  final BlocState<CategoryX> addCategory;
  final BlocState<GoalX> addGoal;
  final GoalType selectedTab;
  final List<GoalX> goals;
  final BlocState<CategoryX>? updateCategory;

  const GoalState({
    required this.addCategory,
    required this.addGoal,
    required this.updateCategory,
    this.selectedTab = GoalType.weekly,
    this.goals = const [],
  });

  GoalState.def()
    : addCategory = BlocState(),
      addGoal = BlocState(),
      selectedTab = GoalType.weekly,
      goals = const [],
      updateCategory = BlocState();

  GoalState copyWith({
    BlocState<CategoryX>? addCategory,
    BlocState<GoalX>? addGoal,
    BlocState<CategoryX>? updateCategory,

    GoalType? selectedTab,
    List<GoalX>? goals,
  }) {
    return GoalState(
      addCategory: addCategory ?? this.addCategory,
      addGoal: addGoal ?? this.addGoal,
      selectedTab: selectedTab ?? this.selectedTab,
      goals: goals ?? this.goals,
      updateCategory: updateCategory ?? this.updateCategory,
    );
  }

  @override
  List<Object?> get props => [
    addCategory,
    addGoal,
    updateCategory,
    selectedTab,
    goals,
  ];
}
