part of '../goal.dart';

final List<GoalX> allGoals = [
  GoalX(
    id: 1,
    title: 'Read 3 books',
    category: allCategories[0],
    percentageCompleted: 0.33,

    type: GoalType.monthly,
    createdAt: DateTime(2026, 1, 1),
  ),
  GoalX(
    id: 2,
    title: 'Gym 4 times',
    category: allCategories[1],
    percentageCompleted: 0.75,
    type: GoalType.weekly,
    createdAt: DateTime(2026, 1, 1),
  ),
  GoalX(
    id: 3,
    title: 'Finish project report',
    category: allCategories[2],
    percentageCompleted: 1.0,
    type: GoalType.weekly,
    isCompleted: true,
    createdAt: DateTime(2026, 1, 1),
  ),
  GoalX(
    id: 4,
    title: 'Meditate daily',
    category: allCategories[3],
    percentageCompleted: 0.71,
    type: GoalType.weekly,
    createdAt: DateTime(2026, 1, 1),
  ),
  GoalX(
    id: 5,
    title: 'Learn 50 new words',
    category: allCategories[4],
    percentageCompleted: 0.0,
    type: GoalType.monthly,
    createdAt: DateTime(2026, 1, 1),
  ),
];
