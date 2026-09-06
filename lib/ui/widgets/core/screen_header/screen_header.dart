import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momentum/configs/configs.dart';

/// A consistent screen header widget used across all Momentum screens.
///
/// Supports:
/// - [overline] / [date]: Uppercase category or formatted date eyebrow.
/// - [title]: Main screen heading (Inter, 26px bold).
/// - [subtitle]: Descriptive subtext below title.
/// - [trailing]: Optional action buttons or badges aligned to the right.
class ScreenHeader extends StatelessWidget {
  final String title;
  final String? overline;
  final DateTime? date;
  final String? subtitle;
  final Widget? trailing;
  final CrossAxisAlignment crossAxisAlignment;

  const ScreenHeader({
    super.key,
    required this.title,
    this.overline,
    this.date,
    this.subtitle,
    this.trailing,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  String? get _resolvedOverline {
    if (overline != null && overline!.isNotEmpty) {
      return overline!.toUpperCase();
    }
    if (date != null) {
      return DateFormat('EEEE, MMMM d').format(date!).toUpperCase();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final overlineText = _resolvedOverline;

    final textColumn = Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (overlineText != null) ...[
          Text(
            overlineText,
            style: AppText.b2b.cl(AppTheme.c.primary).copyWith(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
          ),
          Space.y.t04,
        ],
        Text(
          title,
          style: AppText.h1b.cl(AppTheme.c.text),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          Space.y.t04,
          Text(
            subtitle!,
            style: AppText.b1.cl(AppTheme.c.subText),
          ),
        ],
      ],
    );

    if (trailing == null) {
      return textColumn;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: textColumn),
        trailing!,
      ],
    );
  }
}
