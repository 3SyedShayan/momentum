part of '../task.dart';

class HourPickerModal extends StatelessWidget {
  const HourPickerModal({
    super.key,
    required this.initialTime,
  });

  final TimeOfDay initialTime;

  static Future<TimeOfDay?> show(
    BuildContext context, {
    required TimeOfDay initialTime,
  }) {
    return showModalBottomSheet<TimeOfDay>(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) => HourPickerModal(
        initialTime: initialTime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController(
      initialScrollOffset: (initialTime.hour * 52.0).clamp(0.0, 24 * 52.0),
    );

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
                Text('Select Hour', style: AppText.h3),
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
              itemCount: 24,
              itemExtent: 52,
              itemBuilder: (context, hour) {
                final time = TimeOfDay(hour: hour, minute: 0);
                final isSelected = hour == initialTime.hour;

                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: SpaceToken.t20,
                  ),
                  tileColor: isSelected
                      ? AppTheme.c.primary.withValues(alpha: 0.1)
                      : null,
                  title: Text(
                    time.format(context),
                    style: isSelected
                        ? AppText.b1b.cl(AppTheme.c.primary)
                        : AppText.b1,
                  ),
                  trailing: isSelected
                      ? Icon(
                          LucideIcons.check,
                          color: AppTheme.c.primary,
                          size: 18,
                        )
                      : null,
                  onTap: () => Navigator.pop(context, time),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
