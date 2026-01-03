import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';

class PlayerProfileScreen extends StatefulWidget {
  final String? playerId;

  const PlayerProfileScreen({super.key, this.playerId});

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFollowing = false;

  // Mock player data
  final _PlayerData _player = _PlayerData(
    id: '1',
    name: 'Phil Ivey',
    username: '@philivey',
    avatarColor: Colors.purple,
    isVerified: true,
    bio: '10x WSOP Bracelet Winner | Professional Poker Player | Poker Legend',
    location: 'Las Vegas, NV',
    followers: 2450000,
    following: 156,
    totalEarnings: 43850000,
    cashes: 524,
    tournaments: 892,
    avgCash: 83711,
  );

  final List<_TournamentResult> _results = [
    _TournamentResult(
      name: 'WSOP Main Event',
      date: DateTime(2024, 7, 15),
      buyIn: 10000,
      prize: 2500000,
      position: 3,
      entries: 8500,
    ),
    _TournamentResult(
      name: 'Super High Roller Bowl',
      date: DateTime(2024, 6, 20),
      buyIn: 300000,
      prize: 3600000,
      position: 1,
      entries: 48,
    ),
    _TournamentResult(
      name: 'Triton Million',
      date: DateTime(2024, 5, 10),
      buyIn: 1000000,
      prize: 5200000,
      position: 2,
      entries: 54,
    ),
    _TournamentResult(
      name: 'WSOP \$50K PLO',
      date: DateTime(2024, 6, 5),
      buyIn: 50000,
      prize: 1250000,
      position: 1,
      entries: 112,
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
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.backgroundDark,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showOptions(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _ProfileHeader(player: _player),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Column(
                children: [
                  // Follow Button & Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => _isFollowing = !_isFollowing);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFollowing
                                  ? AppColors.componentDark
                                  : AppColors.neonGold,
                              foregroundColor:
                                  _isFollowing ? AppColors.textLight : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: _isFollowing
                                    ? const BorderSide(color: AppColors.borderSubtle)
                                    : BorderSide.none,
                              ),
                            ),
                            child: Text(
                              _isFollowing ? 'Following' : 'Follow',
                              style: AppTextStyles.buttonText.copyWith(
                                color:
                                    _isFollowing ? AppColors.textLight : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textLight,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: AppColors.borderSubtle),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Message'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.neonGold,
                    labelColor: AppColors.neonGold,
                    unselectedLabelColor: AppColors.textMuted,
                    tabs: const [
                      Tab(text: 'Results'),
                      Tab(text: 'Stats'),
                      Tab(text: 'About'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _ResultsTab(results: _results),
            _StatsTab(player: _player),
            _AboutTab(player: _player),
          ],
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.note_add_outlined),
              title: const Text('Add Note'),
              onTap: () {
                Navigator.pop(context);
                _showAddNote(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Enable Notifications'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.block, color: AppColors.error),
              title: const Text('Block User',
                  style: TextStyle(color: AppColors.error)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.charcoal,
        title: Text('Add Note', style: AppTextStyles.heading4),
        content: TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Write a note about this player...',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
            filled: true,
            fillColor: AppColors.componentDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonGold,
              foregroundColor: Colors.black,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final _PlayerData player;

  const _ProfileHeader({required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            player.avatarColor.withOpacity(0.3),
            AppColors.backgroundDark,
          ],
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: player.avatarColor.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: player.avatarColor,
                width: 3,
              ),
            ),
            child: Center(
              child: Text(
                player.name[0].toUpperCase(),
                style: TextStyle(
                  color: player.avatarColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(player.name, style: AppTextStyles.heading3),
              if (player.isVerified) ...[
                const SizedBox(width: 6),
                const Icon(Icons.verified, color: AppColors.info, size: 20),
              ],
            ],
          ),
          Text(player.username, style: AppTextStyles.labelMedium),
          const SizedBox(height: 12),
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ProfileStat(
                label: 'Followers',
                value: _formatNumber(player.followers),
              ),
              Container(
                width: 1,
                height: 30,
                color: AppColors.borderSubtle,
                margin: const EdgeInsets.symmetric(horizontal: 24),
              ),
              _ProfileStat(
                label: 'Following',
                value: player.following.toString(),
              ),
              Container(
                width: 1,
                height: 30,
                color: AppColors.borderSubtle,
                margin: const EdgeInsets.symmetric(horizontal: 24),
              ),
              _ProfileStat(
                label: 'Earnings',
                value: '\$${_formatNumber(player.totalEarnings)}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class _ResultsTab extends StatelessWidget {
  final List<_TournamentResult> results;

  const _ResultsTab({required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ResultCard(result: result),
        );
      },
    );
  }
}

class _ResultCard extends StatelessWidget {
  final _TournamentResult result;

  const _ResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Position Badge
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _getPositionColor(result.position).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${result.position}',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: _getPositionColor(result.position),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${result.date.day}/${result.date.month}/${result.date.year}',
                      style: AppTextStyles.labelSmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${_formatNumber(result.prize)}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Buy-in: \$${_formatNumber(result.buyIn)}',
                    style: AppTextStyles.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPositionColor(int position) {
    switch (position) {
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

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

class _StatsTab extends StatelessWidget {
  final _PlayerData player;

  const _StatsTab({required this.player});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _StatCard(
          icon: Icons.emoji_events,
          label: 'Total Earnings',
          value: '\$${_formatNumber(player.totalEarnings)}',
          color: AppColors.neonGold,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.casino,
                label: 'Tournaments',
                value: player.tournaments.toString(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.paid,
                label: 'Cashes',
                value: player.cashes.toString(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.percent,
                label: 'ITM %',
                value: '${(player.cashes / player.tournaments * 100).toStringAsFixed(1)}%',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.attach_money,
                label: 'Avg Cash',
                value: '\$${_formatNumber(player.avgCash)}',
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color ?? AppColors.textMuted, size: 20),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.heading4.copyWith(
              color: color ?? AppColors.textLight,
            ),
          ),
          Text(label, style: AppTextStyles.labelSmall),
        ],
      ),
    );
  }
}

class _AboutTab extends StatelessWidget {
  final _PlayerData player;

  const _AboutTab({required this.player});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Bio
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.componentDark,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bio', style: AppTextStyles.heading4),
              const SizedBox(height: 8),
              Text(player.bio, style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Location
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.componentDark,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.textMuted),
              const SizedBox(width: 12),
              Text(player.location, style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayerData {
  final String id;
  final String name;
  final String username;
  final Color avatarColor;
  final bool isVerified;
  final String bio;
  final String location;
  final int followers;
  final int following;
  final int totalEarnings;
  final int cashes;
  final int tournaments;
  final int avgCash;

  _PlayerData({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarColor,
    required this.isVerified,
    required this.bio,
    required this.location,
    required this.followers,
    required this.following,
    required this.totalEarnings,
    required this.cashes,
    required this.tournaments,
    required this.avgCash,
  });
}

class _TournamentResult {
  final String name;
  final DateTime date;
  final int buyIn;
  final int prize;
  final int position;
  final int entries;

  _TournamentResult({
    required this.name,
    required this.date,
    required this.buyIn,
    required this.prize,
    required this.position,
    required this.entries,
  });
}
