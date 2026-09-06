part of '../home.dart';

class _Header extends StatelessWidget {
  final String dateText;
  final String userName;

  const _Header({
    super.key,
    this.dateText = '',
    this.userName = '',
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String _getDateText() {
    if (dateText.isNotEmpty) return dateText.toUpperCase();
    final now = DateTime.now();
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final greeting = userName.isNotEmpty
        ? '${_getGreeting()},\n$userName 👋'
        : '${_getGreeting()} 👋';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getDateText(),
          style: AppText.b2b.cl(AppTheme.c.primary),
        ),
        Space.y.t04,
        Text(
          greeting,
          style: AppText.h1b.cl(AppTheme.c.text),
        ),
      ],
    );
  }
}
