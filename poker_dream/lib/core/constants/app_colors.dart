import 'package:flutter/material.dart';

/// Neon Casino Color Palette - Premium poker experience
class AppColors {
  AppColors._();

  // Neon Primary Colors
  static const Color neonGold = Color(0xFFFFD54F); // Neon Gold - primary accent
  static const Color cerise = Color(0xFFFF3766); // Cerise/Hot Pink - secondary accent

  // Legacy support (keeping for backward compatibility)
  static const Color primary = neonGold; // Updated to neon gold
  static const Color accentGold = neonGold;
  static const Color secondary = cerise;

  // Background Colors - Darker for premium casino feel
  static const Color feltBlack = Color(0xFF0E0F11); // Felt black background
  static const Color charcoal = Color(0xFF15171A); // Charcoal cards
  static const Color componentDark = Color(0xFF202329); // Components
  static const Color surfaceDark = Color(0xFF15171A); // Surface

  // Legacy background support
  static const Color backgroundDark = feltBlack;
  static const Color cardDark = charcoal;
  static const Color backgroundLight = Color(0xFFF8F6F6); // Keep for light mode

  // Text Colors - Higher contrast
  static const Color textLight = Color(0xFFFFFFFF); // Pure white
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFFB0B0B0);
  static const Color textSubtle = Color(0xFF808080);

  // Border Colors
  static const Color borderSubtle = Color(0xFF2A2E34); // Subtle borders
  static const Color borderGlow = Color(0xFF666666); // Glowing borders
  static const Color borderDark = Color(0xFF2A2E34);
  static const Color dividerDark = Color(0xFF333333);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = cerise; // Use cerise for errors
  static const Color info = Color(0xFF2196F3);

  // Overlay Colors
  static const Color overlay = Color(0x4D000000); // 30% black
  static const Color shimmerBase = Color(0xFF2A2A2A);
  static const Color shimmerHighlight = Color(0xFF3A3A3A);

  // Gradient Presets
  static const List<Color> neonGradient = [cerise, neonGold]; // Hot pink to gold
  static const List<Color> goldGradient = [Color(0xFFFFD54F), Color(0xFFFFB300)]; // Gold variations

  // Helper Methods for Consistent Glows and Shadows

  /// Creates a glowing shadow effect (for cards, chips, etc.)
  static BoxShadow glowShadow({
    Color? color,
    double blur = 16,
    double opacity = 0.25,
    Offset offset = const Offset(0, 4),
  }) {
    return BoxShadow(
      color: (color ?? neonGold).withOpacity(opacity),
      blurRadius: blur,
      offset: offset,
    );
  }

  /// Creates a dramatic neon halo effect (for play buttons, CTAs)
  static BoxShadow neonHalo({
    Color? color,
    double blur = 22,
    double opacity = 0.4,
  }) {
    return BoxShadow(
      color: (color ?? neonGold).withOpacity(opacity),
      blurRadius: blur,
    );
  }

  /// Creates a subtle ambient glow (for action chips)
  static BoxShadow ambientGlow({
    Color? color,
    double blur = 18,
    double opacity = 0.18,
  }) {
    return BoxShadow(
      color: (color ?? neonGold).withOpacity(opacity),
      blurRadius: blur,
    );
  }

  /// Creates a dramatic vignette gradient for images
  static LinearGradient vignetteGradient({
    double topOpacity = 0.05,
    double bottomOpacity = 0.65,
  }) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(topOpacity),
        Colors.black.withOpacity(bottomOpacity),
      ],
    );
  }

  /// Creates a readability gradient for overlays
  static LinearGradient readabilityGradient({
    double bottomOpacity = 0.72,
  }) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Colors.black.withOpacity(bottomOpacity),
      ],
    );
  }
}
