import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'All Time';

  // Mock leaderboard data
  final List<_LeaderboardPlayer> _earningsLeaders = [
    _LeaderboardPlayer(
      rank: 1,
      name: 'Bryn Kenney',
      earnings: 56403505,
      avatarColor: Colors.purple,
      isVerified: true,
      country: 'US',
    ),
    _LeaderboardPlayer(
      rank: 2,
      name: 'Justin Bonomo',
      earnings: 53233785,
      avatarColor: Colors.blue,
      isVerified: true,
      country: 'US',
    ),
    _LeaderboardPlayer(
      rank: 3,
      name: 'Daniel Negreanu',
      earnings: 46117911,
      avatarColor: Colors.red,
      isVerified: true,
      country: 'CA',
    ),
    _LeaderboardPlayer(
      rank: 4,
      name: 'Jason Koon',
      earnings: 41287890,
      avatarColor: Colors.green,
      isVerified: true,
      country: 'US',
    ),
    _LeaderboardPlayer(
      rank: 5,
      name: 'Erik Seidel',
      earnings: 40456683,
      avatarColor: Colors.orange,
      isVerified: true,
      country: 'US',
    ),
    _LeaderboardPlayer(
      rank: 6,
      name: 'Phil Ivey',
      earnings: 38765342,
      avatarColor: Colors.teal,
      isVerified: true,
      country: 'US',
    ),
    _LeaderboardPlayer(
      rank: 7,
      name: 'Dan Smith',
      earnings: 37891234,
      avatarColor: Colors.cyan,
      isVerified: true,
      country: 'US',
    ),
    _LeaderboardPlayer(
      rank: 8,
      name: 'Stephen Chidwick',
      earnings: 35678901,
      avatarColor: Colors.indigo,
      isVerified: true,
      country: 'GB',
    ),
    _LeaderboardPlayer(
      rank: 9,
      name: 'David Peters',
      earnings: 34567890,
      avatarColor: Colors.amber,
      isVerified: true,
      country: 'US',
    ),
    _LeaderboardPlayer(
      rank: 10,
      name: 'Fedor Holz',
      earnings: 33456789,
      avatarColor: Colors.pink,
      isVerified: true,
      country: 'DE',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Leaderboard', style: AppTextStyles.heading2),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list, color: AppColors.textMuted),
                color: AppColors.charcoal,
                onSelected: (value) {
                  setState(() => _selectedPeriod = value);
                },
                itemBuilder: (context) => [
                  'All Time',
                  'This Year',
                  'This Month',
                  'This Week',
                ].map((period) => PopupMenuItem(
                      value: period,
                      child: Text(period),
                    )).toList(),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.neonGold,
              labelColor: AppColors.neonGold,
              unselectedLabelColor: AppColors.textMuted,
              tabs: const [
                Tab(text: 'Earnings'),
                Tab(text: 'ROI'),
                Tab(text: 'Cashes'),
              ],
            ),
          ),
        ],
        body: Column(
          children: [
            // Period indicator
            Container(
              padding: const EdgeInsets.all(12),
              color: AppColors.componentDark,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 8),
                  Text(
                    _selectedPeriod,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.neonGold,
                    ),
                  ),
                ],
              ),
            ),
            // Leaderboard content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _LeaderboardList(players: _earningsLeaders, type: 'earnings'),
                  _LeaderboardList(players: _earningsLeaders, type: 'roi'),
                  _LeaderboardList(players: _earningsLeaders, type: 'cashes'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaderboardList extends StatelessWidget {
  final List<_LeaderboardPlayer> players;
  final String type;

  const _LeaderboardList({
    required this.players,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _LeaderboardCard(
            player: player,
            type: type,
          ),
        );
      },
    );
  }
}

class _LeaderboardCard extends StatelessWidget {
  final _LeaderboardPlayer player;
  final String type;

  const _LeaderboardCard({
    required this.player,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onTap: () {
        // Navigate to player profile
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: player.rank <= 3
              ? _getRankColor(player.rank).withOpacity(0.1)
              : AppColors.charcoal,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: player.rank <= 3
                ? _getRankColor(player.rank).withOpacity(0.3)
                : AppColors.borderSubtle,
          ),
        ),
        child: Row(
          children: [
            // Rank
            SizedBox(
              width: 40,
              child: player.rank <= 3
                  ? _RankBadge(rank: player.rank)
                  : Center(
                      child: Text(
                        '${player.rank}',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            // Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: player.avatarColor.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: player.avatarColor.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      player.name[0].toUpperCase(),
                      style: TextStyle(
                        color: player.avatarColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Country flag
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.charcoal,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getFlag(player.country),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Name & Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          player.name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (player.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.verified,
                            color: AppColors.info, size: 16),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getSubtitle(type),
                    style: AppTextStyles.labelSmall,
                  ),
                ],
              ),
            ),
            // Value
            Text(
              _getValue(type),
              style: AppTextStyles.heading4.copyWith(
                color: player.rank <= 3
                    ? _getRankColor(player.rank)
                    : AppColors.neonGold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getValue(String type) {
    switch (type) {
      case 'earnings':
        return '\$${_formatNumber(player.earnings)}';
      case 'roi':
        return '${(50 + player.rank * 5)}%'; // Mock ROI
      case 'cashes':
        return '${500 - player.rank * 30}'; // Mock cashes
      default:
        return '';
    }
  }

  String _getSubtitle(String type) {
    switch (type) {
      case 'earnings':
        return 'Lifetime earnings';
      case 'roi':
        return 'Return on investment';
      case 'cashes':
        return 'Career cashes';
      default:
        return '';
    }
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return AppColors.neonGold;
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return AppColors.textMuted;
    }
  }

  String _getFlag(String countryCode) {
    switch (countryCode) {
      case 'US':
        return '🇺🇸';
      case 'CA':
        return '🇨🇦';
      case 'GB':
        return '🇬🇧';
      case 'DE':
        return '🇩🇪';
      default:
        return '🏳️';
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}K';
    }
    return number.toString();
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;

  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color,
            color.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: rank == 1
            ? const Icon(Icons.emoji_events, color: Colors.black, size: 20)
            : Text(
                '$rank',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }

  Color _getColor() {
    switch (rank) {
      case 1:
        return AppColors.neonGold;
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return AppColors.textMuted;
    }
  }
}

class _LeaderboardPlayer {
  final int rank;
  final String name;
  final int earnings;
  final Color avatarColor;
  final bool isVerified;
  final String country;

  _LeaderboardPlayer({
    required this.rank,
    required this.name,
    required this.earnings,
    required this.avatarColor,
    required this.isVerified,
    required this.country,
  });
}
