import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// App theme configuration matching the HTML design system
class AppTheme {
  AppTheme._();

  /// Dark theme (primary theme for Poker Dream)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryVariant,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.accentGold,
        surface: AppColors.backgroundDark,
        surfaceContainerHighest: AppColors.cardDark,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: AppColors.textLight,
        onSurfaceVariant: AppColors.textMuted,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTextStyles.heading3,
        iconTheme: const IconThemeData(
          color: AppColors.textLight,
          size: 24,
        ),
      ),

      // Card
      cardTheme: const CardThemeData(
        color: AppColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        margin: EdgeInsets.zero,
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundDark.withValues(alpha: 0.9),
        selectedItemColor: AppColors.accentGold,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTextStyles.navLabelActive,
        unselectedLabelStyle: AppTextStyles.navLabel,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.heading1,
        displayMedium: AppTextStyles.heading2,
        displaySmall: AppTextStyles.heading3,
        headlineMedium: AppTextStyles.heading4,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textMuted,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTextStyles.buttonText,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTextStyles.buttonText,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: AppTextStyles.buttonText,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        selectedColor: AppColors.accentGold.withValues(alpha: 0.2),
        disabledColor: AppColors.textMuted.withValues(alpha: 0.1),
        labelStyle: AppTextStyles.chipText,
        secondaryLabelStyle: AppTextStyles.chipText,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.textLight,
        size: 24,
      ),

      // Material Symbols (for Material Icons)
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    );
  }

  /// Light theme (optional, for future support)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryVariant,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.accentGold,
        surface: AppColors.backgroundLight,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black87,
      ),

      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    );
  }
}
