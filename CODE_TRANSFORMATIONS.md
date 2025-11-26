# Code Transformation Guide: Current → Neon Casino Style

This document shows the **exact code changes** needed to transform each component from your current style to the neon casino style.

---

## 🎨 Step 1: Update Color Palette

### File: `lib/core/constants/app_colors.dart`

#### BEFORE (Current):
```dart
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFE53935);        // Red
  static const Color accentGold = Color(0xFFFFD700);     // Gold

  // Background Colors
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textLight = Color(0xFFEAEAEA);
  static const Color textMuted = Color(0xFFB0B0B0);
}
```

#### AFTER (Neon Casino):
```dart
class AppColors {
  // Neon Primary Colors
  static const Color neonGold = Color(0xFFFFD54F);       // Neon Gold
  static const Color cerise = Color(0xFFFF3766);         // Hot Pink

  // Background Colors (Darker)
  static const Color feltBlack = Color(0xFF0E0F11);      // Felt black
  static const Color charcoal = Color(0xFF15171A);       // Charcoal cards
  static const Color componentDark = Color(0xFF202329);  // Components

  // Text Colors (Brighter)
  static const Color textLight = Color(0xFFFFFFFF);      // Pure white
  static const Color textMuted = Color(0xFFB0B0B0);      // Same

  // Gradient Helpers
  static const List<Color> neonGradient = [cerise, neonGold];

  // Border Colors
  static const Color borderSubtle = Color(0xFF2A2E34);
  static const Color borderGlow = Color(0xFF666666);

  // Helper Methods
  static BoxShadow glowShadow({
    Color? color,
    double blur = 16,
    double opacity = 0.25,
  }) {
    return BoxShadow(
      color: (color ?? neonGold).withOpacity(opacity),
      blurRadius: blur,
      offset: const Offset(0, 4),
    );
  }

  static BoxShadow neonHalo({double blur = 22}) {
    return BoxShadow(
      color: neonGold.withOpacity(0.4),
      blurRadius: blur,
    );
  }
}
```

---

## 📦 Step 2: Create Reusable Neon Components

### New File: `lib/shared/widgets/neon_components.dart`

```dart
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Glassmorphic card with blur effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double blur;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.blur = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.35),
            border: Border.all(
              color: (borderColor ?? AppColors.neonGold).withOpacity(.35),
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Gradient category pill
class CategoryPill extends StatelessWidget {
  final String text;
  final List<Color>? gradientColors;

  const CategoryPill({
    super.key,
    required this.text,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: LinearGradient(
          colors: gradientColors ?? AppColors.neonGradient,
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }
}

/// Animated filter chip with glow
class NeonFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NeonFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: isSelected
              ? AppColors.componentDark
              : const Color(0xFF14161A),
          border: Border.all(
            color: isSelected
                ? AppColors.neonGold
                : AppColors.borderSubtle,
          ),
          boxShadow: isSelected
              ? [AppColors.glowShadow(blur: 16)]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Prize pool progress meter with gradient
class PrizePoolMeter extends StatelessWidget {
  final double filled; // 0.0 to 1.0
  final String label;

  const PrizePoolMeter({
    super.key,
    required this.filled,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.neonGold,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Stack(
              children: [
                // Background track
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1C21),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                // Animated fill
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  height: 10,
                  width: width * filled.clamp(0.0, 1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      colors: AppColors.neonGradient,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Glowing action chip
class GlowActionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const GlowActionChip({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.charcoal,
        border: Border.all(color: Colors.white12),
        boxShadow: [AppColors.glowShadow(opacity: 0.18, blur: 18)],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(icon, color: AppColors.neonGold),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Press-sensitive card wrapper
class PressableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const PressableCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  State<PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: widget.child,
      ),
    );
  }
}
```

---

## 🎬 Step 3: Transform Video Highlight Card

### File: `lib/features/home/presentation/screens/home_screen.dart`

#### BEFORE (Lines 241-358):
```dart
class _VideoCard extends StatelessWidget {
  // ... constructor ...

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack([
        // Simple thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(thumbnail),
        ),
        // Basic gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
            ),
          ),
        ),
        // Play button (no glow)
        Center(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, size: 32),
          ),
        ),
        // Duration badge
        Positioned(
          top: 12, right: 12,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(duration),
          ),
        ),
        // Title
        Positioned(
          bottom: 12, left: 12, right: 12,
          child: Text(title, style: AppTextStyles.heading4),
        ),
      ]),
    );
  }
}
```

#### AFTER (Neon Casino):
```dart
class _VideoCard extends StatelessWidget {
  // ... constructor ...

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28), // More rounded!
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack([
          // Thumbnail
          Positioned.fill(
            child: Image.network(
              thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.componentDark,
                child: const Icon(
                  Icons.play_circle_outline,
                  size: 64,
                  color: Colors.white24,
                ),
              ),
            ),
          ),
          // Dramatic vignette
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.65),
                  ],
                ),
              ),
            ),
          ),
          // GLOWING play button
          Positioned.fill(
            child: Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.neonGold,
                  boxShadow: [AppColors.neonHalo()],
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ),
          ),
          // Duration badge (more rounded)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.55),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                duration,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          // Title + animated progress pills
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // Replace page indicator dots with animated pills
                Row(
                  children: [
                    _AnimatedPill(isFilled: true),
                    const SizedBox(width: 6),
                    _AnimatedPill(isFilled: false),
                    const SizedBox(width: 6),
                    _AnimatedPill(isFilled: false),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// New widget for animated progress pills
class _AnimatedPill extends StatelessWidget {
  final bool isFilled;

  const _AnimatedPill({required this.isFilled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 32,
      height: 8,
      decoration: BoxDecoration(
        color: isFilled ? AppColors.neonGold : Colors.white24,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
```

**Key Changes:**
- ✅ Border radius: 12 → 28
- ✅ AspectRatio for consistent sizing
- ✅ Dramatic vignette (0.05 → 0.65 alpha)
- ✅ Glowing play button with shadow halo
- ✅ Animated pills instead of dots

---

## 📰 Step 4: Transform News Card

### File: `lib/features/home/presentation/screens/home_screen.dart`

#### BEFORE (Lines 361-454):
```dart
class _NewsCard extends StatelessWidget {
  // ... constructor ...

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.componentDark, width: 1),
      ),
      child: Column([
        // Image on top
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.network(image, height: 150),
        ),
        // Content below
        Padding(
          padding: EdgeInsets.all(12),
          child: Column([
            Text(title, style: AppTextStyles.heading4),
            SizedBox(height: 8),
            Text(description, style: AppTextStyles.bodySmall),
            SizedBox(height: 8),
            Row([
              Icon(Icons.access_time, size: 14),
              SizedBox(width: 4),
              Text(date),
            ]),
          ]),
        ),
      ]),
    );
  }
}
```

#### AFTER (Neon Casino with Glassmorphism):
```dart
import 'dart:ui'; // Add this import!
import '../../shared/widgets/neon_components.dart'; // Add this!

class _NewsCard extends StatelessWidget {
  // ... constructor ...

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onTap: () {
        // Handle tap
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            AppColors.glowShadow(blur: 24, opacity: 0.20),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack([
            // Full-size background image
            Positioned.fill(
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
                    ),
                  ),
                ),
              ),
            ),
            // Gradient overlay for readability
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.72),
                    ],
                  ),
                ),
              ),
            ),
            // GLASSMORPHISM content area
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add category pill
                    const CategoryPill(text: 'News'),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
```

**Key Changes:**
- ✅ Wrapped in `PressableCard` for press animation
- ✅ Image fills entire card background
- ✅ Glassmorphic content area with blur
- ✅ Gradient category pill
- ✅ Glowing shadow on card
- ✅ Border radius: 12 → 18

---

## 🏆 Step 5: Transform Tournament Card

### File: `lib/features/series/presentation/screens/series_screen.dart`

#### BEFORE (Lines 182-363):
```dart
class _TournamentCard extends StatelessWidget {
  // ... existing code ...

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column([
        // Image (150px)
        Container(height: 150, ...),

        Padding(
          padding: EdgeInsets.all(16),
          child: Column([
            Row([
              Text(tournament.name),
              // Filled status badge
              Container(
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(status),
              ),
            ]),
            // Icon + Date
            Row([Icon(calendar), Text(date)]),
            // Icon + Location
            Row([Icon(location), Text(location)]),
            // Icon + Prize (just text)
            Row([
              Icon(dollar, color: gold),
              Text('Prize Pool: \$XXX', color: gold),
            ]),
          ]),
        ),
      ]),
    );
  }
}
```

#### AFTER (Neon Casino with Prize Meter):
```dart
import '../../shared/widgets/neon_components.dart'; // Add this!

class _TournamentCard extends StatelessWidget {
  // ... existing helper methods ...

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(18), // More rounded
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column([
        // Taller image (170px vs 150px)
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(18),
          ),
          child: Image.network(
            tournament.bannerImageUrl ?? '',
            height: 170,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 170,
              color: AppColors.componentDark,
              child: Icon(
                Icons.emoji_events,
                size: 48,
                color: Colors.white24,
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(14),
          child: Column([
            Row([
              Expanded(
                child: Text(
                  tournament.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 8),
              // BORDERED status badge (not filled)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: AppColors.componentDark,
                  border: Border.all(color: AppColors.neonGold),
                ),
                child: Text(
                  _getStatusLabel(tournament.status),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ]),
            const SizedBox(height: 8),
            Row([
              const Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: Colors.white70,
              ),
              const SizedBox(width: 6),
              Text(
                _formatDateRange(tournament.startDate, tournament.endDate),
                style: const TextStyle(color: Colors.white70),
              ),
            ]),
            if (tournament.location != null) ...[
              const SizedBox(height: 6),
              Row([
                const Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: Colors.white70,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    tournament.location!,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ]),
            ],
            if (tournament.prizePool != null) ...[
              const SizedBox(height: 12),
              // REPLACE text with prize pool meter!
              PrizePoolMeter(
                filled: 0.62, // Calculate based on registration
                label: 'Prize Pool: ${_formatCurrency(tournament.prizePool)}',
              ),
            ],
          ]),
        ),
      ]),
    );
  }
}
```

**Key Changes:**
- ✅ Image height: 150 → 170
- ✅ Border radius: 12 → 18
- ✅ Status badge: filled → bordered
- ✅ Prize display: text → gradient meter
- ✅ Outlined icons instead of filled

---

## 🎯 Step 6: Transform Filter Chips

### File: `lib/features/series/presentation/screens/series_screen.dart`

#### BEFORE (Lines 366-399):
```dart
class _FilterChip extends StatelessWidget {
  // ... constructor ...

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentGold.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? AppColors.accentGold : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
```

#### AFTER (Neon Casino with Glow):
```dart
// Simply replace with the reusable component!
import '../../shared/widgets/neon_components.dart';

// In your build method, replace _FilterChip with:
NeonFilterChip(
  label: 'Upcoming',
  isSelected: _selectedStatus == TournamentStatus.upcoming,
  onTap: () => setState(() => _selectedStatus = TournamentStatus.upcoming),
)

// Or if you want to keep the custom class:
class _FilterChip extends StatelessWidget {
  // ... constructor ...

  @override
  Widget build(BuildContext context) {
    return NeonFilterChip(
      label: label,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}
```

**Key Changes:**
- ✅ Animated transitions (160ms)
- ✅ Glowing border when selected
- ✅ Shadow halo effect
- ✅ Border radius: 20 → 999 (full pill)

---

## 📱 Step 7: Update Page Indicators

### File: `lib/features/home/presentation/screens/home_screen.dart`

#### BEFORE (Lines 112-128):
```dart
// Page indicator dots
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(
    videos.length,
    (index) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.accentGold
            : AppColors.textMuted.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ),
)
```

#### AFTER (Animated Pills):
```dart
// Animated pill indicators
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(
    videos.length,
    (index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 32,
        height: 8,
        decoration: BoxDecoration(
          color: _currentPage == index
              ? AppColors.neonGold
              : Colors.white24,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    ),
  ),
)
```

**Key Changes:**
- ✅ Fixed width pills (32px) instead of variable
- ✅ Animated transitions (250ms)
- ✅ Fully rounded (999 vs 4)
- ✅ Neon gold active color

---

## 🎨 Step 8: Update Theme (Optional)

### File: `lib/core/theme/app_theme.dart`

Add neon-specific theme overrides:

```dart
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      // Update color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonGold,
        secondary: AppColors.cerise,
        surface: AppColors.charcoal,
        background: AppColors.feltBlack,
      ),

      scaffoldBackgroundColor: AppColors.feltBlack,

      // Update card theme
      cardTheme: CardTheme(
        color: AppColors.charcoal,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: AppColors.borderSubtle),
        ),
        shadowColor: AppColors.neonGold.withOpacity(0.2),
      ),

      // Update chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.componentDark,
        selectedColor: AppColors.componentDark,
        side: BorderSide(color: AppColors.borderSubtle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),

      // ... rest of theme
    );
  }
}
```

---

## ✅ Migration Checklist

Use this checklist as you transform your app:

### Phase 1: Foundation (30 min)
- [ ] Update `app_colors.dart` with neon palette
- [ ] Add gradient helpers
- [ ] Add shadow helper methods
- [ ] Create `neon_components.dart` file
- [ ] Test color changes on one screen

### Phase 2: Components (2 hours)
- [ ] Create `GlassCard` widget
- [ ] Create `CategoryPill` widget
- [ ] Create `NeonFilterChip` widget
- [ ] Create `PrizePoolMeter` widget
- [ ] Create `GlowActionChip` widget
- [ ] Create `PressableCard` widget
- [ ] Test all components in demo

### Phase 3: Home Screen (2 hours)
- [ ] Transform `_VideoCard` with glow
- [ ] Add animated pill indicators
- [ ] Transform `_NewsCard` with glassmorphism
- [ ] Add category pills to news
- [ ] Test animations and performance

### Phase 4: Series Screen (1.5 hours)
- [ ] Transform `_TournamentCard`
- [ ] Add prize pool meters
- [ ] Update filter chips with glow
- [ ] Test on different screen sizes

### Phase 5: Polish (1 hour)
- [ ] Update theme file
- [ ] Test dark mode consistency
- [ ] Performance profiling
- [ ] Fix any edge cases
- [ ] Final visual review

---

## 🚀 Quick Start Commands

### 1. Test the Demo
```bash
# Temporarily update main.dart
cd poker_dream

# Replace the runApp line with:
# runApp(const StyleComparisonDemo());

flutter run
```

### 2. Gradual Migration
```bash
# Create a feature branch
git checkout -b feature/neon-ui

# Make changes incrementally
# Test after each phase
flutter run

# Commit after each working phase
git add .
git commit -m "feat: phase 1 - neon color palette"
```

---

## 📊 Performance Considerations

### BackdropFilter Usage
- **Impact:** GPU-intensive on low-end devices
- **Solution:** Use sparingly, limit to 2-3 cards per screen
- **Alternative:** Use semi-transparent backgrounds instead

### Shadow Optimization
- Keep blur radius ≤ 24px
- Limit to 1-2 shadows per element
- Use `const` where possible

### Animation Performance
- All animations use Flutter's optimized `AnimatedContainer`
- Keep durations between 120-350ms
- Avoid simultaneous complex animations

---

## 🎯 Result Preview

After completing all transformations, you'll have:

✅ **Glowing neon aesthetic** with gold & cerise accents
✅ **Glassmorphic cards** with blur effects
✅ **Smooth animations** on all interactions
✅ **Visual progress meters** for prize pools
✅ **Gradient accents** throughout the app
✅ **Press feedback** on all tappable elements
✅ **Consistent glow effects** on active states

Your app will go from a clean Material Design style to a **premium, casino-inspired neon experience** that stands out!

---

Ready to start implementing? Begin with Phase 1 and work your way through! 🎰
