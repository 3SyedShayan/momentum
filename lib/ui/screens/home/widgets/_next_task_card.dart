part of '../home.dart';

/// Next task card with blue gradient, Zap icon, and countdown pill.
class _NextTaskCard extends StatelessWidget {
  final String title;
  final String time;
  final String countdown;
  final VoidCallback? onTap;

  const _NextTaskCard({
    super.key,
    this.title = '',
    this.time = '',
    this.countdown = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayTitle = title.isNotEmpty ? title : 'No upcoming task';
    final displayTime = time.isNotEmpty ? time : 'No tasks scheduled';
    final displayCountdown = countdown.isNotEmpty ? countdown : 'Free';

    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: Space.a.t20,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff2563EB).withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NEXT TASK',
                        style: AppText.l1b.cl(const Color(0xffBFDBFE)),
                      ),
                      Space.y.t04,
                      Text(
                        displayTitle,
                        style: AppText.h3b.cl(Colors.white),
                      ),
                      Space.y.t04,
                      Text(
                        displayTime,
                        style: AppText.b2.cl(const Color(0xffBFDBFE)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: Space.a.t08,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    LucideIcons.zap,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Space.y.t16,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SpaceToken.t12,
                vertical: SpaceToken.t08,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    LucideIcons.clock,
                    size: 13,
                    color: Color(0xffBFDBFE),
                  ),
                  Space.x.t08,
                  Text(
                    displayCountdown,
                    style: AppText.l1b.cl(Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
