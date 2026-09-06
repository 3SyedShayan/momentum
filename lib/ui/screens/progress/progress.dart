import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:intl/intl.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/screen/screen.dart';
import 'package:provider/provider.dart';

part '_state.dart';
part 'dummy_data/_dummy_progress.dart';
part 'static/_progress_colors.dart';
part 'widgets/_daily_reflection_card.dart';
part 'widgets/_day_detail_card.dart';
part 'widgets/_header.dart';
part 'widgets/_heatmap_card.dart';
part 'widgets/_stats_row.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

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
              const _StatsRow(),
              Space.y.t20,
              const _HeatmapCard(),
              Space.y.t20,
              const _DailyReflectionCard(),
              Space.y.t60,
            ],
          ),
        ),
      ),
    );
  }
}
