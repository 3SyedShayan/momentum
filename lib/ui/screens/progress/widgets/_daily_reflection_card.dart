part of '../progress.dart';

class _DailyReflectionCard extends StatelessWidget {
  const _DailyReflectionCard();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);
    final moods = ['🙂', '😐', '☹️'];

    return Container(
      padding: EdgeInsets.all(SpaceToken.t20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ProgressColors.reflectionStart,
            ProgressColors.reflectionEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ProgressColors.reflectionBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Icon + Title
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: ProgressColors.reflectionIconBox,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  LucideIcons.book_open,
                  size: 14,
                  color: ProgressColors.reflectionPrimary,
                ),
              ),
              Space.x.t08,
              Text(
                'Daily Reflection',
                style: AppText.b1b.cl(AppTheme.c.text),
              ),
            ],
          ),
          Space.y.t08,
          Text(
            'How did today go? What did you learn or accomplish?',
            style: AppText.b2.cl(AppTheme.c.subText),
          ),
          Space.y.t12,

          // Textarea
          TextField(
            controller: state.reflectionController,
            maxLines: 3,
            minLines: 3,
            style: AppText.b2.cl(AppTheme.c.text),
            decoration: InputDecoration(
              hintText: 'Write your reflection for today...',
              hintStyle: AppText.b2.cl(AppTheme.c.subText.withValues(alpha: 0.5)),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.75),
              contentPadding: EdgeInsets.all(SpaceToken.t12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ProgressColors.reflectionBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ProgressColors.reflectionBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: ProgressColors.reflectionPrimary,
                  width: 1.5,
                ),
              ),
            ),
          ),
          Space.y.t12,

          // Actions row: Mood emojis + Save button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: moods.map((mood) {
                  final isSelected = state.selectedMood == mood;
                  return InkWell(
                    onTap: () => state.selectMood(mood),
                    borderRadius: BorderRadius.circular(8),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ProgressColors.reflectionPrimary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(
                                color: ProgressColors.reflectionPrimary,
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Text(
                        mood,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () => state.saveReflection(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ProgressColors.reflectionPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: SpaceToken.t16,
                    vertical: SpaceToken.t08,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Reflection',
                  style: AppText.b2b.cl(Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
