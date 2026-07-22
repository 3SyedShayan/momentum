part of '../configs.dart';

/// Brand + status colors shared across both themes.
sealed class AppColors {
  static const primary = Color(0xff2563EB);
  static const accent = Color(0xff3B82F6);

  /// Text / icon color rendered ON a primary-colored surface.
  static const onPrimary = Color(0xffFFFFFF);

  /// Text / icon color rendered ON an accent-colored surface.
  static const onAccent = Color(0xffFFFFFF);

  static const error = Color(0xffEF4444);
  static const success = Color(0xff10B981);
  static const warning = Color(0xffF59E0B);
}

/// Color tokens for the light theme.
sealed class AppColorsLight {
  static const primary = Color(0xff2563EB);
  static const accent = Color(0xff3B82F6);

  static const text = Color(0xff111827);
  static const subText = Color(0xff4B5563);
  static const background = Color(0xffF9FAFB);
  static const specBackground = Color(0xffFFFFFF);
  static const subBackground = Color(0xffF3F4F6);

  /// Subtle border for cards, inputs, and dividers.
  static const border = Color(0xffE5E7EB);
}

/// Color tokens for the dark theme.
sealed class AppColorsDark {
  static const primary = Color(0xff3B82F6);
  static const accent = Color(0xff60A5FA);

  static const text = Color(0xffF9FAFB);
  static const subText = Color(0xff9CA3AF);
  static const background = Color(0xff111827);

  /// Elevated surface for neutral cards and inputs in dark theme.
  static const subBackground = Color(0xff1F2937);

  /// Further-elevated surface — form inputs and floating cards.
  static const specBackground = Color(0xff374151);

  /// Subtle border for cards, inputs, and dividers.
  static const border = Color(0xff374151);
}

