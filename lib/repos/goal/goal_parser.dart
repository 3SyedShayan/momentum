part of 'goal_repo.dart';

GoalCompanion _toCompanion(GoalX goal) {
  return GoalCompanion(
    title: Value(goal.title),
    details: Value(goal.details),
    type: Value(goal.type),
    categoryId: Value(goal.category.id!),
  );
}

GoalX _fromData(GoalData data, CategoryData category) {
  return GoalX(
    id: data.id,
    title: data.title,
    details: data.details,
    type: data.type,
    isCompleted: data.isCompleted,
    category: CategoryX(
      id: category.id,
      name: category.name,
      icon: category.icon,
      color: category.color,
    ),
    percentageCompleted: data.percentageCompleted,
    createdAt: data.createdAt,
  );
}
