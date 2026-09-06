part of '../task.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);
    final dateStr = DateFormat('EEEE, MMMM d').format(state.selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateStr.toUpperCase(),
          style: AppText.b2b.cl(AppTheme.c.primary).copyWith(
            letterSpacing: 1.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Space.y.t04,
        Text(
          'Daily Planner',
          style: AppText.h1b.cl(AppTheme.c.text),
        ),
      ],
    );
  }
}
