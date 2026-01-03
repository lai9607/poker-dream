import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/neon_components.dart';

class LiveStreamsScreen extends StatefulWidget {
  const LiveStreamsScreen({super.key});

  @override
  State<LiveStreamsScreen> createState() => _LiveStreamsScreenState();
}

class _LiveStreamsScreenState extends State<LiveStreamsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPlatform = 'All';

  final List<String> _platforms = ['All', 'YouTube', 'Twitch', 'Facebook'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.feltBlack,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Live',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.cerise,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '5 LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.charcoal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.neonGold,
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                unselectedLabelColor: AppColors.textMuted,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Live Now'),
                  Tab(text: 'Upcoming'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Platform Filter
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _platforms.map((platform) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildPlatformChip(platform),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLiveStreamsList(),
                  _buildUpcomingStreamsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformChip(String platform) {
    final isSelected = _selectedPlatform == platform;
    Color getColor() {
      switch (platform) {
        case 'YouTube':
          return const Color(0xFFFF0000);
        case 'Twitch':
          return const Color(0xFF9146FF);
        case 'Facebook':
          return const Color(0xFF1877F2);
        default:
          return AppColors.neonGold;
      }
    }

    return GestureDetector(
      onTap: () => setState(() => _selectedPlatform = platform),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: isSelected ? getColor().withOpacity(0.2) : AppColors.charcoal,
          border: Border.all(
            color: isSelected ? getColor() : AppColors.borderSubtle,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (platform != 'All') ...[
              Icon(
                platform == 'YouTube'
                    ? Icons.play_circle_fill
                    : platform == 'Twitch'
                        ? Icons.videogame_asset
                        : Icons.facebook,
                size: 16,
                color: isSelected ? getColor() : AppColors.textMuted,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              platform,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textMuted,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveStreamsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildStreamCard(index, isLive: true);
      },
    );
  }

  Widget _buildUpcomingStreamsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildStreamCard(index, isLive: false);
      },
    );
  }

  Widget _buildStreamCard(int index, {required bool isLive}) {
    final streams = [
      {'title': 'WPT Final Table - \$10M GTD', 'channel': 'PokerGO', 'viewers': '45.2K', 'platform': 'YouTube'},
      {'title': 'Hustler Casino Live', 'channel': 'HCL Poker', 'viewers': '32.1K', 'platform': 'YouTube'},
      {'title': 'High Stakes Poker', 'channel': 'PokerStarsTV', 'viewers': '28.5K', 'platform': 'Twitch'},
      {'title': 'WSOP Main Event Day 5', 'channel': 'WSOP', 'viewers': '52.3K', 'platform': 'Facebook'},
      {'title': 'Daniel Negreanu Streams', 'channel': 'DNegs', 'viewers': '18.2K', 'platform': 'Twitch'},
    ];

    final item = streams[index % streams.length];
    Color getPlatformColor() {
      switch (item['platform']) {
        case 'YouTube':
          return const Color(0xFFFF0000);
        case 'Twitch':
          return const Color(0xFF9146FF);
        case 'Facebook':
          return const Color(0xFF1877F2);
        default:
          return AppColors.neonGold;
      }
    }

    return PressableCard(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stream Thumbnail
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                gradient: LinearGradient(
                  colors: [
                    getPlatformColor().withOpacity(0.3),
                    AppColors.charcoal,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  // Play Button
                  Center(
                    child: NeonPlayButton(
                      onTap: () {},
                      size: 56,
                    ),
                  ),
                  // Live Badge
                  if (isLive)
                    Positioned(
                      left: 12,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.cerise,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'LIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Platform Badge
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: getPlatformColor(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['platform'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  // Viewer Count
                  if (isLive)
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.visibility, size: 14, color: Colors.white70),
                            const SizedBox(width: 4),
                            Text(
                              item['viewers'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Stream Info
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColors.componentDark,
                        child: Text(
                          (item['channel'] as String)[0],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neonGold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['channel'] as String,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      if (!isLive)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.componentDark,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'In 2 hours',
                            style: TextStyle(
                              color: AppColors.neonGold,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
}
