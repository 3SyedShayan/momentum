part of '../task.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);

    return ScreenHeader(
      title: 'Daily Planner',
      date: state.selectedDate,
    );
  }
}
