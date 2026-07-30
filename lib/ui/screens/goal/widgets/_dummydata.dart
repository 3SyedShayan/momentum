part of '../goal.dart';

final List<GoalItem> allGoals = [
  GoalItem(
    id: '1',
    title: 'Read 3 books',
    category: 'Reading',
    completedSessions: 1,
    totalSessions: 3,
    accentColor: AppTheme.c.accent,
    frequency: GoalFrequency.monthly,
  ),
  GoalItem(
    id: '2',
    title: 'Gym 4 times',
    category: 'Fitness',
    completedSessions: 3,
    totalSessions: 4,
    accentColor: AppTheme.c.accent,
    frequency: GoalFrequency.weekly,
  ),
  GoalItem(
    id: '3',
    title: 'Finish project report',
    category: 'Work',
    completedSessions: 2,
    totalSessions: 2,
    accentColor: AppTheme.c.accent,
    frequency: GoalFrequency.weekly,
  ),
  GoalItem(
    id: '4',
    title: 'Meditate daily',
    category: 'Mindfulness',
    completedSessions: 5,
    totalSessions: 7,
    accentColor: AppTheme.c.accent,
    frequency: GoalFrequency.weekly,
  ),
  GoalItem(
    id: '5',
    title: 'Learn 50 new words',
    category: 'Learning',
    completedSessions: 0,
    totalSessions: 50,
    accentColor: AppTheme.c.accent,
    frequency: GoalFrequency.monthly,
  ),
];
