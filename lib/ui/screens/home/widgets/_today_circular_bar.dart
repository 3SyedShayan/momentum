part of '../home.dart';

/// Circular progress ring with gradient stroke and centered percentage.
class _TodayCircularBar extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final VoidCallback? onTap;

  const _TodayCircularBar({
    super.key,
    this.progress = 0.0,
    this.size = 140,
    this.strokeWidth = 11,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    final percent = (clamped * 100).round();

    return GestureDetector(
      onTap: onTap ?? () {},
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(size, size),
              painter: _GradientCircularRingPainter(
                progress: clamped,
                strokeWidth: strokeWidth,
                trackColor: AppTheme.c.primary.withValues(alpha: 0.08),
                startColor: const Color(0xff60A5FA),
                endColor: const Color(0xff2563EB),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$percent%',
                  style: AppText.h1b.cl(AppTheme.c.text),
                ),
                Text(
                  'Complete',
                  style: AppText.l1.cl(AppTheme.c.subText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientCircularRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color trackColor;
  final Color startColor;
  final Color endColor;

  _GradientCircularRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Progress Arc with Gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepGradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 3 * pi / 2,
      colors: [startColor, endColor],
    );

    final progressPaint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientCircularRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.startColor != startColor ||
        oldDelegate.endColor != endColor;
  }
}
