part of '../configs.dart';

final materialLightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: _lightTheme.primary,
  colorScheme: ColorScheme.light(
    primary: _lightTheme.primary,
    secondary: _lightTheme.accent,
    surface: _lightTheme.specBackground,
    error: _lightTheme.error,
    onPrimary: _lightTheme.onPrimary,
    onError: _lightTheme.specBackground,
  ),
  scaffoldBackgroundColor: _lightTheme.background,
  cardColor: _lightTheme.specBackground,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: _lightTheme.text),
    displayMedium: TextStyle(color: _lightTheme.text),
    displaySmall: TextStyle(color: _lightTheme.text),
    headlineLarge: TextStyle(color: _lightTheme.text),
    headlineMedium: TextStyle(color: _lightTheme.text),
    headlineSmall: TextStyle(color: _lightTheme.text),
    titleLarge: TextStyle(color: _lightTheme.text),
    titleMedium: TextStyle(color: _lightTheme.text),
    titleSmall: TextStyle(color: _lightTheme.text),
    bodyLarge: TextStyle(color: _lightTheme.text),
    bodyMedium: TextStyle(color: _lightTheme.subText),
    bodySmall: TextStyle(color: _lightTheme.subText),
    labelLarge: TextStyle(color: _lightTheme.subText),
    labelMedium: TextStyle(color: _lightTheme.subText),
    labelSmall: TextStyle(color: _lightTheme.subText),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _lightTheme.primary,
      textStyle: AppText.b1b,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _lightTheme.primary,
    foregroundColor: _lightTheme.onPrimary,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: _lightTheme.primary,
    selectionColor: _lightTheme.primary.withValues(alpha: 0.3),
    selectionHandleColor: _lightTheme.primary,
  ),
);

final materialDarkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: _darkTheme.primary,
  colorScheme: ColorScheme.dark(
    primary: _darkTheme.primary,
    secondary: _darkTheme.accent,
    surface: _darkTheme.subBackground,
    error: _darkTheme.error,
    onPrimary: _darkTheme.onPrimary,
    onError: _darkTheme.text,
  ),
  scaffoldBackgroundColor: _darkTheme.background,
  cardColor: _darkTheme.subBackground,
  textTheme: TextTheme(
    displayLarge: TextStyle(color: _darkTheme.text),
    displayMedium: TextStyle(color: _darkTheme.text),
    displaySmall: TextStyle(color: _darkTheme.text),
    headlineLarge: TextStyle(color: _darkTheme.text),
    headlineMedium: TextStyle(color: _darkTheme.text),
    headlineSmall: TextStyle(color: _darkTheme.text),
    titleLarge: TextStyle(color: _darkTheme.text),
    titleMedium: TextStyle(color: _darkTheme.text),
    titleSmall: TextStyle(color: _darkTheme.text),
    bodyLarge: TextStyle(color: _darkTheme.text),
    bodyMedium: TextStyle(color: _darkTheme.subText),
    bodySmall: TextStyle(color: _darkTheme.subText),
    labelLarge: TextStyle(color: _darkTheme.subText),
    labelMedium: TextStyle(color: _darkTheme.subText),
    labelSmall: TextStyle(color: _darkTheme.subText),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _darkTheme.primary,
      textStyle: AppText.b1b,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _darkTheme.primary,
    foregroundColor: _darkTheme.onPrimary,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: _darkTheme.accent,
    selectionColor: _darkTheme.accent.withValues(alpha: 0.3),
    selectionHandleColor: _darkTheme.accent,
  ),
);
