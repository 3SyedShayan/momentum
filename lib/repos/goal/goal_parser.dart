part of 'goal_repo.dart';

GoalCompanion _toCompanion(GoalX goal) {
  return GoalCompanion(
    id: Value(goal.id),
    title: Value(goal.title),
    details: Value(goal.details),
    color: Value(goal.category.color),
    type: Value(goal.type),
    isCompleted: Value(goal.isCompleted),
    categoryId: Value(goal.category.id!),
    percentageCompleted: Value(goal.percentageCompleted),
    createdAt: Value(goal.createdAt),
  );
}

GoalX _fromData(GoalData data, CategoryData category) {
  return GoalX(
    id: data.id,
    title: data.title,
    details: data.details,
    color: category.color,
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
