part of '../progress.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress',
          style: AppText.h1b.cl(AppTheme.c.text),
        ),
        Space.y.t04,
        Text(
          'Your consistency over time',
          style: AppText.b1.cl(AppTheme.c.subText),
        ),
      ],
    );
  }
}
