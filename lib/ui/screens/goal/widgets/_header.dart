part of '../goal.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Goals', style: AppText.h1),
        Space.y.t04,
        Text('Track your progress over time', style: AppText.b1),
      ],
    );
  }
}
