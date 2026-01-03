import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';

class StakingScreen extends StatefulWidget {
  const StakingScreen({super.key});

  @override
  State<StakingScreen> createState() => _StakingScreenState();
}

class _StakingScreenState extends State<StakingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  // Mock staking offerings
  final List<_StakingOffer> _offers = [
    _StakingOffer(
      id: '1',
      player: _StakePlayer(
        name: 'Mike Chen',
        avatarColor: Colors.blue,
        rating: 4.8,
        completedStakes: 24,
        roi: 35.2,
      ),
      event: 'WSOP \$10K Main Event',
      buyIn: 10000,
      markup: 1.2,
      availablePercent: 60,
      soldPercent: 40,
      eventDate: DateTime.now().add(const Duration(days: 5)),
    ),
    _StakingOffer(
      id: '2',
      player: _StakePlayer(
        name: 'Sarah Kim',
        avatarColor: Colors.purple,
        rating: 4.9,
        completedStakes: 18,
        roi: 42.5,
        isVerified: true,
      ),
      event: 'Venetian \$1,600 Mystery Bounty',
      buyIn: 1600,
      markup: 1.15,
      availablePercent: 80,
      soldPercent: 20,
      eventDate: DateTime.now().add(const Duration(days: 2)),
    ),
    _StakingOffer(
      id: '3',
      player: _StakePlayer(
        name: 'Jake Williams',
        avatarColor: Colors.green,
        rating: 4.5,
        completedStakes: 12,
        roi: 28.0,
      ),
      event: 'Wynn \$600 Daily',
      buyIn: 600,
      markup: 1.1,
      availablePercent: 100,
      soldPercent: 0,
      eventDate: DateTime.now().add(const Duration(days: 1)),
    ),
    _StakingOffer(
      id: '4',
      player: _StakePlayer(
        name: 'Emily Torres',
        avatarColor: Colors.orange,
        rating: 4.7,
        completedStakes: 31,
        roi: 38.9,
        isVerified: true,
      ),
      event: 'ARIA \$1,100 High Roller',
      buyIn: 1100,
      markup: 1.18,
      availablePercent: 45,
      soldPercent: 55,
      eventDate: DateTime.now().add(const Duration(days: 3)),
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Staking', style: AppTextStyles.heading2),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline,
                    color: AppColors.neonGold),
                onPressed: () => _showSellAction(context),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.neonGold,
              labelColor: AppColors.neonGold,
              unselectedLabelColor: AppColors.textMuted,
              tabs: const [
                Tab(text: 'Browse'),
                Tab(text: 'My Stakes'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _BrowseTab(
              offers: _offers,
              selectedFilter: _selectedFilter,
              onFilterChanged: (filter) {
                setState(() => _selectedFilter = filter);
              },
            ),
            const _MyStakesTab(),
          ],
        ),
      ),
    );
  }

  void _showSellAction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => const _SellActionSheet(),
    );
  }
}

class _BrowseTab extends StatelessWidget {
  final List<_StakingOffer> offers;
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const _BrowseTab({
    required this.offers,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: ['All', 'Under \$1K', '\$1K-\$5K', '\$5K+'].map((filter) {
              final isSelected = filter == selectedFilter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: NeonFilterChip(
                  label: filter,
                  isSelected: isSelected,
                  onTap: () => onFilterChanged(filter),
                ),
              );
            }).toList(),
          ),
        ),
        // Offers List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _StakingCard(offer: offers[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StakingCard extends StatelessWidget {
  final _StakingOffer offer;

  const _StakingCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    final daysUntil = offer.eventDate.difference(DateTime.now()).inDays;

    return PressableCard(
      onTap: () => _showOfferDetails(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Player info
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: offer.player.avatarColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: offer.player.avatarColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      offer.player.name[0].toUpperCase(),
                      style: TextStyle(
                        color: offer.player.avatarColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            offer.player.name,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (offer.player.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified,
                                color: AppColors.info, size: 16),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 14, color: AppColors.neonGold),
                          const SizedBox(width: 4),
                          Text(
                            '${offer.player.rating} · ${offer.player.completedStakes} stakes',
                            style: AppTextStyles.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${offer.player.roi.toStringAsFixed(0)}% ROI',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Event info
            Text(
              offer.event,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            // Details row
            Row(
              children: [
                _DetailTag(
                  icon: Icons.attach_money,
                  label: '\$${offer.buyIn}',
                ),
                const SizedBox(width: 12),
                _DetailTag(
                  icon: Icons.trending_up,
                  label: '${offer.markup}x markup',
                ),
                const SizedBox(width: 12),
                _DetailTag(
                  icon: Icons.calendar_today,
                  label: daysUntil == 0
                      ? 'Today'
                      : daysUntil == 1
                          ? 'Tomorrow'
                          : 'In $daysUntil days',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Availability
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${offer.availablePercent}% available',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.neonGold,
                            ),
                          ),
                          Text(
                            '${offer.soldPercent}% sold',
                            style: AppTextStyles.labelSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: offer.soldPercent / 100,
                          backgroundColor: AppColors.neonGold.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.neonGold,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _showBuySheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGold,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Buy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOfferDetails(BuildContext context) {
    // TODO: Navigate to offer details
  }

  void _showBuySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _BuyActionSheet(offer: offer),
    );
  }
}

class _DetailTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailTag({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textMuted),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class _BuyActionSheet extends StatefulWidget {
  final _StakingOffer offer;

  const _BuyActionSheet({required this.offer});

  @override
  State<_BuyActionSheet> createState() => _BuyActionSheetState();
}

class _BuyActionSheetState extends State<_BuyActionSheet> {
  double _percentToBuy = 10;

  double get _cost =>
      (widget.offer.buyIn * (_percentToBuy / 100) * widget.offer.markup);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Buy Action', style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Text(widget.offer.event, style: AppTextStyles.bodyMedium),
            const SizedBox(height: 24),

            // Percentage selector
            Text('Select Percentage', style: AppTextStyles.labelMedium),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [5, 10, 20, 25, 50].map((percent) {
                final isSelected = _percentToBuy == percent;
                return GestureDetector(
                  onTap: () => setState(() => _percentToBuy = percent.toDouble()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.neonGold.withOpacity(0.2)
                          : AppColors.componentDark,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.neonGold
                            : AppColors.borderSubtle,
                      ),
                    ),
                    child: Text(
                      '$percent%',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.neonGold
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Cost breakdown
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.componentDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Buy-in portion', style: AppTextStyles.bodyMedium),
                      Text(
                        '\$${(widget.offer.buyIn * _percentToBuy / 100).toStringAsFixed(0)}',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Markup (${widget.offer.markup}x)',
                          style: AppTextStyles.bodyMedium),
                      Text(
                        '\$${(_cost - (widget.offer.buyIn * _percentToBuy / 100)).toStringAsFixed(0)}',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.borderSubtle, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Cost', style: AppTextStyles.bodyLarge),
                      Text(
                        '\$${_cost.toStringAsFixed(0)}',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.neonGold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Buy button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Action purchased successfully!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Confirm Purchase - \$${_cost.toStringAsFixed(0)}',
                  style: AppTextStyles.buttonText.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyStakesTab extends StatelessWidget {
  const _MyStakesTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No active stakes',
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 8),
          Text(
            'Your purchased and sold actions will appear here',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SellActionSheet extends StatefulWidget {
  const _SellActionSheet();

  @override
  State<_SellActionSheet> createState() => _SellActionSheetState();
}

class _SellActionSheetState extends State<_SellActionSheet> {
  final _eventController = TextEditingController();
  final _buyInController = TextEditingController();
  double _markup = 1.1;
  double _percentToSell = 50;

  @override
  void dispose() {
    _eventController.dispose();
    _buyInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sell Action', style: AppTextStyles.heading3),
            const SizedBox(height: 20),

            // Event name
            TextField(
              controller: _eventController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                hintText: 'e.g., WSOP \$1,500 NLH',
                filled: true,
                fillColor: AppColors.componentDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Buy-in
            TextField(
              controller: _buyInController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Buy-in Amount',
                prefixText: '\$ ',
                filled: true,
                fillColor: AppColors.componentDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Markup
            Text('Markup: ${_markup.toStringAsFixed(2)}x',
                style: AppTextStyles.labelMedium),
            Slider(
              value: _markup,
              min: 1.0,
              max: 1.5,
              divisions: 10,
              activeColor: AppColors.neonGold,
              inactiveColor: AppColors.componentDark,
              onChanged: (value) => setState(() => _markup = value),
            ),
            const SizedBox(height: 16),

            // Percent to sell
            Text('Percent to Sell: ${_percentToSell.toStringAsFixed(0)}%',
                style: AppTextStyles.labelMedium),
            Slider(
              value: _percentToSell,
              min: 10,
              max: 100,
              divisions: 9,
              activeColor: AppColors.neonGold,
              inactiveColor: AppColors.componentDark,
              onChanged: (value) => setState(() => _percentToSell = value),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Action listed successfully!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'List Action for Sale',
                  style: AppTextStyles.buttonText.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StakingOffer {
  final String id;
  final _StakePlayer player;
  final String event;
  final int buyIn;
  final double markup;
  final int availablePercent;
  final int soldPercent;
  final DateTime eventDate;

  _StakingOffer({
    required this.id,
    required this.player,
    required this.event,
    required this.buyIn,
    required this.markup,
    required this.availablePercent,
    required this.soldPercent,
    required this.eventDate,
  });
}

class _StakePlayer {
  final String name;
  final Color avatarColor;
  final double rating;
  final int completedStakes;
  final double roi;
  final bool isVerified;

  _StakePlayer({
    required this.name,
    required this.avatarColor,
    required this.rating,
    required this.completedStakes,
    required this.roi,
    this.isVerified = false,
  });
}
