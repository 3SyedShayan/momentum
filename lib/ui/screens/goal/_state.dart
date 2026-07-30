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

  int get percentage =>
      totalSessions > 0 ? ((completedSessions / totalSessions) * 100).round() : 0;
}

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  List<GoalItem> get goals => allGoals;
}
