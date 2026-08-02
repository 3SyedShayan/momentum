import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/blocs/goals/goals_bloc.dart';
import 'package:momentum/blocs/goals/goals_state.dart';
import 'package:momentum/core/screen/screen.dart';
import 'package:momentum/core/models/goal/goal.dart';
import 'package:momentum/core/models/category/category.dart';
import 'package:provider/provider.dart';

part '_state.dart';
part 'widgets/_header.dart';
part 'dummy_data/_dummy_goals.dart';
part 'dummy_data/_dummy_categories.dart';
part 'widgets/_goalbody.dart';
part 'widgets/_tabselector.dart';
part 'widgets/_goalcard.dart';
part 'widgets/_allcategories.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
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
    final state = _ScreenState.s(context, true);

    return Screen(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(SpaceToken.t16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Header(),
              Space.y.t16,
              const AllCategories(),
              Space.y.t16,
              const _GoalTabSelector(),
              Space.y.t20,

              // Goals List
              ...state.currentGoals.map(
                (goal) => Padding(
                  padding: Space.b.t12,
                  child: _GoalCard(goal: goal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
