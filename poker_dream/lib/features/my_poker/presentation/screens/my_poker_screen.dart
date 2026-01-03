import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../bankroll/presentation/screens/bankroll_screen.dart';
import '../../../sessions/presentation/screens/session_history_screen.dart';
import '../../../statistics/presentation/screens/statistics_screen.dart';

/// My Poker tab screen with internal tab navigation
/// Contains: Bankroll, Sessions, Statistics
class MyPokerScreen extends StatefulWidget {
  const MyPokerScreen({super.key});

  @override
  State<MyPokerScreen> createState() => _MyPokerScreenState();
}

class _MyPokerScreenState extends State<MyPokerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<_TabItem> _tabs = const [
    _TabItem(label: 'Bankroll', icon: Icons.account_balance_wallet),
    _TabItem(label: 'Sessions', icon: Icons.history),
    _TabItem(label: 'Stats', icon: Icons.analytics),
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
              title: Text('My Poker', style: AppTextStyles.heading2),
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
            BankrollContent(),
            SessionsContent(),
            StatisticsContent(),
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
                const SizedBox(width: 6),
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
