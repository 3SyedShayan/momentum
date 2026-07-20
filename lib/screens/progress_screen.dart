import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/profile/profile_cubit.dart';
import '../blocs/profile/profile_state.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Your consistency over time',
              style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          final profile = profileState is ProfileLoaded
              ? profileState.profile
              : null;

          final streak = profile?.streakCount ?? 12;
          // Simulated averages based on profile or standard values
          final weeklyAvg = 76;
          final monthlyAvg = 68;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Streak',
                        value: '$streak Days',
                        icon: Icons.local_fire_department_rounded,
                        color: Colors.orange.shade600,
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'This Week',
                        value: '$weeklyAvg%',
                        icon: Icons.calendar_view_week_rounded,
                        color: Colors.blue.shade600,
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'This Month',
                        value: '$monthlyAvg%',
                        icon: Icons.calendar_month_rounded,
                        color: Colors.green.shade600,
                        theme: theme,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Heatmap Calendar Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'July 2026',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Less to More legend
                          Row(
                            children: [
                              Text(
                                'Less ',
                                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                              ),
                              _buildLegendDot(Colors.grey.shade200, isDark),
                              _buildLegendDot(Colors.blue.shade100, isDark),
                              _buildLegendDot(Colors.blue.shade300, isDark),
                              _buildLegendDot(Colors.blue.shade600, isDark),
                              _buildLegendDot(Colors.blue.shade800, isDark),
                              Text(
                                ' More',
                                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Heatmap Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: 31,
                        itemBuilder: (context, index) {
                          final day = index + 1;
                          // Seed some mock completion levels
                          final level = (day * 7 + 13) % 5;
                          Color cellColor;
                          switch (level) {
                            case 0:
                              cellColor = isDark ? Colors.grey.shade900 : Colors.grey.shade100;
                              break;
                            case 1:
                              cellColor = Colors.blue.shade100;
                              break;
                            case 2:
                              cellColor = Colors.blue.shade300;
                              break;
                            case 3:
                              cellColor = Colors.blue.shade600;
                              break;
                            default:
                              cellColor = Colors.blue.shade800;
                          }

                          return Tooltip(
                            message: 'July $day: ${level * 25}% completed',
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('July $day Completion: ${level * 25}%'),
                                    duration: const Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: cellColor,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '$day',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: level > 2
                                        ? Colors.white
                                        : (isDark ? Colors.grey.shade400 : Colors.grey.shade700),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegendDot(Color color, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color == Colors.grey.shade200 && isDark ? Colors.grey.shade900 : color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
