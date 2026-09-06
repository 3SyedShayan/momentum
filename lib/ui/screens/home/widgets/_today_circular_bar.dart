part of '../home.dart';

class _TodayCircularBar extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? trackColor;
  final VoidCallback? onTap;

  const _TodayCircularBar({
    super.key,
    this.progress = 0.0,
    this.size = 140,
    this.strokeWidth = 11,
    this.color,
    this.trackColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    final percent = (clamped * 100).round();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(size, size),
              painter: _CircularRingPainter(
                progress: clamped,
                strokeWidth: strokeWidth,
                trackColor:
                    trackColor ?? AppTheme.c.primary.withValues(alpha: 0.08),
                color: color ?? AppTheme.c.primary,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$percent%', style: AppText.h1b.cl(AppTheme.c.text)),
                Text('Complete', style: AppText.l1.cl(AppTheme.c.subText)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
