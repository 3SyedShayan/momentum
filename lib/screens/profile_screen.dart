import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/profile/profile_cubit.dart';
import '../blocs/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final authState = context.read<AuthBloc>().state;
    final String uid = authState is Authenticated ? authState.user.uid : '';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = profileState is ProfileLoaded
              ? profileState.profile
              : null;

          if (profile == null) {
            return const Center(child: Text('Failed to load profile.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Header Info
                Row(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        profile.displayName.isNotEmpty
                            ? profile.displayName[0].toUpperCase()
                            : 'S',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.displayName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            profile.email,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  '${profile.streakCount}-day streak',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Overall Stats Grid
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.06),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.6,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _buildMetricItem(
                        title: 'Total Hours Planned',
                        value: '${profile.totalHoursPlanned}h',
                        theme: theme,
                      ),
                      _buildMetricItem(
                        title: 'Total Hours Completed',
                        value: '${profile.totalHoursCompleted}h',
                        theme: theme,
                      ),
                      _buildMetricItem(
                        title: 'Weekly Completion Avg',
                        value: '74%',
                        theme: theme,
                      ),
                      _buildMetricItem(
                        title: 'Monthly Completion Avg',
                        value: '${profile.streakCount > 0 ? 68 : 0}%',
                        theme: theme,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Settings Section
                Text(
                  'Settings',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.06),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: profile.notificationsEnabled,
                        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Receive daily reminders & logs', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                        activeTrackColor: Colors.blue.shade600,
                        onChanged: (val) {
                          context.read<ProfileCubit>().updateProfileSettings(
                                uid: uid,
                                notificationsEnabled: val,
                              );
                        },
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        title: const Text('Default Reminder', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Before task starts', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                        trailing: DropdownButton<int>(
                          value: profile.defaultReminderMinutes,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down_rounded, size: 28),
                          items: const [
                            DropdownMenuItem(value: 5, child: Text('5 min')),
                            DropdownMenuItem(value: 15, child: Text('15 min')),
                            DropdownMenuItem(value: 30, child: Text('30 min')),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              context.read<ProfileCubit>().updateProfileSettings(
                                    uid: uid,
                                    defaultReminderMinutes: val,
                                  );
                            }
                          },
                        ),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        title: const Text('Theme', style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text('Appearance preference', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                        trailing: DropdownButton<String>(
                          value: profile.themeMode,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down_rounded, size: 28),
                          items: const [
                            DropdownMenuItem(value: 'light', child: Text('Light')),
                            DropdownMenuItem(value: 'dark', child: Text('Dark')),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              context.read<ProfileCubit>().updateProfileSettings(
                                    uid: uid,
                                    themeMode: val,
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // About / Actions Section
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.06),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildActionRow('Privacy Policy', Icons.lock_outline_rounded, theme),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      _buildActionRow('Terms of Service', Icons.description_outlined, theme),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      _buildActionRow('Rate Momentum', Icons.star_border_rounded, theme),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      _buildActionRow('Send Feedback', Icons.send_outlined, theme),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Footer Text
                const Center(
                  child: Text(
                    'Momentum v1.0.0 — Built with intention.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricItem({
    required String title,
    required String value,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow(String label, IconData icon, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return ListTile(
      leading: Icon(icon, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600, size: 20),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
      onTap: () {},
    );
  }
}
