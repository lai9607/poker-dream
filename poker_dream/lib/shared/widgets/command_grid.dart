import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Grid of command tiles for quick actions
class CommandGrid extends StatelessWidget {
  const CommandGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // id, label, icon
    final cards = [
      ('find_events', 'Find Events', Icons.search_rounded),
      ('bankroll', 'Bankroll Tracking', Icons.ssid_chart_rounded),
      ('live_now', 'Live Now', Icons.podcasts_rounded),
      ('nearby', 'Nearby Rooms', Icons.place_rounded),
      ('watchlist', 'My Watchlist', Icons.star_rounded),
      ('strategy', 'Strategy Hub', Icons.menu_book_rounded),
    ];

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.9,
      ),
      itemBuilder: (_, i) {
        final (id, label, icon) = cards[i];
        return CommandTile(id: id, label: label, icon: icon);
      },
    );
  }
}

/// Individual command tile with gradient background and glow
class CommandTile extends StatelessWidget {
  final String id;
  final String label;
  final IconData icon;

  const CommandTile({
    super.key,
    required this.id,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tapped: $label'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.charcoal,
          border: Border.all(color: AppColors.borderSubtle),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF15171A), Color(0xFF1C2026)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Icon with circular border and glow
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.neonGold),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonGold.withOpacity(.25),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Icon(icon, color: AppColors.neonGold, size: 20),
              ),
              const SizedBox(width: 12),
              // Label
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Chevron
              const Icon(
                Icons.chevron_right_rounded,
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
