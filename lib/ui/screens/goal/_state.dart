part of 'goal.dart';

enum GoalFrequency { weekly, monthly }

class GoalItem {
  final String id;
  final String title;
  final String category;
  final int completedSessions;
  final int totalSessions;
  final Color accentColor;
  final GoalFrequency frequency;

  GoalItem({
    required this.id,
    required this.title,
    required this.category,
    required this.completedSessions,
    required this.totalSessions,
    required this.accentColor,
    required this.frequency,
  });

  int get percentage => ((completedSessions / totalSessions) * 100).round();
}

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  GoalFrequency selectedTab = GoalFrequency.weekly;

  // Mock data (replace with actual BLoC / Repository fetch)
  final List<GoalItem> _goals = [
    GoalItem(
      id: '1',
      title: 'Finish Flutter Feature',
      category: 'Work',
      completedSessions: 3,
      totalSessions: 5,
      accentColor: const Color(0xFF2563EB),
      frequency: GoalFrequency.weekly,
    ),
    GoalItem(
      id: '2',
      title: 'Exercise 5 Times',
      category: 'Health',
      completedSessions: 3,
      totalSessions: 5,
      accentColor: const Color(0xFF10B981),
      frequency: GoalFrequency.weekly,
    ),
    GoalItem(
      id: '3',
      title: 'Read 3 Chapters',
      category: 'Learning',
      completedSessions: 2,
      totalSessions: 3,
      accentColor: const Color(0xFF8B5CF6),
      frequency: GoalFrequency.weekly,
    ),
    GoalItem(
      id: '4',
      title: 'Complete Client Project',
      category: 'Work',
      completedSessions: 1,
      totalSessions: 4,
      accentColor: const Color(0xFFF59E0B),
      frequency: GoalFrequency.weekly,
    ),
  ];

  List<GoalItem> get goals => _goals;

  List<GoalItem> get currentGoals =>
      _goals.where((g) => g.frequency == selectedTab).toList();

  void setTab(GoalFrequency tab) {
    if (selectedTab == tab) return;
    selectedTab = tab;
    notifyListeners();
  }

  void addSessionToToday(GoalItem item) {
    final index = _goals.indexWhere((g) => g.id == item.id);
    if (index != -1 &&
        _goals[index].completedSessions < _goals[index].totalSessions) {
      final updated = _goals[index];
      _goals[index] = GoalItem(
        id: updated.id,
        title: updated.title,
        category: updated.category,
        completedSessions: updated.completedSessions + 1,
        totalSessions: updated.totalSessions,
        accentColor: updated.accentColor,
        frequency: updated.frequency,
      );
      notifyListeners();
    }
  }
}
