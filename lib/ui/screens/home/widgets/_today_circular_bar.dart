part of '../home.dart';

/// Circular progress indicator widget showing completion percentage.
class _TodayCircularBar extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const _TodayCircularBar({
    super.key,
    this.progress = 0.75,
    this.size = 110,
    this.strokeWidth = 10,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final activeColor = color ?? AppTheme.c.primary;
    final trackColor = backgroundColor ?? AppTheme.c.border;
    final percent = (clampedProgress * 100).round();

    return GestureDetector(
      onTap: onTap ?? () {},
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: clampedProgress,
                strokeWidth: strokeWidth,
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation<Color>(activeColor),
                backgroundColor: trackColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$percent%', style: AppText.h2b),
                Text('Complete', style: AppText.l1.cl(AppTheme.c.subText)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
