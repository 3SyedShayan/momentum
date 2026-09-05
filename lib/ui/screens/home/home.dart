import 'package:flutter/material.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/screen/screen.dart';
import 'package:provider/provider.dart';

part '_state.dart';
part 'widgets/_today_stats.dart';
part 'widgets/_breakdown_item.dart';
part 'widgets/_today_circular_bar.dart';

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
          padding: EdgeInsets.all(SpaceToken.t16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [_TodayStats()],
          ),
        ),
      ),
    );
  }
}
