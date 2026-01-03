import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../social/presentation/screens/social_feed_screen.dart';
import '../../../live/presentation/screens/live_screen.dart';
import '../../../chat/presentation/screens/chat_screen.dart';
import '../../../players/presentation/screens/leaderboard_screen.dart';

/// Community tab screen with internal tab navigation
/// Contains: Feed, Live, Chat, Players
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<_TabItem> _tabs = const [
    _TabItem(label: 'Feed', icon: Icons.feed),
    _TabItem(label: 'Live', icon: Icons.live_tv),
    _TabItem(label: 'Chat', icon: Icons.chat),
    _TabItem(label: 'Players', icon: Icons.leaderboard),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: AppColors.backgroundDark,
              title: Text('Community', style: AppTextStyles.heading2),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: _buildTabBar(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            FeedContent(),
            LiveContent(),
            ChatContent(),
            PlayersContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.neonGold,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        labelColor: Colors.black,
        unselectedLabelColor: AppColors.textMuted,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: AppTextStyles.labelMedium,
        dividerColor: Colors.transparent,
        tabs: _tabs.map((tab) {
          return Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tab.icon, size: 16),
                const SizedBox(width: 4),
                Text(tab.label),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TabItem {
  final String label;
  final IconData icon;

  const _TabItem({required this.label, required this.icon});
}

// ============================================================
// Feed Content (embedded from social_feed_screen.dart)
// ============================================================
class FeedContent extends StatelessWidget {
  const FeedContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to full Social Feed screen for full functionality
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SocialFeedScreen()),
        );
      },
      child: const _QuickLaunchContent(
        icon: Icons.feed,
        title: 'Social Feed',
        subtitle: 'Posts from players you follow',
        buttonText: 'Open Feed',
      ),
    );
  }
}

// ============================================================
// Live Content (embedded from live_screen.dart)
// ============================================================
class LiveContent extends StatelessWidget {
  const LiveContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LiveScreen()),
        );
      },
      child: const _QuickLaunchContent(
        icon: Icons.live_tv,
        title: 'Live Streams',
        subtitle: 'Watch poker streams from around the world',
        buttonText: 'Watch Now',
        hasLiveBadge: true,
      ),
    );
  }
}

// ============================================================
// Chat Content (embedded from chat_screen.dart)
// ============================================================
class ChatContent extends StatelessWidget {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChatScreen()),
        );
      },
      child: const _QuickLaunchContent(
        icon: Icons.chat,
        title: 'Chat Rooms',
        subtitle: 'Join discussions with the poker community',
        buttonText: 'Open Chat',
      ),
    );
  }
}

// ============================================================
// Players Content (embedded from leaderboard_screen.dart)
// ============================================================
class PlayersContent extends StatelessWidget {
  const PlayersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
        );
      },
      child: const _QuickLaunchContent(
        icon: Icons.leaderboard,
        title: 'Leaderboard',
        subtitle: 'Top player rankings and profiles',
        buttonText: 'View Rankings',
      ),
    );
  }
}

// ============================================================
// Quick Launch Content Widget
// ============================================================
class _QuickLaunchContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final bool hasLiveBadge;

  const _QuickLaunchContent({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.hasLiveBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.neonGold.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.neonGold.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(icon, size: 36, color: AppColors.neonGold),
                ),
                if (hasLiveBadge)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTextStyles.heading3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Tap is handled by parent GestureDetector
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonGold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                buttonText,
                style: AppTextStyles.buttonText.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
