part of '../home.dart';

/// Breakdown stat item showing colored bullet, title, and hours.
class _BreakdownItem extends StatelessWidget {
  final String title;
  final double hours;
  final Color color;
  final VoidCallback? onTap;

  const _BreakdownItem({
    required this.title,
    required this.hours,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap ?? () {},
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Space.x.t12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.b2.cl(AppTheme.c.subText)),
                Text('${hours.toStringAsFixed(1)}h', style: AppText.b1b),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
