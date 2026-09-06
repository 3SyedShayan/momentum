part of '../progress.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const ScreenHeader(
      title: 'Progress',
      subtitle: 'Your consistency over time',
    );
  }
}
