part of '../profile.dart';

sealed class ProfileData {
  static const List<int> reminderOptions = [5, 10, 15, 30];

  static const List<String> aboutLinks = [
    'Privacy Policy',
    'Terms of Service',
    'Rate Momentum',
    'Send Feedback',
  ];

  static const avatarStartColor = Color(0xFF3B82F6);
  static const avatarEndColor = Color(0xFF1D4ED8);
  static const streakColor = Color(0xFFF97316);
}
