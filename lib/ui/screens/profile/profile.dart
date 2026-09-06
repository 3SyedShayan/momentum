import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:momentum/blocs/auth/auth_bloc.dart';
import 'package:momentum/blocs/auth/auth_event.dart';
import 'package:momentum/blocs/auth/auth_state.dart';
import 'package:momentum/blocs/profile/profile_cubit.dart';
import 'package:momentum/blocs/profile/profile_state.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/core/screen/screen.dart';
import 'package:provider/provider.dart';

part '_state.dart';
part 'dummy_data/_dummy_profile.dart';
part 'static/_profile_data.dart';
part 'widgets/_about_card.dart';
part 'widgets/_header.dart';
part 'widgets/_settings_card.dart';
part 'widgets/_stats_card.dart';
part 'widgets/_user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (ctx) => _ScreenState(ctx),
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
              const _UserCard(),
              Space.y.t20,
              const _StatsCard(),
              Space.y.t20,
              const _SettingsCard(),
              Space.y.t20,
              const _AboutCard(),
              Space.y.t60,
            ],
          ),
        ),
      ),
    );
  }
}
