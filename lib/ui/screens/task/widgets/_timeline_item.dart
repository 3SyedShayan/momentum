part of '../task.dart';

class _TimelineItem extends StatelessWidget {
  final TaskX task;
  final bool isLast;

  const _TimelineItem({required this.task, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);
    final catColor = Color(task.category.color);
    final now = DateTime.now();
    final isActive =
        !task.isCompleted &&
        now.isAfter(task.startTime) &&
        now.isBefore(task.endTime);

    final totalMinutes = task.endTime.difference(task.startTime).inMinutes;
    final elapsedMinutes = now.difference(task.startTime).inMinutes;
    final progress = totalMinutes > 0
        ? (elapsedMinutes / totalMinutes).clamp(0.0, 1.0)
        : 0.0;

    final catIcon = getCategoryIcon(task.category.icon);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Time Column
          SizedBox(
            width: 52,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    state.formatTimeShort(task.startTime),
                    style: AppText.b2b.cl(
                      task.isCompleted
                          ? const Color(0xFF9CA3AF)
                          : (isActive ? catColor : AppTheme.c.subText),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: AppTheme.c.border.withValues(alpha: 0.8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
                if (isLast)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      state.formatTimeShort(task.endTime),
                      style: AppText.b2.cl(
                        AppTheme.c.subText.withValues(alpha: 0.5),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          Space.x.t08,
          // Right Task Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: task.isCompleted
                      ? const Color(0xFFFAFAFA)
                      : (isActive
                            ? catColor.withValues(alpha: 0.08)
                            : Colors.white),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isActive
                        ? catColor
                        : AppTheme.c.border.withValues(alpha: 0.8),
                    width: 1.5,
                  ),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: catColor.withValues(alpha: 0.18),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : (!task.isCompleted
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : []),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    // Active left indicator bar
                    if (isActive)
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: catColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Status Icon (tap to toggle)
                              GestureDetector(
                                onTap: () => state.toggleTaskCompletion(task),
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: task.isCompleted
                                      ? const Icon(
                                          LucideIcons.circle_check,
                                          size: 18,
                                          color: Color(0xFF9CA3AF),
                                        )
                                      : (isActive
                                            ? Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: catColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Container(
                                                    width: 5,
                                                    height: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                  ),
                                                ),
                                              )
                                            : const Icon(
                                                LucideIcons.circle,
                                                size: 18,
                                                color: Color(0xFFD1D5DB),
                                              )),
                                ),
                              ),
                              Space.x.t08,
                              // Title and Time
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title,
                                      style: AppText.b1b
                                          .cl(
                                            task.isCompleted
                                                ? const Color(0xFF9CA3AF)
                                                : AppTheme.c.text,
                                          )
                                          .copyWith(
                                            decoration: task.isCompleted
                                                ? TextDecoration.lineThrough
                                                : null,
                                            height: 1.2,
                                          ),
                                    ),
                                    Space.y.t04,
                                    Text(
                                      '${state.formatTimeShort(task.startTime)} – ${state.formatTimeShort(task.endTime)}',
                                      style: AppText.b2.cl(
                                        const Color(0xFF9CA3AF),
                                      ),
                                    ),
                                    if (task.description != null &&
                                        task.description!.isNotEmpty &&
                                        !task.isCompleted) ...[
                                      Space.y.t04,
                                      Text(
                                        task.description!,
                                        style: AppText.b2.cl(
                                          AppTheme.c.subText,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              // Trailing Category Icon Badge
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: task.isCompleted
                                      ? const Color(0xFFF3F4F6)
                                      : catColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  catIcon,
                                  size: 14,
                                  color: task.isCompleted
                                      ? const Color(0xFF9CA3AF)
                                      : catColor,
                                ),
                              ),
                            ],
                          ),
                          // Active In-Progress Bar
                          if (isActive) ...[
                            Space.y.t08,
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: catColor.withValues(
                                        alpha: 0.2,
                                      ),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        catColor,
                                      ),
                                      minHeight: 4,
                                    ),
                                  ),
                                ),
                                Space.x.t08,
                                Text(
                                  'In progress',
                                  style: AppText.l1b.cl(catColor),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
