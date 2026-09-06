part of '../progress.dart';

class _DayDetailCard extends StatelessWidget {
  final DayProgress day;

  const _DayDetailCard({required this.day});

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, false);

    return Container(
      margin: EdgeInsets.only(top: SpaceToken.t16),
      padding: EdgeInsets.only(top: SpaceToken.t16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.c.border),
        ),
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
                      '${state.currentMonthName} ${day.date}',
                      style: AppText.b1b.cl(AppTheme.c.text),
                    ),
                    Space.y.t04,
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.circle_check,
                              size: 13,
                              color: ProgressColors.thisMonthEmerald,
                            ),
                            Space.x.t04,
                            Text(
                              '${day.completed} / ${day.total} tasks',
                              style: AppText.b2.cl(AppTheme.c.subText),
                            ),
                          ],
                        ),
                        Space.x.t12,
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.clock,
                              size: 13,
                              color: ProgressColors.thisWeekBlue,
                            ),
                            Space.x.t04,
                            Text(
                              '${day.focusHours} focus hours',
                              style: AppText.b2.cl(AppTheme.c.subText),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => state.selectDay(null),
                icon: Icon(
                  LucideIcons.x,
                  size: 16,
                  color: AppTheme.c.subText,
                ),
              ),
            ],
          ),
          Space.y.t08,
          Text(
            day.summary,
            style: AppText.b2.cl(AppTheme.c.subText).copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }
}
