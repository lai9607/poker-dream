import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Mac-style dock navigation with magnification effect
class PokerChipDock extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final List<String> labels;

  const PokerChipDock({
    super.key,
    required this.index,
    required this.onChanged,
    required this.labels,
  });

  @override
  State<PokerChipDock> createState() => _PokerChipDockState();
}

class _PokerChipDockState extends State<PokerChipDock> {
  double? pointerX; // track finger position for magnification

  void _update(details) => setState(() => pointerX = details.localPosition.dx);
  void _end(_) => setState(() => pointerX = null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: GestureDetector(
        onPanDown: _update,
        onPanUpdate: _update,
        onPanEnd: _end,
        onTapUp: _end,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 86,
              decoration: BoxDecoration(
                color: const Color(0xFF0F1114).withOpacity(.65),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(.08)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 28,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, cons) {
                  final w = cons.maxWidth;
                  final slots = widget.labels.length;
                  final slotW = w / slots;

                  return Row(
                    children: List.generate(slots, (i) {
                      final cx = slotW * (i + 0.5); // center of this item
                      final dx = pointerX == null
                          ? 9999.0
                          : (pointerX! - cx).abs();
                      const spread = 80.0; // bigger spread = softer curve
                      final mag = 1.0 +
                          0.65 *
                              math.exp(-(dx * dx) / (2 * spread * spread));
                      final active = i == widget.index;
                      final scale =
                          pointerX == null ? (active ? 1.12 : 1.0) : mag;

                      return SizedBox(
                        width: slotW,
                        child: _DockItem(
                          label: widget.labels[i],
                          suit: const ['♠', '♣', '♦', '♥', '★'][i],
                          active: active,
                          scale: scale,
                          bubbleVisible: dx < 46 || (pointerX == null && active),
                          onTap: () => widget.onChanged(i),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DockItem extends StatelessWidget {
  final String label;
  final String suit;
  final bool active;
  final double scale;
  final bool bubbleVisible;
  final VoidCallback onTap;

  const _DockItem({
    required this.label,
    required this.suit,
    required this.active,
    required this.scale,
    required this.bubbleVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gold = AppColors.neonGold;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // label bubble (like mac tooltip)
          AnimatedOpacity(
            opacity: bubbleVisible ? 1 : 0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.65),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // magnifying icon
          AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 90),
            child: _SuitIcon(suit: suit, active: active),
          ),
          const SizedBox(height: 6),
          // active indicator dot
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: active ? 10 : 6,
            height: active ? 10 : 6,
            decoration: BoxDecoration(
              color: active ? gold : Colors.white24,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuitIcon extends StatelessWidget {
  final String suit;
  final bool active;

  const _SuitIcon({required this.suit, required this.active});

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: active
          ? AppColors.neonGradient // [cerise, neonGold]
          : const [Color(0xFFB0B3BB), Color(0xFF6C7078)],
    );
    return ShaderMask(
      shaderCallback: (r) => gradient.createShader(r),
      child: Text(
        suit,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.white, // masked
          height: 1.0,
        ),
      ),
    );
  }
}
