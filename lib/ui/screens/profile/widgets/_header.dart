part of '../profile.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, false);

    return ScreenHeader(
      title: 'Profile',
      trailing: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        visualDensity: VisualDensity.compact,
        onPressed: () => state.signOut(context),
        icon: Icon(
          LucideIcons.log_out,
          color: AppTheme.c.subText,
          size: 20,
        ),
        tooltip: 'Sign Out',
      ),
    );
  }
}
