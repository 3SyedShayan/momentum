part of 'bottom_bar.dart';

List<_BottomBar> _tabs = [
  _BottomBar(path: Routes.home, icon: Icons.dashboard_outlined, label: 'Home'),
  _BottomBar(
    path: Routes.planner,
    icon: Icons.calendar_today_outlined,
    label: 'Planner',
  ),
  _BottomBar(
    path: Routes.goals,
    icon: Icons.track_changes_rounded,
    label: 'Goals',
  ),
  _BottomBar(
    path: Routes.progress,
    icon: Icons.bar_chart_rounded,
    label: 'Progress',
  ),
  _BottomBar(
    path: Routes.profile,
    icon: Icons.person_outline_rounded,
    label: 'Profile',
  ),
];
