import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/configs/configs.dart';
import 'package:momentum/router/routes.dart';

part '_data.dart';
part '_model.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final location = GoRouterState.of(context).matchedLocation;

    return Material(
      color: AppTheme.c.background,
      elevation: 0,
      child: GestureDetector(
        // ToDo // onLongPress: () => AppAlice.ins.showInspector(),
        child: Container(
          padding: Space.z.sb().t(12),
          decoration: BoxDecoration(
            color: AppProps.bgColor(),
            border: Border(top: BorderSide(color: AppTheme.c.border)),
          ),
          child: Row(
            children: _tabs.map((tab) {
              final isActive = tab.path == Routes.home
                  ? location == Routes.home
                  : location.startsWith(tab.path);
              final color = isActive ? AppTheme.c.primary : AppTheme.c.subText;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    if (isActive) return;
                    context.go(tab.path);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Space.y.t04,
                      Icon(tab.icon, color: color, size: SpaceToken.t24),
                      Space.y.t04,
                      Text(
                        tab.label,
                        style: (isActive ? AppText.b2.w(6) : AppText.b2.w(5))
                            .copyWith(color: color, letterSpacing: -0.2),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
