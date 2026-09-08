part of 'profile.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final BuildContext _context;

  _ScreenState(this._context);

  bool _notificationsEnabled = DummyProfileData.notificationsEnabled;
  int _defaultReminderMinutes = DummyProfileData.defaultReminderMinutes;

  String get displayName => DummyProfileData.displayName;

  String get email => DummyProfileData.email;

  int get streakCount => DummyProfileData.streakCount;

  int get totalHoursPlanned => DummyProfileData.totalHoursPlanned;

  int get totalHoursCompleted => DummyProfileData.totalHoursCompleted;

  String get weeklyCompletionAvg => DummyProfileData.weeklyCompletionAvg;

  String get monthlyCompletionAvg =>
      streakCount > 0 ? DummyProfileData.monthlyCompletionAvg : '0%';

  bool get notificationsEnabled => _notificationsEnabled;

  int get defaultReminderMinutes => _defaultReminderMinutes;

  String get themeMode => 'Light';

  void toggleNotifications(bool val) {
    _notificationsEnabled = val;
    notifyListeners();
  }

  void updateReminderMinutes(int minutes) {
    _defaultReminderMinutes = minutes;
    notifyListeners();
  }

  void signOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
