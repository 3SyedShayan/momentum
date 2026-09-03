part of '../task.dart';

class _DayTabPill extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const _DayTabPill({
    this.label,
    this.icon,
    required this.isSelected,
    this.isEnabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isSelected ? 4 : 1,
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: Space.v.t12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.c.background : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: icon != null
              ? Icon(
                  icon,
                  size: 18,
                  color: isEnabled
                      ? (isSelected ? AppTheme.c.text : AppTheme.c.subText)
                      : AppTheme.c.subText.withValues(alpha: 0.25),
                )
              : Text(
                  label ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (isSelected ? AppText.b1.w(7) : AppText.b2.w(5)).cl(
                    isSelected ? AppTheme.c.text : AppTheme.c.subText,
                  ),
                ),
        ),
      ),
    );
  }
}
