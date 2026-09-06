part of 'profile.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final BuildContext _context;

  _ScreenState(this._context);

  ProfileLoaded? get _profileLoaded {
    try {
      final state = _context.watch<ProfileCubit>().state;
      if (state is ProfileLoaded) return state;
    } catch (_) {}
    return null;
  }

  String get _uid {
    try {
      final state = _context.read<AuthBloc>().state;
      if (state is Authenticated) return state.user.uid;
    } catch (_) {}
    return '';
  }

  String get displayName =>
      _profileLoaded?.profile.displayName ?? DummyProfileData.displayName;

  String get email => _profileLoaded?.profile.email ?? DummyProfileData.email;

  int get streakCount =>
      _profileLoaded?.profile.streakCount ?? DummyProfileData.streakCount;

  int get totalHoursPlanned =>
      _profileLoaded?.profile.totalHoursPlanned ??
      DummyProfileData.totalHoursPlanned;

  int get totalHoursCompleted =>
      _profileLoaded?.profile.totalHoursCompleted ??
      DummyProfileData.totalHoursCompleted;

  String get weeklyCompletionAvg => DummyProfileData.weeklyCompletionAvg;

  String get monthlyCompletionAvg =>
      streakCount > 0 ? DummyProfileData.monthlyCompletionAvg : '0%';

  bool get notificationsEnabled =>
      _profileLoaded?.profile.notificationsEnabled ??
      DummyProfileData.notificationsEnabled;

  int get defaultReminderMinutes =>
      _profileLoaded?.profile.defaultReminderMinutes ??
      DummyProfileData.defaultReminderMinutes;

  String get themeMode {
    final mode = _profileLoaded?.profile.themeMode;
    if (mode == 'dark') return 'Dark';
    return 'Light';
  }

  void toggleNotifications(bool val) {
    if (_uid.isNotEmpty) {
      _context.read<ProfileCubit>().updateProfileSettings(
        uid: _uid,
        notificationsEnabled: val,
      );
    }
    notifyListeners();
  }

  void updateReminderMinutes(int minutes) {
    if (_uid.isNotEmpty) {
      _context.read<ProfileCubit>().updateProfileSettings(
        uid: _uid,
        defaultReminderMinutes: minutes,
      );
    }
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
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AuthBloc>().add(SignOutRequested());
            },
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
