import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/models/task/task.dart';
import 'package:momentum/core/screen/screen.dart';
import 'package:momentum/core/utils/planner_engine.dart';
import 'package:momentum/repos/task/task_repo.dart';
import 'package:momentum/router/routes.dart';
import 'package:momentum/ui/widgets/core/screen_header/screen_header.dart';
import 'package:provider/provider.dart';

part '_state.dart';
part 'widgets/_header.dart';
part 'widgets/_today_circular_bar.dart';
part 'widgets/_circular_ring_painter.dart';
part 'widgets/_breakdown_item.dart';
part 'widgets/_today_stats.dart';
part 'widgets/_next_task_card.dart';
part 'widgets/_goals_summary.dart';
part 'widgets/_today_timeline_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return ChangeNotifierProvider(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SpaceToken.t20,
            vertical: SpaceToken.t16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Header(),
              Space.y.t20,
              const _TodayStats(),
              Space.y.t20,
              const _NextTaskCard(),
              Space.y.t20,
              const _GoalsSummary(),
              Space.y.t20,
              const _TodayTimelineCard(),
              Space.y.t24,
            ],
          ),
        ),
      ),
    );
  }
}
