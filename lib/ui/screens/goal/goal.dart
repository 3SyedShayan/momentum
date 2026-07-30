import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/blocs/goals/goals_bloc.dart';
import 'package:momentum/blocs/goals/goals_state.dart';
import 'package:momentum/core/screen/screen.dart';
import 'package:momentum/models/goal_model.dart';
import 'package:provider/provider.dart';

part '_state.dart';
part 'widgets/_header.dart';
part 'widgets/_dummydata.dart';
part 'widgets/_goalbody.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Screen(
      child: SafeArea(
        child: Column(
          children: [
            _Header(),
            DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: AppTheme.c.background,
                appBar: const _Header(),
                body: const _GoalBody(),
              ),
            ),
            _GoalBody(),
          ],
        ),
      ),
    );
  }
}
