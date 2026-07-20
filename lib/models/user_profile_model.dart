class UserProfileModel {
  final String uid;
  final String displayName;
  final String email;
  final int streakCount;
  final int totalHoursPlanned;
  final int totalHoursCompleted;
  final bool notificationsEnabled;
  final int defaultReminderMinutes;
  final String themeMode; // 'light' or 'dark'

  UserProfileModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.streakCount,
    required this.totalHoursPlanned,
    required this.totalHoursCompleted,
    required this.notificationsEnabled,
    required this.defaultReminderMinutes,
    required this.themeMode,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserProfileModel(
      uid: uid,
      displayName: map['displayName'] ?? 'Shayan',
      email: map['email'] ?? 'shayan@momentum.app',
      streakCount: map['streakCount'] ?? 12,
      totalHoursPlanned: map['totalHoursPlanned'] ?? 248,
      totalHoursCompleted: map['totalHoursCompleted'] ?? 189,
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      defaultReminderMinutes: map['defaultReminderMinutes'] ?? 15,
      themeMode: map['themeMode'] ?? 'light',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'streakCount': streakCount,
      'totalHoursPlanned': totalHoursPlanned,
      'totalHoursCompleted': totalHoursCompleted,
      'notificationsEnabled': notificationsEnabled,
      'defaultReminderMinutes': defaultReminderMinutes,
      'themeMode': themeMode,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? displayName,
    String? email,
    int? streakCount,
    int? totalHoursPlanned,
    int? totalHoursCompleted,
    bool? notificationsEnabled,
    int? defaultReminderMinutes,
    String? themeMode,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      streakCount: streakCount ?? this.streakCount,
      totalHoursPlanned: totalHoursPlanned ?? this.totalHoursPlanned,
      totalHoursCompleted: totalHoursCompleted ?? this.totalHoursCompleted,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      defaultReminderMinutes: defaultReminderMinutes ?? this.defaultReminderMinutes,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
