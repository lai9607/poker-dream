import 'dart:ui';
import 'package:flutter/material.dart';

/// Run this file to see a side-by-side comparison of current vs neon casino styles
///
/// Usage:
/// 1. In main.dart, temporarily replace MyApp with: runApp(StyleComparisonDemo());
/// 2. Run the app
/// 3. Toggle between "Current" and "Neon Casino" tabs
/// 4. Compare the visual differences

void main() => runApp(const StyleComparisonDemo());

class StyleComparisonDemo extends StatelessWidget {
  const StyleComparisonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poker Dream Style Comparison',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      home: const ComparisonScreen(),
    );
  }
}

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({super.key});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style Comparison',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Toggle Tabs
          Container(
            color: Colors.black87,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? const Color(0xFFE53935)
                            : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedIndex == 0
                                ? const Color(0xFFFFD700)
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: const Text(
                        'CURRENT STYLE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? const Color(0xFFFFD54F)
                            : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedIndex == 1
                                ? const Color(0xFFFF3766)
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'NEON CASINO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _selectedIndex == 1
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: _selectedIndex == 0
                ? const CurrentStylePreview()
                : const NeonCasinoStylePreview(),
          ),
        ],
      ),
    );
  }
}

// ========== CURRENT STYLE ==========

class CurrentStylePreview extends StatelessWidget {
  const CurrentStylePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _SectionLabel('Video Highlight'),
        SizedBox(height: 8),
        CurrentVideoCard(),
        SizedBox(height: 24),
        _SectionLabel('News Card'),
        SizedBox(height: 8),
        CurrentNewsCard(),
        SizedBox(height: 24),
        _SectionLabel('Tournament Card'),
        SizedBox(height: 8),
        CurrentTournamentCard(),
        SizedBox(height: 24),
        _SectionLabel('Filter Chips'),
        SizedBox(height: 8),
        CurrentFilterChips(),
      ],
    );
  }
}

class CurrentVideoCard extends StatelessWidget {
  const CurrentVideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Placeholder background
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Play button
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow, color: Colors.black, size: 32),
            ),
          ),
          // Duration
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('15:30',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ),
          // Title
          const Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Text(
              'WSOP Main Event Final Table',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentNewsCard extends StatelessWidget {
  const CurrentNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Color(0xFF2A2A2A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(
              child: Icon(Icons.article, size: 48, color: Color(0xFF666666)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WSOP 2024 Schedule Announced',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dates and events revealed for the upcoming championship.',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFFB0B0B0),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 14, color: const Color(0xFFB0B0B0)),
                    const SizedBox(width: 4),
                    Text('8h ago',
                        style: TextStyle(
                            fontSize: 12, color: const Color(0xFFB0B0B0))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentTournamentCard extends StatelessWidget {
  const CurrentTournamentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Color(0xFF2A2A2A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(
              child:
                  Icon(Icons.emoji_events, size: 48, color: Color(0xFF666666)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Triton Poker Series',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Upcoming',
                          style: TextStyle(
                              color: Color(0xFFFFD700),
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16, color: Color(0xFFB0B0B0)),
                    SizedBox(width: 8),
                    Text('May 1-15, 2025', style: TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Color(0xFFB0B0B0)),
                    SizedBox(width: 8),
                    Text('London, United Kingdom',
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.attach_money,
                        size: 16, color: Color(0xFFFFD700)),
                    SizedBox(width: 8),
                    Text('Prize Pool: \$25,000,000',
                        style: TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentFilterChips extends StatefulWidget {
  const CurrentFilterChips({super.key});

  @override
  State<CurrentFilterChips> createState() => _CurrentFilterChipsState();
}

class _CurrentFilterChipsState extends State<CurrentFilterChips> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CurrentChip(
          label: 'Upcoming',
          isSelected: selected == 0,
          onTap: () => setState(() => selected = 0),
        ),
        const SizedBox(width: 8),
        _CurrentChip(
          label: 'Live',
          isSelected: selected == 1,
          onTap: () => setState(() => selected = 1),
        ),
        const SizedBox(width: 8),
        _CurrentChip(
          label: 'Completed',
          isSelected: selected == 2,
          onTap: () => setState(() => selected = 2),
        ),
      ],
    );
  }
}

class _CurrentChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CurrentChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFD700).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFFFFD700) : const Color(0xFFB0B0B0),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ========== NEON CASINO STYLE ==========

class NeonCasinoStylePreview extends StatelessWidget {
  const NeonCasinoStylePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0E0F11), // Felt black background
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionLabel('Video Highlight'),
          SizedBox(height: 8),
          NeonVideoCard(),
          SizedBox(height: 24),
          _SectionLabel('News Card'),
          SizedBox(height: 8),
          NeonNewsCard(),
          SizedBox(height: 24),
          _SectionLabel('Tournament Card'),
          SizedBox(height: 8),
          NeonTournamentCard(),
          SizedBox(height: 24),
          _SectionLabel('Filter Chips'),
          SizedBox(height: 8),
          NeonFilterChips(),
        ],
      ),
    );
  }
}

class NeonVideoCard extends StatelessWidget {
  const NeonVideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFFFD54F);
    return ClipRRect(
      borderRadius: BorderRadius.circular(28), // More rounded!
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            // Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
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
                    color: neon,
                    boxShadow: [
                      BoxShadow(
                        color: neon.withOpacity(.4),
                        blurRadius: 22, // GLOW!
                      ),
                    ],
                  ),
                  child: const Icon(Icons.play_arrow_rounded,
                      color: Colors.black, size: 40),
                ),
              ),
            ),
            // Duration badge
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.55),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('15:30',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            // Title + progress pills
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('WSOP Main Event Final Table',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _pill(true),
                      const SizedBox(width: 6),
                      _pill(false),
                      const SizedBox(width: 6),
                      _pill(false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(bool full) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 32,
        height: 8,
        decoration: BoxDecoration(
          color: full ? const Color(0xFFFFD54F) : Colors.white24,
          borderRadius: BorderRadius.circular(999),
        ),
      );
}

class NeonNewsCard extends StatefulWidget {
  const NeonNewsCard({super.key});

  @override
  State<NeonNewsCard> createState() => _NeonNewsCardState();
}

class _NeonNewsCardState extends State<NeonNewsCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFFFD54F);
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0, // Press animation!
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: neon.withOpacity(.20),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                // Background placeholder
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
                    ),
                  ),
                ),
                // Gradient overlay
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
                // GLASSMORPHISM content area!
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.35),
                          border:
                              Border.all(color: neon.withOpacity(.35)), // Glow!
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _CategoryPill(text: 'TOURNAMENTS'),
                            const SizedBox(height: 8),
                            const Text(
                              'WSOP 2024 Schedule Announced',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    size: 16, color: Colors.white70),
                                const SizedBox(width: 6),
                                Text('8h ago',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final String text;
  const _CategoryPill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient:
            const LinearGradient(colors: [Color(0xFFFF3766), Color(0xFFFFD54F)]),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }
}

class NeonTournamentCard extends StatelessWidget {
  const NeonTournamentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF15171A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF2A2E34)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 170, // Taller!
            decoration: const BoxDecoration(
              color: Color(0xFF2A2A2A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: const Center(
              child:
                  Icon(Icons.emoji_events, size: 48, color: Color(0xFF666666)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Triton Poker Series',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: const Color(0xFF202329),
                        border:
                            Border.all(color: const Color(0xFFFFD54F)), // Gold border!
                      ),
                      child: const Text('Upcoming',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 16, color: Colors.white70),
                    SizedBox(width: 6),
                    Text('May 1-15, 2025',
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Icon(Icons.place_outlined,
                        size: 16, color: Colors.white70),
                    SizedBox(width: 6),
                    Text('London, United Kingdom',
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 12),
                const PrizePoolMeter(
                    filled: 0.62, label: 'Prize Pool: \$25,000,000'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrizePoolMeter extends StatelessWidget {
  final double filled;
  final String label;

  const PrizePoolMeter({super.key, required this.filled, required this.label});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF1A1C21);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Color(0xFFFFD54F), fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            return Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  height: 10,
                  width: w * filled.clamp(0.0, 1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD54F), Color(0xFFFF3766)],
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

class NeonFilterChips extends StatefulWidget {
  const NeonFilterChips({super.key});

  @override
  State<NeonFilterChips> createState() => _NeonFilterChipsState();
}

class _NeonFilterChipsState extends State<NeonFilterChips> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NeonChip(
          label: 'Upcoming',
          isSelected: selected == 0,
          onTap: () => setState(() => selected = 0),
        ),
        const SizedBox(width: 10),
        _NeonChip(
          label: 'Live',
          isSelected: selected == 1,
          onTap: () => setState(() => selected = 1),
        ),
        const SizedBox(width: 10),
        _NeonChip(
          label: 'Completed',
          isSelected: selected == 2,
          onTap: () => setState(() => selected = 2),
        ),
      ],
    );
  }
}

class _NeonChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NeonChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160), // Animated!
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color:
              isSelected ? const Color(0xFF202329) : const Color(0xFF14161A),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFFD54F)
                : const Color(0xFF2A2E34),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFFFD54F).withOpacity(.25),
                    blurRadius: 16, // GLOW!
                  ),
                ]
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

// ========== SHARED COMPONENTS ==========

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.white70,
        ),
      ),
    );
  }
}
