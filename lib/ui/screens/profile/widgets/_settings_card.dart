part of '../profile.dart';

class _SettingsCard extends StatelessWidget {
  const _SettingsCard();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SETTINGS',
          style: AppText.b2b.cl(AppTheme.c.subText).copyWith(
            letterSpacing: 1.0,
            fontSize: 11,
          ),
        ),
        Space.y.t08,
        Container(
          decoration: BoxDecoration(
            color: AppTheme.c.specBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.c.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Notifications
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SpaceToken.t20,
                  vertical: SpaceToken.t12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          LucideIcons.bell,
                          size: 16,
                          color: AppTheme.c.subText,
                        ),
                        Space.x.t12,
                        Text(
                          'Notifications',
                          style: AppText.b1.cl(AppTheme.c.text),
                        ),
                      ],
                    ),
                    Switch.adaptive(
                      value: state.notificationsEnabled,
                      activeTrackColor: AppTheme.c.primary,
                      onChanged: (val) => state.toggleNotifications(val),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppTheme.c.border.withValues(alpha: 0.5),
              ),

              // Default Reminder
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SpaceToken.t20,
                  vertical: SpaceToken.t12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          LucideIcons.clock,
                          size: 16,
                          color: AppTheme.c.subText,
                        ),
                        Space.x.t12,
                        Text(
                          'Default Reminder',
                          style: AppText.b1.cl(AppTheme.c.text),
                        ),
                      ],
                    ),
                    DropdownButton<int>(
                      value: state.defaultReminderMinutes,
                      underline: const SizedBox.shrink(),
                      icon: Icon(
                        LucideIcons.chevron_down,
                        size: 16,
                        color: AppTheme.c.primary,
                      ),
                      items: ProfileData.reminderOptions.map((min) {
                        return DropdownMenuItem<int>(
                          value: min,
                          child: Text(
                            '$min min',
                            style: AppText.b1b.cl(AppTheme.c.primary),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          state.updateReminderMinutes(val);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppTheme.c.border.withValues(alpha: 0.5),
              ),

              // Theme
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SpaceToken.t20,
                  vertical: SpaceToken.t16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          LucideIcons.sun,
                          size: 16,
                          color: AppTheme.c.subText,
                        ),
                        Space.x.t12,
                        Text(
                          'Theme',
                          style: AppText.b1.cl(AppTheme.c.text),
                        ),
                      ],
                    ),
                    Text(
                      state.themeMode,
                      style: AppText.b1b.cl(AppTheme.c.subText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
