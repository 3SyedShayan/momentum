import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:momentum/ui/screens/task/task.dart';
import 'routes.dart';

import '../ui/screens/goal/goal.dart';
import '../ui/screens/home/home.dart';
import '../ui/screens/progress/progress.dart';
import '../ui/screens/profile/profile.dart';
import '../ui/widgets/core/bottom_bar/bottom_bar.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter router() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: Routes.home,
      routes: [
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: const BottomBar(),
            );
          },
          routes: [
            GoRoute(
              path: Routes.home,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeScreen()),
            ),
            GoRoute(
              path: Routes.planner,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: TaskScreen()),
            ),
            GoRoute(
              path: Routes.goals,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: GoalScreen()),
            ),
            GoRoute(
              path: Routes.progress,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProgressScreen()),
            ),
            GoRoute(
              path: Routes.profile,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileScreen()),
            ),
          ],
        ),
      ],
    );
  }
}
