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

  @override
  Widget build(BuildContext context) {
    final greeting = userName.isNotEmpty
        ? '${_getGreeting()},\n$userName 👋'
        : '${_getGreeting()} 👋';

    return ScreenHeader(
      title: greeting,
      date: dateText.isEmpty ? DateTime.now() : null,
      overline: dateText.isNotEmpty ? dateText : null,
    );
  }
}
