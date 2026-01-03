import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock live streams
  final List<_LiveStream> _streams = [
    _LiveStream(
      id: '1',
      title: 'WSOP Main Event Final Table',
      channel: 'PokerGO',
      viewers: 45200,
      thumbnailUrl: 'https://example.com/wsop.jpg',
      platform: StreamPlatform.youtube,
      isLive: true,
      tournament: 'WSOP 2024',
    ),
    _LiveStream(
      id: '2',
      title: 'High Stakes Cash Game',
      channel: 'Hustler Casino Live',
      viewers: 12800,
      thumbnailUrl: 'https://example.com/hustler.jpg',
      platform: StreamPlatform.youtube,
      isLive: true,
    ),
    _LiveStream(
      id: '3',
      title: 'Live at the Bike \$5/\$10',
      channel: 'Live at the Bike',
      viewers: 8500,
      thumbnailUrl: 'https://example.com/latb.jpg',
      platform: StreamPlatform.youtube,
      isLive: true,
    ),
    _LiveStream(
      id: '4',
      title: 'Phil Ivey Poker Stream',
      channel: 'Phil Ivey',
      viewers: 23400,
      thumbnailUrl: 'https://example.com/ivey.jpg',
      platform: StreamPlatform.twitch,
      isLive: true,
    ),
  ];

  final List<_LiveStream> _upcomingStreams = [
    _LiveStream(
      id: '5',
      title: 'EPT Paris Main Event Day 3',
      channel: 'PokerStars',
      viewers: 0,
      thumbnailUrl: 'https://example.com/ept.jpg',
      platform: StreamPlatform.youtube,
      isLive: false,
      scheduledTime: DateTime.now().add(const Duration(hours: 2)),
      tournament: 'EPT Paris',
    ),
    _LiveStream(
      id: '6',
      title: 'Super High Roller Bowl',
      channel: 'PokerGO',
      viewers: 0,
      thumbnailUrl: 'https://example.com/shrb.jpg',
      platform: StreamPlatform.youtube,
      isLive: false,
      scheduledTime: DateTime.now().add(const Duration(hours: 5)),
    ),
  ];

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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.backgroundDark,
            title: Row(
              children: [
                _LiveIndicator(),
                const SizedBox(width: 10),
                Text('Live Now', style: AppTextStyles.heading2),
              ],
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.neonGold,
              labelColor: AppColors.neonGold,
              unselectedLabelColor: AppColors.textMuted,
              tabs: const [
                Tab(text: 'Live'),
                Tab(text: 'Upcoming'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            // Live Tab
            _LiveStreamsList(streams: _streams),
            // Upcoming Tab
            _UpcomingStreamsList(streams: _upcomingStreams),
          ],
        ),
      ),
    );
  }
}

class _LiveIndicator extends StatefulWidget {
  @override
  State<_LiveIndicator> createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<_LiveIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.error,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.error.withOpacity(0.5 * _controller.value),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LiveStreamsList extends StatelessWidget {
  final List<_LiveStream> streams;

  const _LiveStreamsList({required this.streams});

  @override
  Widget build(BuildContext context) {
    if (streams.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.live_tv, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(
              'No live streams right now',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: streams.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _LiveStreamCard(stream: streams[index]),
        );
      },
    );
  }
}

class _UpcomingStreamsList extends StatelessWidget {
  final List<_LiveStream> streams;

  const _UpcomingStreamsList({required this.streams});

  @override
  Widget build(BuildContext context) {
    if (streams.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(
              'No upcoming streams scheduled',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: streams.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _UpcomingStreamCard(stream: streams[index]),
        );
      },
    );
  }
}

class _LiveStreamCard extends StatelessWidget {
  final _LiveStream stream;

  const _LiveStreamCard({required this.stream});

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onTap: () => _openStream(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.charcoal,
          border: Border.all(color: AppColors.borderSubtle),
          boxShadow: [AppColors.glowShadow(blur: 16, opacity: 0.1)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Container(
                      color: AppColors.componentDark,
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          size: 64,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                  // Live badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(6),
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
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Viewers
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.visibility,
                            size: 14,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatViewers(stream.viewers),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Play button
                  const Center(
                    child: NeonPlayButton(size: 56),
                  ),
                  // Platform badge
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: stream.platform.color.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        stream.platform.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (stream.tournament != null) ...[
                    CategoryPill(text: stream.tournament!),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    stream.title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    stream.channel,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatViewers(int viewers) {
    if (viewers >= 1000000) {
      return '${(viewers / 1000000).toStringAsFixed(1)}M';
    } else if (viewers >= 1000) {
      return '${(viewers / 1000).toStringAsFixed(1)}K';
    }
    return viewers.toString();
  }

  void _openStream(BuildContext context) {
    // TODO: Open stream in video player or external app
  }
}

class _UpcomingStreamCard extends StatelessWidget {
  final _LiveStream stream;

  const _UpcomingStreamCard({required this.stream});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          // Time
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.componentDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  _formatTime(stream.scheduledTime!),
                  style: AppTextStyles.heading4.copyWith(
                    color: AppColors.neonGold,
                  ),
                ),
                Text(
                  _getTimeLabel(stream.scheduledTime!),
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (stream.tournament != null) ...[
                  Text(
                    stream.tournament!,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.neonGold,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  stream.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  stream.channel,
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
          ),
          // Notify button
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: AppColors.textMuted),
            onPressed: () {
              // TODO: Set notification
            },
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${time.minute.toString().padLeft(2, '0')}';
  }

  String _getTimeLabel(DateTime time) {
    final now = DateTime.now();
    final diff = time.difference(now);
    if (diff.inHours < 1) {
      return '${diff.inMinutes}m';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h';
    } else {
      return '${diff.inDays}d';
    }
  }
}

enum StreamPlatform {
  youtube,
  twitch,
  facebook;

  Color get color {
    switch (this) {
      case StreamPlatform.youtube:
        return const Color(0xFFFF0000);
      case StreamPlatform.twitch:
        return const Color(0xFF9146FF);
      case StreamPlatform.facebook:
        return const Color(0xFF1877F2);
    }
  }
}

class _LiveStream {
  final String id;
  final String title;
  final String channel;
  final int viewers;
  final String thumbnailUrl;
  final StreamPlatform platform;
  final bool isLive;
  final String? tournament;
  final DateTime? scheduledTime;

  _LiveStream({
    required this.id,
    required this.title,
    required this.channel,
    required this.viewers,
    required this.thumbnailUrl,
    required this.platform,
    required this.isLive,
    this.tournament,
    this.scheduledTime,
  });
}
