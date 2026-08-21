import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/screen/screen.dart';
import 'package:momentum/core/models/goal/goal.dart';
import 'package:momentum/core/models/category/category.dart';
import 'package:momentum/new_blocs/goal/cubit.dart';
import 'package:momentum/repos/goal/category_repo.dart';
import 'package:momentum/ui/widgets/core/button/button.dart';
import 'package:momentum/ui/widgets/forms/forms.dart';
import 'package:provider/provider.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

part '_state.dart';
part 'widgets/_header.dart';
part 'dummy_data/_dummy_goals.dart';
part 'dummy_data/_dummy_categories.dart';
part 'widgets/_tabselector.dart';
part 'widgets/_goalcard.dart';
part 'widgets/_allcategories.dart';
part 'widgets/_add_category.dart';
part 'widgets/_add_goal.dart';
part 'static/_form_keys.dart';
part 'static/_form_data.dart';
part 'static/_icon_data.dart';
part 'static/_color_data.dart';

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
