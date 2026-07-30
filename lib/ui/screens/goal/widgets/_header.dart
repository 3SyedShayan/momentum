part of '../goal.dart';

class _Header extends StatelessWidget implements PreferredSizeWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Goals', style: AppText.h2),
          Text(
            'Track your progress over time',
            style: AppText.b2.cl(AppTheme.c.subText),
          ),
        ],
      ),
      bottom: TabBar(
        indicatorColor: AppTheme.c.primary,
        labelColor: AppTheme.c.primary,
        unselectedLabelColor: AppTheme.c.subText,
        labelStyle: AppText.b1b,
        tabs: const [
          Tab(text: 'Weekly Goals'),
          Tab(text: 'Monthly Goals'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
