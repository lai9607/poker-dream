import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App text styles using Space Grotesk and Be Vietnam Pro fonts
class AppTextStyles {
  AppTextStyles._();

  // Base text theme using Space Grotesk
  static TextTheme get textTheme => GoogleFonts.spaceGroteskTextTheme();

  // Headings
  static TextStyle get heading1 => GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryDark,
        letterSpacing: -0.5,
      );

  static TextStyle get heading2 => GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryDark,
        letterSpacing: -0.36,
      );

  static TextStyle get heading3 => GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryDark,
        letterSpacing: -0.3,
      );

  static TextStyle get heading4 => GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryDark,
        letterSpacing: -0.27,
      );

  // Body Text
  static TextStyle get bodyLarge => GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textLight,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textLight,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondaryDark,
        height: 1.4,
      );

  // Labels & Captions
  static TextStyle get labelLarge => GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      );

  static TextStyle get labelMedium => GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondaryDark,
      );

  static TextStyle get labelSmall => GoogleFonts.spaceGrotesk(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
        letterSpacing: 0.5,
      );

  static TextStyle get caption => GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
      );

  // Special Styles
  static TextStyle get buttonText => GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight,
        letterSpacing: 0.1,
      );

  static TextStyle get chipText => GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.accentGold,
      );

  static TextStyle get priceText => GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.accentGold,
        letterSpacing: -0.36,
      );

  static TextStyle get navLabel => GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
      );

  static TextStyle get navLabelActive => GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: AppColors.accentGold,
      );

  // Alternative font (Be Vietnam Pro) for specific use cases
  static TextStyle get beVietnamPro => GoogleFonts.beVietnamPro(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textLight,
      );
}
