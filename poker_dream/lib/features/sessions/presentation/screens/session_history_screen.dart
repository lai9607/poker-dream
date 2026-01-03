import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';

class SessionHistoryScreen extends StatefulWidget {
  const SessionHistoryScreen({super.key});

  @override
  State<SessionHistoryScreen> createState() => _SessionHistoryScreenState();
}

class _SessionHistoryScreenState extends State<SessionHistoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Cash', 'Tournament'];

  // Mock data
  final List<_Session> _sessions = [
    _Session(
      id: '1',
      type: SessionType.tournament,
      venue: 'WSOP Main Event',
      buyIn: 10000,
      cashOut: 25000,
      duration: const Duration(hours: 12, minutes: 30),
      date: DateTime.now().subtract(const Duration(days: 1)),
      position: 145,
      entries: 8500,
    ),
    _Session(
      id: '2',
      type: SessionType.cash,
      venue: 'Aria 5/10 NLH',
      buyIn: 3000,
      cashOut: 4850,
      duration: const Duration(hours: 6, minutes: 15),
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    _Session(
      id: '3',
      type: SessionType.tournament,
      venue: 'Venetian \$600 Daily',
      buyIn: 600,
      cashOut: 0,
      duration: const Duration(hours: 4, minutes: 45),
      date: DateTime.now().subtract(const Duration(days: 3)),
      position: 89,
      entries: 245,
    ),
    _Session(
      id: '4',
      type: SessionType.cash,
      venue: 'Bellagio 2/5 NLH',
      buyIn: 1000,
      cashOut: 650,
      duration: const Duration(hours: 3, minutes: 20),
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    _Session(
      id: '5',
      type: SessionType.tournament,
      venue: 'Wynn \$1,600 Mystery Bounty',
      buyIn: 1600,
      cashOut: 8750,
      duration: const Duration(hours: 14),
      date: DateTime.now().subtract(const Duration(days: 6)),
      position: 12,
      entries: 1200,
    ),
    _Session(
      id: '6',
      type: SessionType.cash,
      venue: 'MGM 1/3 NLH',
      buyIn: 500,
      cashOut: 1120,
      duration: const Duration(hours: 5, minutes: 10),
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  List<_Session> get _filteredSessions {
    if (_selectedFilter == 'All') return _sessions;
    return _sessions.where((s) {
      if (_selectedFilter == 'Cash') return s.type == SessionType.cash;
      return s.type == SessionType.tournament;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalProfit = _filteredSessions.fold<double>(
      0,
      (sum, s) => sum + s.profit,
    );
    final winningCount = _filteredSessions.where((s) => s.profit > 0).length;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.backgroundDark,
            title: Row(
              children: [
                Text('Session History', style: AppTextStyles.heading2),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: AppColors.neonGold),
                  onPressed: () => _showAddSessionSheet(context),
                ),
              ],
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          label: 'Total Profit',
                          value: '\$${totalProfit.toStringAsFixed(0)}',
                          valueColor: totalProfit >= 0
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SummaryCard(
                          label: 'Win Rate',
                          value: '${((winningCount / _filteredSessions.length) * 100).toStringAsFixed(0)}%',
                          valueColor: AppColors.neonGold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Filter Chips
                  Row(
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
                  const SizedBox(height: 16),

                  // Sessions List
                  ..._filteredSessions.map((session) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _SessionCard(session: session),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddSessionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _AddSessionSheet(),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryCard({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.labelMedium,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.heading2.copyWith(
              color: valueColor ?? AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final _Session session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onTap: () => _showSessionDetails(context),
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
            Row(
              children: [
                // Type Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: session.type == SessionType.tournament
                        ? AppColors.neonGold.withOpacity(0.15)
                        : AppColors.info.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    session.type == SessionType.tournament ? 'MTT' : 'CASH',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: session.type == SessionType.tournament
                          ? AppColors.neonGold
                          : AppColors.info,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                // Profit/Loss
                Text(
                  '${session.profit >= 0 ? '+' : ''}\$${session.profit.toStringAsFixed(0)}',
                  style: AppTextStyles.heading4.copyWith(
                    color: session.profit >= 0
                        ? AppColors.success
                        : AppColors.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Venue
            Text(
              session.venue,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            // Details Row
            Row(
              children: [
                _DetailChip(
                  icon: Icons.attach_money,
                  label: 'Buy: \$${session.buyIn.toStringAsFixed(0)}',
                ),
                const SizedBox(width: 12),
                _DetailChip(
                  icon: Icons.timer_outlined,
                  label: _formatDuration(session.duration),
                ),
                if (session.position != null) ...[
                  const SizedBox(width: 12),
                  _DetailChip(
                    icon: Icons.leaderboard,
                    label: '${session.position}/${session.entries}',
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            // Date
            Text(
              _formatDate(session.date),
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0 && minutes > 0) return '${hours}h ${minutes}m';
    if (hours > 0) return '${hours}h';
    return '${minutes}m';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showSessionDetails(BuildContext context) {
    // TODO: Navigate to session details
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailChip({
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

class _AddSessionSheet extends StatefulWidget {
  const _AddSessionSheet();

  @override
  State<_AddSessionSheet> createState() => _AddSessionSheetState();
}

class _AddSessionSheetState extends State<_AddSessionSheet> {
  SessionType _selectedType = SessionType.cash;
  final _venueController = TextEditingController();
  final _buyInController = TextEditingController();
  final _cashOutController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int _hours = 0;
  int _minutes = 0;

  @override
  void dispose() {
    _venueController.dispose();
    _buyInController.dispose();
    _cashOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: AppColors.charcoal.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.borderGlow,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Log Session', style: AppTextStyles.heading3),
                const SizedBox(height: 20),

                // Type Selector
                Row(
                  children: SessionType.values.map((type) {
                    final isSelected = type == _selectedType;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedType = type),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.neonGold.withOpacity(0.15)
                                : AppColors.componentDark,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.neonGold
                                  : AppColors.borderSubtle,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              type == SessionType.cash ? 'Cash Game' : 'Tournament',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: isSelected
                                    ? AppColors.neonGold
                                    : AppColors.textMuted,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Venue Field
                TextField(
                  controller: _venueController,
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Venue / Event Name',
                    hintStyle: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textMuted,
                    ),
                    filled: true,
                    fillColor: AppColors.componentDark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.location_on,
                        color: AppColors.textMuted),
                  ),
                ),
                const SizedBox(height: 12),

                // Buy-in & Cash-out Row
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _buyInController,
                        keyboardType: TextInputType.number,
                        style: AppTextStyles.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Buy-in',
                          hintStyle: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textMuted,
                          ),
                          filled: true,
                          fillColor: AppColors.componentDark,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.arrow_upward,
                              color: AppColors.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _cashOutController,
                        keyboardType: TextInputType.number,
                        style: AppTextStyles.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Cash-out',
                          hintStyle: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textMuted,
                          ),
                          filled: true,
                          fillColor: AppColors.componentDark,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.arrow_downward,
                              color: AppColors.success),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Duration Row
                Row(
                  children: [
                    Expanded(
                      child: _DurationPicker(
                        label: 'Hours',
                        value: _hours,
                        maxValue: 24,
                        onChanged: (v) => setState(() => _hours = v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DurationPicker(
                        label: 'Minutes',
                        value: _minutes,
                        maxValue: 59,
                        onChanged: (v) => setState(() => _minutes = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Save session
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonGold,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Save Session',
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
        ),
      ),
    );
  }
}

class _DurationPicker extends StatelessWidget {
  final String label;
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const _DurationPicker({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                Text(
                  value.toString().padLeft(2, '0'),
                  style: AppTextStyles.heading4,
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (value < maxValue) onChanged(value + 1);
                },
                child: const Icon(Icons.keyboard_arrow_up,
                    color: AppColors.textMuted),
              ),
              GestureDetector(
                onTap: () {
                  if (value > 0) onChanged(value - 1);
                },
                child: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum SessionType { cash, tournament }

class _Session {
  final String id;
  final SessionType type;
  final String venue;
  final double buyIn;
  final double cashOut;
  final Duration duration;
  final DateTime date;
  final int? position;
  final int? entries;

  _Session({
    required this.id,
    required this.type,
    required this.venue,
    required this.buyIn,
    required this.cashOut,
    required this.duration,
    required this.date,
    this.position,
    this.entries,
  });

  double get profit => cashOut - buyIn;
}

/// Embeddable content version for use in tab views
class SessionsContent extends StatefulWidget {
  const SessionsContent({super.key});

  @override
  State<SessionsContent> createState() => _SessionsContentState();
}

class _SessionsContentState extends State<SessionsContent> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Cash', 'Tournament'];

  final List<_Session> _sessions = [
    _Session(
      id: '1',
      type: SessionType.tournament,
      venue: 'WSOP Main Event',
      buyIn: 10000,
      cashOut: 25000,
      duration: const Duration(hours: 12, minutes: 30),
      date: DateTime.now().subtract(const Duration(days: 1)),
      position: 145,
      entries: 8500,
    ),
    _Session(
      id: '2',
      type: SessionType.cash,
      venue: 'Aria 5/10 NLH',
      buyIn: 3000,
      cashOut: 4850,
      duration: const Duration(hours: 6, minutes: 15),
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    _Session(
      id: '3',
      type: SessionType.tournament,
      venue: 'Venetian \$600 Daily',
      buyIn: 600,
      cashOut: 0,
      duration: const Duration(hours: 4, minutes: 45),
      date: DateTime.now().subtract(const Duration(days: 3)),
      position: 89,
      entries: 245,
    ),
    _Session(
      id: '4',
      type: SessionType.cash,
      venue: 'Bellagio 2/5 NLH',
      buyIn: 1000,
      cashOut: 650,
      duration: const Duration(hours: 3, minutes: 20),
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    _Session(
      id: '5',
      type: SessionType.tournament,
      venue: 'Wynn \$1,600 Mystery Bounty',
      buyIn: 1600,
      cashOut: 8750,
      duration: const Duration(hours: 14),
      date: DateTime.now().subtract(const Duration(days: 6)),
      position: 12,
      entries: 1200,
    ),
    _Session(
      id: '6',
      type: SessionType.cash,
      venue: 'MGM 1/3 NLH',
      buyIn: 500,
      cashOut: 1120,
      duration: const Duration(hours: 5, minutes: 10),
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  List<_Session> get _filteredSessions {
    if (_selectedFilter == 'All') return _sessions;
    return _sessions.where((s) {
      if (_selectedFilter == 'Cash') return s.type == SessionType.cash;
      return s.type == SessionType.tournament;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalProfit = _filteredSessions.fold<double>(
      0,
      (sum, s) => sum + s.profit,
    );
    final winningCount = _filteredSessions.where((s) => s.profit > 0).length;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Add button row
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () => _showAddSessionSheet(context),
              icon: const Icon(Icons.add_circle_outline, color: AppColors.neonGold, size: 20),
              label: Text(
                'Log Session',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.neonGold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Summary Cards
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                label: 'Total Profit',
                value: '\$${totalProfit.toStringAsFixed(0)}',
                valueColor: totalProfit >= 0
                    ? AppColors.success
                    : AppColors.error,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                label: 'Win Rate',
                value: '${((winningCount / _filteredSessions.length) * 100).toStringAsFixed(0)}%',
                valueColor: AppColors.neonGold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Filter Chips
        Row(
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
        const SizedBox(height: 16),

        // Sessions List
        ..._filteredSessions.map((session) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _SessionCard(session: session),
            )),
      ],
    );
  }

  void _showAddSessionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _AddSessionSheet(),
    );
  }
}
