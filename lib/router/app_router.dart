import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/ui/screens/task/task.dart';
import 'routes.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../ui/screens/goal/goal.dart';
import '../screens/progress_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/navigation_shell.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter router(AuthBloc authBloc) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: Routes.login,
      refreshListenable: GoRouterRefreshBloc(authBloc),
      redirect: (context, state) {
        final authState = authBloc.state;
        final isLoggingIn = state.matchedLocation == Routes.login;

        if (authState is Unauthenticated || authState is AuthInitial) {
          return Routes.login;
        }

        if (authState is Authenticated) {
          if (isLoggingIn) {
            return Routes.home;
          }
        }

        return null;
      },
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return NavigationShell(child: child);
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

// A helper class to convert a Bloc into a Listenable for GoRouter refreshListenable
class GoRouterRefreshBloc extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshBloc(BlocBase bloc) {
    notifyListeners();
    _subscription = bloc.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
