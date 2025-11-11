import 'package:flutter/material.dart';

/// App color constants matching the HTML designs
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFFE53935); // Red from design
  static const Color primaryVariant = Color(0xFFD32F2F);
  static const Color primaryLight = Color(0xFFE4212E);

  // Secondary/Accent Colors
  static const Color secondary = Color(0xFFFFC107); // Gold/Yellow
  static const Color accentGold = Color(0xFFFFD700);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F6F6);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color componentDark = Color(0xFF1E1E1E);
  static const Color surfaceDark = Color(0xFF211112);

  // Text Colors
  static const Color textLight = Color(0xFFEAEAEA);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFA9A9A9);
  static const Color textMuted = Color(0xFFB0B0B0);
  static const Color textSubtle = Color(0xFF9E9E9E);

  // Border Colors
  static const Color borderDark = Color(0xFF2A2A2A);
  static const Color dividerDark = Color(0xFF333333);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Overlay Colors
  static const Color overlay = Color(0x4D000000); // 30% black
  static const Color shimmerBase = Color(0xFF2A2A2A);
  static const Color shimmerHighlight = Color(0xFF3A3A3A);
}
