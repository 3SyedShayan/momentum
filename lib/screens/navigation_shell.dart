import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/configs/configs.dart';
import '../router/routes.dart';

class NavigationShell extends StatelessWidget {
  final Widget child;

  const NavigationShell({super.key, required this.child});

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(Routes.planner)) return 1;
    if (location.startsWith(Routes.goals)) return 2;
    if (location.startsWith(Routes.progress)) return 3;
    if (location.startsWith(Routes.profile)) return 4;
    return 0; // default to Home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(Routes.home);
        break;
      case 1:
        context.go(Routes.planner);
        break;
      case 2:
        context.go(Routes.goals);
        break;
      case 3:
        context.go(Routes.progress);
        break;
      case 4:
        context.go(Routes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getSelectedIndex(context);
    final isDark = AppTheme.isDark;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.c.subBackground,
          border: Border(top: BorderSide(color: AppTheme.c.border, width: 1)),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black38
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onItemTapped(index, context),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.c.subBackground,
          selectedItemColor: AppTheme.c.primary,
          unselectedItemColor: AppTheme.c.subText,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: AppText.l1b,
          unselectedLabelStyle: AppText.l1,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded),
              activeIcon: Icon(Icons.calendar_today_rounded),
              label: 'Planner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes_rounded),
              activeIcon: Icon(Icons.track_changes_rounded),
              label: 'Goals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              activeIcon: Icon(Icons.bar_chart_rounded),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
