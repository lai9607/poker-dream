import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// App theme configuration matching the HTML design system
class AppTheme {
  AppTheme._();

  /// Dark theme (primary theme for Poker Dream) - Neon Casino Style
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Neon Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonGold,
        primaryContainer: AppColors.componentDark,
        secondary: AppColors.cerise,
        secondaryContainer: AppColors.charcoal,
        surface: AppColors.feltBlack,
        surfaceContainerHighest: AppColors.charcoal,
        error: AppColors.cerise,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppColors.textLight,
        onSurfaceVariant: AppColors.textMuted,
      ),

      // Scaffold - Felt black background
      scaffoldBackgroundColor: AppColors.feltBlack,

      // AppBar - Neon style with felt black background
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.feltBlack,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTextStyles.heading3,
        iconTheme: const IconThemeData(
          color: AppColors.textLight,
          size: 24,
        ),
      ),

      // Card - More rounded with neon style
      cardTheme: CardThemeData(
        color: AppColors.charcoal,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          side: BorderSide(color: AppColors.borderSubtle),
        ),
        margin: EdgeInsets.zero,
        shadowColor: AppColors.neonGold.withOpacity(0.2),
      ),

      // Bottom Navigation - Neon style
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.feltBlack,
        selectedItemColor: AppColors.neonGold,
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

      // Button Themes - Neon style with rounded corners
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neonGold,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999), // Full pill
          ),
          textStyle: AppTextStyles.buttonText.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.neonGold,
          side: const BorderSide(color: AppColors.neonGold, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999), // Full pill
          ),
          textStyle: AppTextStyles.buttonText.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.neonGold,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: AppTextStyles.buttonText.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Chip Theme - Neon style with glow
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.componentDark,
        selectedColor: AppColors.componentDark,
        disabledColor: const Color(0xFF14161A),
        labelStyle: AppTextStyles.chipText,
        secondaryLabelStyle: AppTextStyles.chipText,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        side: BorderSide(color: AppColors.borderSubtle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999), // Full pill
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

      colorScheme: const ColorScheme.light(
        primary: AppColors.neonGold,
        primaryContainer: AppColors.componentDark,
        secondary: AppColors.cerise,
        secondaryContainer: AppColors.charcoal,
        surface: AppColors.backgroundLight,
        error: AppColors.cerise,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.black87,
      ),

      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    );
  }
}
