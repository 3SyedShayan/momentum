part of 'progress.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final TextEditingController reflectionController = TextEditingController();

  DayProgress? selectedDay;
  String? selectedMood;

  int streakDays = 12;
  int weeklyCompletionPercent = 76;
  int monthlyCompletionPercent = 68;

  late final DateTime currentMonthDate;
  late final List<DayProgress> monthDays;

  _ScreenState() {
    currentMonthDate = DateTime(2025, 7, 1);
    monthDays = generateDummyProgress();
  }

  String get currentMonthName => DateFormat('MMMM').format(currentMonthDate);
  String get currentMonthYear => DateFormat('MMMM yyyy').format(currentMonthDate);

  /// Sunday-based day of week offset for the 1st day of month (Sunday=0, Monday=1, ..., Saturday=6)
  int get firstDayOffset {
    final firstDay = DateTime(currentMonthDate.year, currentMonthDate.month, 1);
    return firstDay.weekday % 7;
  }

  void selectDay(DayProgress? day) {
    if (selectedDay?.date == day?.date) {
      selectedDay = null;
    } else {
      selectedDay = day;
    }
    notifyListeners();
  }

  void selectMood(String mood) {
    if (selectedMood == mood) {
      selectedMood = null;
    } else {
      selectedMood = mood;
    }
    notifyListeners();
  }

  void saveReflection(BuildContext context) {
    final text = reflectionController.text.trim();
    if (text.isEmpty && selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your reflection or select a mood.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reflection saved successfully!'),
        backgroundColor: ProgressColors.thisMonthEmerald,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    reflectionController.dispose();
    super.dispose();
  }
}
