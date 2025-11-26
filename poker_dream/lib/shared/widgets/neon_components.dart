import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Glassmorphic card with blur effect - Premium casino aesthetic
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double blur;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.blur = 10,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.35),
            border: Border.all(
              color: (borderColor ?? AppColors.neonGold).withOpacity(.35),
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Gradient category pill - Eye-catching labels
class CategoryPill extends StatelessWidget {
  final String text;
  final List<Color>? gradientColors;
  final EdgeInsets? padding;

  const CategoryPill({
    super.key,
    required this.text,
    this.gradientColors,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// Animated filter chip with glow effect
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
          color: isSelected ? AppColors.componentDark : const Color(0xFF14161A),
          border: Border.all(
            color: isSelected ? AppColors.neonGold : AppColors.borderSubtle,
          ),
          boxShadow: isSelected ? [AppColors.glowShadow(blur: 16)] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

/// Prize pool progress meter with gradient fill
class PrizePoolMeter extends StatelessWidget {
  final double filled; // 0.0 to 1.0
  final String label;
  final double height;

  const PrizePoolMeter({
    super.key,
    required this.filled,
    required this.label,
    this.height = 10,
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
                  height: height,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1C21),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                // Animated gradient fill
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOut,
                  height: height,
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

/// Glowing action chip for CTAs
class GlowActionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final double width;

  const GlowActionChip({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.width = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.charcoal,
        border: Border.all(color: Colors.white12),
        boxShadow: [AppColors.ambientGlow()],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(icon, color: AppColors.neonGold, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.white54,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Press-sensitive card wrapper with scale animation
class PressableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleAmount;

  const PressableCard({
    super.key,
    required this.child,
    this.onTap,
    this.scaleAmount = 0.98,
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
        scale: _pressed ? widget.scaleAmount : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// Animated progress pill for carousels
class AnimatedPill extends StatelessWidget {
  final bool isFilled;
  final double width;
  final double height;
  final Color? activeColor;
  final Color? inactiveColor;

  const AnimatedPill({
    super.key,
    required this.isFilled,
    this.width = 32,
    this.height = 8,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isFilled
            ? (activeColor ?? AppColors.neonGold)
            : (inactiveColor ?? Colors.white24),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

/// Neon status badge with border
class NeonStatusBadge extends StatelessWidget {
  final String label;
  final Color? borderColor;
  final Color? backgroundColor;

  const NeonStatusBadge({
    super.key,
    required this.label,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: backgroundColor ?? AppColors.componentDark,
        border: Border.all(color: borderColor ?? AppColors.neonGold),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// Glowing play button with neon halo
class NeonPlayButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;

  const NeonPlayButton({
    super.key,
    this.onTap,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.neonGold,
          boxShadow: [AppColors.neonHalo()],
        ),
        child: Icon(
          Icons.play_arrow_rounded,
          color: Colors.black,
          size: size * 0.625, // 40/64 ratio
        ),
      ),
    );
  }
}
