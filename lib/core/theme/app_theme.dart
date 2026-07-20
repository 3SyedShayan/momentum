import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.blue.shade600,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB), // Very light grey/white background
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: Colors.blue.shade600,
        secondary: Colors.blueAccent,
        surface: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black54),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade100,
        disabledColor: Colors.grey.shade200,
        selectedColor: Colors.blue.shade100,
        secondarySelectedColor: Colors.blue.shade200,
        labelStyle: const TextStyle(color: Colors.black87),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.blue.shade500,
      scaffoldBackgroundColor: const Color(0xFF111827), // Tailwind dark slate
      cardColor: const Color(0xFF1F2937), // Tailind medium slate
      colorScheme: ColorScheme.dark(
        primary: Colors.blue.shade500,
        secondary: Colors.blueAccent,
        surface: const Color(0xFF1F2937),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.white70),
        bodyMedium: TextStyle(color: Colors.white60),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade900,
        disabledColor: Colors.grey.shade800,
        selectedColor: Colors.blue.shade900,
        secondarySelectedColor: Colors.blue.shade800,
        labelStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
