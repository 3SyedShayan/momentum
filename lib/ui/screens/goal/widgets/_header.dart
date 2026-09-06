part of '../goal.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const ScreenHeader(
      title: 'Goals',
      subtitle: 'Track your progress over time',
    );
  }
}
