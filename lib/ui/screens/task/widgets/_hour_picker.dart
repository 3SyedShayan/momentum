part of '../task.dart';

class HourPickerModal extends StatelessWidget {
  const HourPickerModal({
    super.key,
    required this.initialHour,
    this.disabledHours = const {},
    this.pastHours = const {},
    this.occupiedHours = const {},
    this.minHour = 0,
    this.maxHour = 23,
    this.title = 'Select Hour',
  });

  final int initialHour;
  final Set<int> disabledHours;
  final Set<int> pastHours;
  final Set<int> occupiedHours;
  final int minHour;
  final int maxHour;
  final String title;

  static Future<int?> show(
    BuildContext context, {
    required int initialHour,
    Set<int> disabledHours = const {},
    Set<int> pastHours = const {},
    Set<int> occupiedHours = const {},
    int minHour = 0,
    int maxHour = 23,
    String title = 'Select Hour',
  }) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) => HourPickerModal(
        initialHour: initialHour,
        disabledHours: disabledHours,
        pastHours: pastHours,
        occupiedHours: occupiedHours,
        minHour: minHour,
        maxHour: maxHour,
        title: title,
      ),
    );
  }

  String _formatHour(int hour) {
    if (hour == 0) return '12:00 AM';
    if (hour == 24) return '12:00 AM (Next Day)';
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : hour;
    return '$displayHour:00 $period';
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController(
      initialScrollOffset:
          ((initialHour - minHour).clamp(0, maxHour - minHour) * 52.0),
    );

    final totalCount = maxHour - minHour + 1;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      padding: EdgeInsets.only(
        top: SpaceToken.t16,
        bottom: MediaQuery.of(context).viewInsets.bottom + SpaceToken.t16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SpaceToken.t20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppText.h3),
                IconButton(
                  icon: const Icon(LucideIcons.x, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: totalCount,
              itemExtent: 52,
              itemBuilder: (context, index) {
                final hour = minHour + index;
                final isSelected = hour == initialHour;
                final isPast = pastHours.contains(hour);
                final isOccupied =
                    occupiedHours.contains(hour) || disabledHours.contains(hour);
                final isDisabled = isPast || isOccupied;

                return ListTile(
                  dense: true,
                  enabled: !isDisabled,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: SpaceToken.t20,
                  ),
                  tileColor: isSelected
                      ? AppTheme.c.primary.withValues(alpha: 0.1)
                      : null,
                  title: Text(
                    _formatHour(hour),
                    style: isDisabled
                        ? AppText.b1.cl(
                            AppTheme.c.subText.withValues(
                              alpha: isPast ? 0.35 : 0.4,
                            ),
                          )
                        : (isSelected
                            ? AppText.b1b.cl(AppTheme.c.primary)
                            : AppText.b1),
                  ),
                  trailing: isPast
                      ? Text(
                          'Passed',
                          style: AppText.l1.cl(
                            AppTheme.c.subText.withValues(alpha: 0.5),
                          ),
                        )
                      : isOccupied
                          ? Text(
                              'Occupied',
                              style: AppText.l1.cl(
                                Colors.red.withValues(alpha: 0.7),
                              ),
                            )
                          : (isSelected
                              ? Icon(
                                  LucideIcons.check,
                                  color: AppTheme.c.primary,
                                  size: 18,
                                )
                              : null),
                  onTap: isDisabled ? null : () => Navigator.pop(context, hour),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
