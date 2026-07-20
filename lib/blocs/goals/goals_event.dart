import '../../models/goal_model.dart';

abstract class GoalsEvent {
  const GoalsEvent();
}

class SubscribeGoals extends GoalsEvent {
  final String uid;
  const SubscribeGoals(this.uid);
}

class GoalsUpdated extends GoalsEvent {
  final List<GoalModel> goals;
  const GoalsUpdated(this.goals);
}

class AddGoalRequested extends GoalsEvent {
  final String uid;
  final GoalModel goal;
  const AddGoalRequested(this.uid, this.goal);
}

class UpdateGoalRequested extends GoalsEvent {
  final String uid;
  final GoalModel goal;
  const UpdateGoalRequested(this.uid, this.goal);
}

class DeleteGoalRequested extends GoalsEvent {
  final String uid;
  final String goalId;
  const DeleteGoalRequested(this.uid, this.goalId);
}

class AddGoalToTodayRequested extends GoalsEvent {
  final String uid;
  final GoalModel goal;
  const AddGoalToTodayRequested(this.uid, this.goal);
}
