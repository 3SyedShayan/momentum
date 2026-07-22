import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'repositories/auth_repository.dart';
import 'repositories/momentum_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/categories/categories_bloc.dart';
import 'blocs/categories/categories_event.dart';
import 'blocs/tasks/tasks_bloc.dart';
import 'blocs/tasks/tasks_event.dart';
import 'blocs/goals/goals_bloc.dart';
import 'blocs/goals/goals_event.dart';
import 'blocs/profile/profile_cubit.dart';
import 'blocs/profile/profile_state.dart';
import 'core/router/app_router.dart';
import 'package:momentum/configs/configs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepository = AuthRepository();
  final momentumRepository = MomentumRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<MomentumRepository>.value(value: momentumRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: authRepository)
                  ..add(AuthSubscriptionRequested()),
          ),
          BlocProvider<CategoriesBloc>(
            create: (context) =>
                CategoriesBloc(momentumRepository: momentumRepository),
          ),
          BlocProvider<TasksBloc>(
            create: (context) =>
                TasksBloc(momentumRepository: momentumRepository),
          ),
          BlocProvider<GoalsBloc>(
            create: (context) =>
                GoalsBloc(momentumRepository: momentumRepository),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) =>
                ProfileCubit(momentumRepository: momentumRepository),
          ),
        ],
        child: const MomentumApp(),
      ),
    ),
  );
}

class MomentumApp extends StatefulWidget {
  const MomentumApp({super.key});

  @override
  State<MomentumApp> createState() => _MomentumAppState();
}

class _MomentumAppState extends State<MomentumApp> {
  late final _router = AppRouter.router(context.read<AuthBloc>());

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          final uid = state.user.uid;
          context.read<CategoriesBloc>().add(SubscribeCategories(uid));
          context.read<TasksBloc>().add(SubscribeTasks(uid));
          context.read<GoalsBloc>().add(SubscribeGoals(uid));
          context.read<ProfileCubit>().fetchProfile(uid);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          ThemeMode themeMode = ThemeMode.light;
          if (profileState is ProfileLoaded) {
            themeMode = profileState.profile.themeMode == 'dark'
                ? ThemeMode.dark
                : ThemeMode.light;
          }

          return MaterialApp.router(
            title: 'Momentum',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              App.init(context);
              return child ?? const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
