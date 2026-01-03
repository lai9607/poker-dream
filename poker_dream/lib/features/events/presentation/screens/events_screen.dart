import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/neon_components.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Live', 'Upcoming', 'Completed'];

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
                    'Events',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search_rounded, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
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
                  Tab(text: 'Series'),
                  Tab(text: 'Calendar'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _filters.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: NeonFilterChip(
                      label: filter,
                      isSelected: _selectedFilter == filter,
                      onTap: () => setState(() => _selectedFilter = filter),
                    ),
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
                  _buildSeriesList(),
                  _buildCalendarView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeriesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildSeriesCard(index);
      },
    );
  }

  Widget _buildSeriesCard(int index) {
    final series = [
      {'name': 'WSOP 2025', 'location': 'Las Vegas, NV', 'dates': 'May 28 - Jul 17', 'events': 99, 'status': 'upcoming'},
      {'name': 'WPT World Championship', 'location': 'Las Vegas, NV', 'dates': 'Dec 1 - Dec 20', 'events': 45, 'status': 'live'},
      {'name': 'EPT Paris', 'location': 'Paris, France', 'dates': 'Feb 10 - Feb 20', 'events': 35, 'status': 'upcoming'},
      {'name': 'PokerStars Players Championship', 'location': 'Bahamas', 'dates': 'Jan 22 - Feb 3', 'events': 40, 'status': 'completed'},
      {'name': 'Triton Poker Series', 'location': 'Montenegro', 'dates': 'May 1 - May 15', 'events': 20, 'status': 'upcoming'},
    ];

    final item = series[index % series.length];
    final isLive = item['status'] == 'live';

    return PressableCard(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLive ? AppColors.cerise.withOpacity(0.5) : AppColors.borderSubtle,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Series Image
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                gradient: LinearGradient(
                  colors: isLive
                      ? [AppColors.cerise.withOpacity(0.3), AppColors.charcoal]
                      : [AppColors.neonGold.withOpacity(0.2), AppColors.charcoal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 16,
                    top: 16,
                    child: isLive
                        ? Container(
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
                          )
                        : const SizedBox.shrink(),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      item['name'] as String,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Series Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded, size: 16, color: AppColors.textMuted),
                            const SizedBox(width: 4),
                            Text(
                              item['location'] as String,
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded, size: 16, color: AppColors.textMuted),
                            const SizedBox(width: 4),
                            Text(
                              item['dates'] as String,
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.componentDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${item['events']} Events',
                      style: const TextStyle(
                        color: AppColors.neonGold,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_rounded,
            size: 64,
            color: AppColors.textMuted.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Calendar View',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Browse tournaments by date',
            style: TextStyle(
              color: AppColors.textSubtle,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
