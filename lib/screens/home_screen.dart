import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/tasks/tasks_bloc.dart';
import '../blocs/tasks/tasks_event.dart';
import '../blocs/tasks/tasks_state.dart';
import '../blocs/categories/categories_bloc.dart';
import '../blocs/categories/categories_state.dart';
import '../blocs/profile/profile_cubit.dart';
import '../blocs/profile/profile_state.dart';
import '../models/task_model.dart';
import '../core/models/category/category.dart';
import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final authState = context.read<AuthBloc>().state;
    final String uid = authState is Authenticated ? authState.user.uid : '';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            final displayName = profileState is ProfileLoaded
                ? profileState.profile.displayName
                : 'Shayan';

            return BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, categoriesState) {
                final categories = categoriesState is CategoriesLoaded
                    ? categoriesState.categories
                    : <Category>[];

                return BlocBuilder<TasksBloc, TasksState>(
                  builder: (context, tasksState) {
                    final tasks = tasksState is TasksLoaded
                        ? tasksState.tasks
                        : <TaskModel>[];

                    // Calculate analytics
                    int plannedMinutes = 0;
                    int completedMinutes = 0;

                    for (final task in tasks) {
                      plannedMinutes += task.durationPlanned;
                      if (task.isCompleted) {
                        completedMinutes += task.durationPlanned;
                      }
                    }

                    final remainingMinutes = math.max(
                      0,
                      plannedMinutes - completedMinutes,
                    );
                    final completionPercentage = plannedMinutes > 0
                        ? (completedMinutes / plannedMinutes)
                        : 0.0;

                    // Calculate Next Task
                    final now = DateTime.now();
                    TaskModel? nextTask;
                    for (final task in tasks) {
                      if (!task.isCompleted && task.startTime.isAfter(now)) {
                        if (nextTask == null ||
                            task.startTime.isBefore(nextTask.startTime)) {
                          nextTask = task;
                        }
                      }
                    }
                    // Fallback to first incomplete task if all scheduled ones are in the past
                    if (nextTask == null) {
                      for (final task in tasks) {
                        if (!task.isCompleted) {
                          nextTask = task;
                          break;
                        }
                      }
                    }

                    Category? nextTaskCategory;
                    if (nextTask != null) {
                      nextTaskCategory = categories.firstWhere(
                        (c) => c.id == nextTask!.categoryId,
                        orElse: () => const Category(
                          id: '',
                          name: 'General',
                          icon: 'folder',
                          color: 0xFF1A56DB,
                        ),
                      );
                    }
                    final categoryColor = nextTaskCategory != null
                        ? Color(nextTaskCategory.color)
                        : Colors.blue;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header greeting
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_getGreeting()},',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: isDark
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '$displayName 👋',
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.5,
                                        ),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.blue.shade100,
                                child: Text(
                                  displayName.isNotEmpty
                                      ? displayName[0].toUpperCase()
                                      : 'S',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Analytics Card
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Colors.black26
                                      : Colors.grey.withValues(alpha: 0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today's Completion",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    // Circular Chart
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 110,
                                            height: 110,
                                            child: CircularProgressIndicator(
                                              value: completionPercentage,
                                              strokeWidth: 12,
                                              backgroundColor: isDark
                                                  ? Colors.grey.shade800
                                                  : Colors.blue.shade50,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.blue.shade600,
                                                  ),
                                              strokeCap: StrokeCap.round,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${(completionPercentage * 100).toInt()}%',
                                                style: theme
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                              ),
                                              Text(
                                                'Complete',
                                                style: theme
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color: isDark
                                                          ? Colors.grey.shade400
                                                          : Colors
                                                                .grey
                                                                .shade500,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    // Breakdown stats
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildBreakdownItem(
                                            title: 'Planned',
                                            hours: plannedMinutes / 60,
                                            color: Colors.blue.shade600,
                                            theme: theme,
                                          ),
                                          const SizedBox(height: 12),
                                          _buildBreakdownItem(
                                            title: 'Completed',
                                            hours: completedMinutes / 60,
                                            color: Colors.green.shade600,
                                            theme: theme,
                                          ),
                                          const SizedBox(height: 12),
                                          _buildBreakdownItem(
                                            title: 'Remaining',
                                            hours: remainingMinutes / 60,
                                            color: Colors.orange.shade600,
                                            theme: theme,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Next Task Card
                          Text(
                            'Next Task',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (nextTask != null) ...[
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: categoryColor.withValues(alpha: 0.3),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: categoryColor.withValues(alpha: 0.05),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: categoryColor.withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          nextTaskCategory?.name ?? 'General',
                                          style: TextStyle(
                                            color: categoryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (nextTask.startTime.isAfter(now))
                                        Text(
                                          'In ${nextTask.startTime.difference(now).inMinutes} min',
                                          style: const TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        )
                                      else
                                        const Text(
                                          'In Progress',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    nextTask.title,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        size: 16,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade500,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${_formatTime(nextTask.startTime)} - ${_formatTime(nextTask.endTime)}',
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.grey.shade400
                                              : Colors.grey.shade600,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      final updated = nextTask!.copyWith(
                                        isCompleted: true,
                                      );
                                      context.read<TasksBloc>().add(
                                        UpdateTaskRequested(uid, updated),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: categoryColor,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      minimumSize: const Size(
                                        double.infinity,
                                        44,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Mark as Completed',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 40,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade200,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 48,
                                      color: Colors.green.shade400,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'All tasks completed for today!',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBreakdownItem({
    required String title,
    required double hours,
    required Color color,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${hours.toStringAsFixed(1)}h',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}
