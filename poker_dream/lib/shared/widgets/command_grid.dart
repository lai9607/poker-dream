import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../features/bankroll/presentation/screens/bankroll_screen.dart';
import '../../features/sessions/presentation/screens/session_history_screen.dart';
import '../../features/statistics/presentation/screens/statistics_screen.dart';
import '../../features/live/presentation/screens/live_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/social/presentation/screens/social_feed_screen.dart';
import '../../features/tools/presentation/screens/tools_hub_screen.dart';
import '../../features/players/presentation/screens/leaderboard_screen.dart';
import '../../features/staking/presentation/screens/staking_screen.dart';

/// Grid of command tiles for quick actions
class CommandGrid extends StatelessWidget {
  const CommandGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // id, label, icon, route
    final cards = [
      ('bankroll', 'Bankroll', Icons.account_balance_wallet_rounded, const BankrollScreen()),
      ('sessions', 'Sessions', Icons.history_rounded, const SessionHistoryScreen()),
      ('stats', 'Statistics', Icons.analytics_rounded, const StatisticsScreen()),
      ('live_now', 'Live Now', Icons.podcasts_rounded, const LiveScreen()),
      ('tools', 'Poker Tools', Icons.calculate_rounded, const ToolsHubScreen()),
      ('chat', 'Global Chat', Icons.chat_rounded, const ChatScreen()),
      ('feed', 'Social Feed', Icons.feed_rounded, const SocialFeedScreen()),
      ('leaderboard', 'Leaderboard', Icons.leaderboard_rounded, const LeaderboardScreen()),
      ('staking', 'Staking', Icons.handshake_rounded, const StakingScreen()),
    ];

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (_, i) {
        final (id, label, icon, route) = cards[i];
        return CommandTile(id: id, label: label, icon: icon, route: route);
      },
    );
  }
}

/// Individual command tile with gradient background and glow
class CommandTile extends StatelessWidget {
  final String id;
  final String label;
  final IconData icon;
  final Widget? route;

  const CommandTile({
    super.key,
    required this.id,
    required this.label,
    required this.icon,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => route!),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
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
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 10),
              // Label
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
