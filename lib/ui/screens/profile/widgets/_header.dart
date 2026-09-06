part of '../profile.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profile',
          style: AppText.h1b.cl(AppTheme.c.text),
        ),
        IconButton(
          onPressed: () => state.signOut(context),
          icon: Icon(
            LucideIcons.log_out,
            color: AppTheme.c.subText,
            size: 20,
          ),
          tooltip: 'Sign Out',
        ),
      ],
    );
  }
}
