import 'dart:core';

import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/models/category/category.dart';
import 'package:momentum/core/models/task/task.dart';
import 'package:momentum/core/screen/screen.dart';
import 'package:momentum/new_blocs/category/cubit.dart';
import 'package:momentum/new_blocs/task/cubit.dart';
import 'package:momentum/repos/category/category_repo.dart';
import 'package:momentum/repos/task/task_repo.dart';
import 'package:momentum/ui/widgets/core/button/button.dart';
import 'package:momentum/ui/widgets/forms/forms.dart';
import 'package:provider/provider.dart';

part '_state.dart';
part 'dummy_data/_dummy_categories.dart';
part 'dummy_data/_dummy_tasks.dart';
part 'static/_color_data.dart';
part 'static/_form_data.dart';
part 'static/_form_keys.dart';
part 'static/_icon_data.dart';
part 'widgets/_add_category.dart';
part 'widgets/_add_task.dart';
part 'widgets/_allcategories.dart';
part 'widgets/_alltasks.dart';
part 'widgets/_floating_button.dart';
part 'widgets/_header.dart';
part 'widgets/_timeline_item.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

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

    return Screen(
      floatingActionButton: const _FloatingButton(),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(SpaceToken.t16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Header(),
              Space.y.t16,
              const _AllCategories(),
              Space.y.t20,
              const _AllTasks(),
            ],
          ),
        ),
      ),
    );
  }
}
