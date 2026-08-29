part of '../task.dart';

final List<TaskX> allTasks = [
  TaskX(
    id: 1,
    title: 'Morning Workout & Stretch',
    description: 'Complete 30 mins cardio and core routine.',
    startTime: DateTime(2026, 7, 15, 7, 0),
    endTime: DateTime(2026, 7, 15, 7, 45),
    isCompleted: true,
    category: allCategories[1],
  ),
  TaskX(
    id: 2,
    title: 'Flutter Architecture Refactoring',
    description: 'Break down daily planner screen into modular task widgets.',
    startTime: DateTime(2026, 7, 15, 9, 0),
    endTime: DateTime(2026, 7, 15, 11, 30),
    isCompleted: false,
    category: allCategories[2],
  ),
  TaskX(
    id: 3,
    title: 'Read System Design Chapter 4',
    description: 'Study database replication and consistency models.',
    startTime: DateTime(2026, 7, 15, 14, 0),
    endTime: DateTime(2026, 7, 15, 15, 0),
    isCompleted: false,
    category: allCategories[0],
  ),
  TaskX(
    id: 4,
    title: 'Mindfulness & Meditation',
    description: '15 mins guided breathing and reflection.',
    startTime: DateTime(2026, 7, 15, 18, 0),
    endTime: DateTime(2026, 7, 15, 18, 20),
    isCompleted: false,
    category: allCategories[3],
  ),
];
