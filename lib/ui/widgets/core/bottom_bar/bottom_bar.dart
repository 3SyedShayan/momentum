import 'package:flutter/material.dart';
import 'package:momentum/configs/configs.dart';
import 'package:themed/themed.dart';
import 'package:momentum/router/routes.dart';

part '_data.dart';
part '_model.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final currentPath = context.currentPath;

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
              final isActive = tab.path == currentPath;
              final color = isActive
                  ? AppTheme.c.primary
                  : AppTheme.c.subText.addOpacity(.5);

              return Expanded(
                child: InkWell(
                  onTap: () {
                    if (isActive) return;
                    // ToDo
                    // tab.path.pushReplace(context);
                    // ''.trackUserAction(
                    //   'bottom_bar_tapped ${tab.path}',
                    // );
                  },
                  child: Column(
                    children: [
                      Space.y.t04,
                      Icon(tab.icon, color: color, size: SpaceToken.t24),
                      Space.y.t04,
                      Text(tab.label, style: AppText.b2.gm() + color),
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
