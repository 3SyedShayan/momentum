part of '../task.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Daily Planner', style: AppText.h1),
        Space.y.t04,
        Text(
          'Plan and organize your day',
          style: AppText.b1.cl(AppTheme.c.subText),
        ),
      ],
    );
  }
}
