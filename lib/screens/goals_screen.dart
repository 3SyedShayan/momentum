import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/goals/goals_bloc.dart';
import '../blocs/goals/goals_event.dart';
import '../blocs/goals/goals_state.dart';
import '../blocs/categories/categories_bloc.dart';
import '../blocs/categories/categories_state.dart';
import '../core/models/goal/goal.dart';
import '../core/models/category/category.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final authState = context.read<AuthBloc>().state;
    final String uid = authState is Authenticated ? authState.user.uid : '';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goals',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Track your progress over time',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: isDark ? Colors.white : Colors.black,
          bottom: TabBar(
            indicatorColor: Colors.blue.shade600,
            labelColor: Colors.blue.shade600,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: const [
              Tab(text: 'Weekly Goals'),
              Tab(text: 'Monthly Goals'),
            ],
          ),
        ),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, categoriesState) {
            final categories = categoriesState is CategoriesLoaded
                ? categoriesState.categories
                : <Category>[];

            return BlocBuilder<GoalsBloc, GoalsState>(
              builder: (context, goalsState) {
                final goals = goalsState is GoalsLoaded
                    ? goalsState.goals
                    : <GoalX>[];

                final weeklyGoals =
                    goals.where((g) => g.type == GoalType.weekly).toList();
                final monthlyGoals =
                    goals.where((g) => g.type == GoalType.monthly).toList();

                return TabBarView(
                  children: [
                    _buildGoalList(
                      context,
                      uid: uid,
                      goals: weeklyGoals,
                      categories: categories,
                      theme: theme,
                    ),
                    _buildGoalList(
                      context,
                      uid: uid,
                      goals: monthlyGoals,
                      categories: categories,
                      theme: theme,
                    ),
                  ],
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddGoalBottomSheet(context, uid),
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.add, size: 28),
        ),
      ),
    );
  }

  Widget _buildGoalList(
    BuildContext context, {
    required String uid,
    required List<GoalX> goals,
    required List<Category> categories,
    required ThemeData theme,
  }) {
    if (goals.isEmpty) {
      return const Center(
        child: Text(
          'No goals set for this category. Tap + to add.',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      );
    }

    final isDark = theme.brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        final accentColor = Color(goal.color);
        final percentInt = (goal.percentageCompleted.clamp(0.0, 1.0) * 100).toInt();

        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.06),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      goal.category.name,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '$percentInt%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                goal.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: goal.percentageCompleted.clamp(0.0, 1.0),
                  backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    goal.isCompleted ? 'Completed' : 'In Progress',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.read<GoalsBloc>().add(AddGoalToTodayRequested(uid, goal));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added "${goal.title}" to today\'s planner!'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.blue.shade600,
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, size: 14),
                    label: const Text(
                      'Add Progress',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor.withValues(alpha: 0.5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddGoalBottomSheet(BuildContext context, String uid) {
    final titleController = TextEditingController();
    Category? selectedCategory;
    GoalType selectedType = GoalType.weekly;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            final categoriesState = context.watch<CategoriesBloc>().state;
            final categories = categoriesState is CategoriesLoaded
                ? categoriesState.categories
                : <Category>[];

            if (selectedCategory == null && categories.isNotEmpty) {
              selectedCategory = categories.first;
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create New Goal',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Goal Title (e.g. Read 3 chapters)',
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.08),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Category>(
                    initialValue: selectedCategory,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.08),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: categories.map((cat) {
                      return DropdownMenuItem<Category>(
                        value: cat,
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Color(cat.color),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(cat.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCategory = val;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Goal Type', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SegmentedButton<GoalType>(
                    segments: const [
                      ButtonSegment(value: GoalType.weekly, label: Text('Weekly')),
                      ButtonSegment(value: GoalType.monthly, label: Text('Monthly')),
                    ],
                    selected: {selectedType},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        selectedType = newSelection.first;
                      });
                    },
                    showSelectedIcon: false,
                    style: SegmentedButton.styleFrom(
                      selectedBackgroundColor: Colors.blue.shade600,
                      selectedForegroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final title = titleController.text.trim();
                      if (title.isNotEmpty && selectedCategory != null) {
                        final goal = GoalX(
                          id: DateTime.now().millisecondsSinceEpoch,
                          title: title,
                          category: selectedCategory!,
                          percentageCompleted: 0.0,
                          color: selectedCategory!.color,
                          type: selectedType,
                          createdAt: DateTime.now(),
                        );

                        context.read<GoalsBloc>().add(AddGoalRequested(uid, goal));
                        Navigator.pop(sheetContext);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Create Goal', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
