import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String _selectedPeriod = 'All Time';
  String _selectedGameType = 'All';

  // Mock statistics data
  final _StatsData _stats = _StatsData(
    totalProfit: 42580.00,
    totalSessions: 156,
    totalHours: 847,
    roi: 28.5,
    itmPercent: 34.2,
    hourlyRate: 50.27,
    avgBuyIn: 485.00,
    avgProfit: 273.08,
    biggestWin: 25000.00,
    biggestLoss: -3200.00,
    winRate: 58.3,
    avgDuration: 5.4,
    cashProfit: 18420.00,
    tournamentProfit: 24160.00,
    cashSessions: 89,
    tournamentSessions: 67,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.backgroundDark,
            title: Row(
              children: [
                Text('Statistics', style: AppTextStyles.heading2),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.file_download_outlined,
                      color: AppColors.neonGold),
                  onPressed: () => _showExportOptions(context),
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
                  // Period & Filter Row
                  Row(
                    children: [
                      Expanded(
                        child: _FilterDropdown(
                          label: 'Period',
                          value: _selectedPeriod,
                          items: const [
                            'All Time',
                            'This Month',
                            'Last 30 Days',
                            'Last 90 Days',
                            'This Year'
                          ],
                          onChanged: (v) =>
                              setState(() => _selectedPeriod = v!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _FilterDropdown(
                          label: 'Game Type',
                          value: _selectedGameType,
                          items: const ['All', 'Cash', 'Tournament'],
                          onChanged: (v) =>
                              setState(() => _selectedGameType = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Main Stats Card
                  _MainStatsCard(stats: _stats),
                  const SizedBox(height: 24),

                  // Key Metrics Grid
                  Text('Key Metrics', style: AppTextStyles.heading3),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      _MetricCard(
                        icon: Icons.percent,
                        label: 'ROI',
                        value: '${_stats.roi.toStringAsFixed(1)}%',
                        trend: _stats.roi >= 0,
                      ),
                      _MetricCard(
                        icon: Icons.emoji_events,
                        label: 'ITM %',
                        value: '${_stats.itmPercent.toStringAsFixed(1)}%',
                        subtitle: 'In the money',
                      ),
                      _MetricCard(
                        icon: Icons.schedule,
                        label: 'Hourly Rate',
                        value: '\$${_stats.hourlyRate.toStringAsFixed(2)}',
                        trend: _stats.hourlyRate >= 0,
                      ),
                      _MetricCard(
                        icon: Icons.trending_up,
                        label: 'Win Rate',
                        value: '${_stats.winRate.toStringAsFixed(1)}%',
                        subtitle: 'of sessions',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Game Type Breakdown
                  Text('Game Type Breakdown', style: AppTextStyles.heading3),
                  const SizedBox(height: 12),
                  _GameTypeBreakdown(stats: _stats),
                  const SizedBox(height: 24),

                  // Performance Extremes
                  Text('Performance', style: AppTextStyles.heading3),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _ExtremeCard(
                          label: 'Biggest Win',
                          value: '\$${_stats.biggestWin.toStringAsFixed(0)}',
                          icon: Icons.arrow_upward,
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ExtremeCard(
                          label: 'Biggest Loss',
                          value: '\$${_stats.biggestLoss.abs().toStringAsFixed(0)}',
                          icon: Icons.arrow_downward,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Session Stats
                  Text('Session Stats', style: AppTextStyles.heading3),
                  const SizedBox(height: 12),
                  _SessionStatsCard(stats: _stats),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Export Data', style: AppTextStyles.heading3),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.table_chart, color: AppColors.neonGold),
                title: const Text('Export as CSV'),
                subtitle: const Text('Spreadsheet format'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Export CSV
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: AppColors.error),
                title: const Text('Export as PDF'),
                subtitle: const Text('Report format'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Export PDF
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.charcoal,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, style: AppTextStyles.bodyMedium),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _MainStatsCard extends StatelessWidget {
  final _StatsData stats;

  const _MainStatsCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1D23),
            Color(0xFF14171B),
          ],
        ),
        border: Border.all(color: AppColors.neonGold.withOpacity(0.3)),
        boxShadow: [AppColors.glowShadow(blur: 24, opacity: 0.2)],
      ),
      child: Column(
        children: [
          Text(
            'Total Profit',
            style: AppTextStyles.labelMedium,
          ),
          const SizedBox(height: 8),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: AppColors.neonGradient,
            ).createShader(bounds),
            child: Text(
              '\$${stats.totalProfit.toStringAsFixed(0)}',
              style: AppTextStyles.heading1.copyWith(
                fontSize: 42,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _MiniStat(
                label: 'Sessions',
                value: stats.totalSessions.toString(),
              ),
              _MiniStat(
                label: 'Hours',
                value: stats.totalHours.toString(),
              ),
              _MiniStat(
                label: 'Avg Profit',
                value: '\$${stats.avgProfit.toStringAsFixed(0)}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.heading4),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;
  final bool? trend;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
    this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.neonGold),
              const Spacer(),
              if (trend != null)
                Icon(
                  trend! ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                  color: trend! ? AppColors.success : AppColors.error,
                ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: trend != null
                  ? (trend! ? AppColors.success : AppColors.error)
                  : AppColors.textLight,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle ?? label,
            style: AppTextStyles.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _GameTypeBreakdown extends StatelessWidget {
  final _StatsData stats;

  const _GameTypeBreakdown({required this.stats});

  @override
  Widget build(BuildContext context) {
    final total = stats.cashProfit + stats.tournamentProfit;
    final cashPercent = total > 0 ? (stats.cashProfit / total) : 0.5;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _GameTypeItem(
                  label: 'Cash Games',
                  profit: stats.cashProfit,
                  sessions: stats.cashSessions,
                  color: AppColors.info,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _GameTypeItem(
                  label: 'Tournaments',
                  profit: stats.tournamentProfit,
                  sessions: stats.tournamentSessions,
                  color: AppColors.neonGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Row(
              children: [
                Expanded(
                  flex: (cashPercent * 100).round(),
                  child: Container(
                    height: 8,
                    color: AppColors.info,
                  ),
                ),
                Expanded(
                  flex: ((1 - cashPercent) * 100).round(),
                  child: Container(
                    height: 8,
                    color: AppColors.neonGold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GameTypeItem extends StatelessWidget {
  final String label;
  final double profit;
  final int sessions;
  final Color color;

  const _GameTypeItem({
    required this.label,
    required this.profit,
    required this.sessions,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(label, style: AppTextStyles.labelMedium),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '\$${profit.toStringAsFixed(0)}',
          style: AppTextStyles.heading4.copyWith(
            color: profit >= 0 ? AppColors.success : AppColors.error,
          ),
        ),
        Text(
          '$sessions sessions',
          style: AppTextStyles.labelSmall,
        ),
      ],
    );
  }
}

class _ExtremeCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _ExtremeCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.heading4.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionStatsCard extends StatelessWidget {
  final _StatsData stats;

  const _SessionStatsCard({required this.stats});

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
        children: [
          _SessionStatRow(
            label: 'Average Buy-in',
            value: '\$${stats.avgBuyIn.toStringAsFixed(0)}',
          ),
          const Divider(color: AppColors.borderSubtle, height: 24),
          _SessionStatRow(
            label: 'Average Session Duration',
            value: '${stats.avgDuration.toStringAsFixed(1)} hours',
          ),
          const Divider(color: AppColors.borderSubtle, height: 24),
          _SessionStatRow(
            label: 'Total Hours Played',
            value: '${stats.totalHours} hours',
          ),
        ],
      ),
    );
  }
}

class _SessionStatRow extends StatelessWidget {
  final String label;
  final String value;

  const _SessionStatRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.neonGold,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _StatsData {
  final double totalProfit;
  final int totalSessions;
  final int totalHours;
  final double roi;
  final double itmPercent;
  final double hourlyRate;
  final double avgBuyIn;
  final double avgProfit;
  final double biggestWin;
  final double biggestLoss;
  final double winRate;
  final double avgDuration;
  final double cashProfit;
  final double tournamentProfit;
  final int cashSessions;
  final int tournamentSessions;

  _StatsData({
    required this.totalProfit,
    required this.totalSessions,
    required this.totalHours,
    required this.roi,
    required this.itmPercent,
    required this.hourlyRate,
    required this.avgBuyIn,
    required this.avgProfit,
    required this.biggestWin,
    required this.biggestLoss,
    required this.winRate,
    required this.avgDuration,
    required this.cashProfit,
    required this.tournamentProfit,
    required this.cashSessions,
    required this.tournamentSessions,
  });
}

/// Embeddable content version for use in tab views
class StatisticsContent extends StatefulWidget {
  const StatisticsContent({super.key});

  @override
  State<StatisticsContent> createState() => _StatisticsContentState();
}

class _StatisticsContentState extends State<StatisticsContent> {
  String _selectedPeriod = 'All Time';
  String _selectedGameType = 'All';

  final _StatsData _stats = _StatsData(
    totalProfit: 42580.00,
    totalSessions: 156,
    totalHours: 847,
    roi: 28.5,
    itmPercent: 34.2,
    hourlyRate: 50.27,
    avgBuyIn: 485.00,
    avgProfit: 273.08,
    biggestWin: 25000.00,
    biggestLoss: -3200.00,
    winRate: 58.3,
    avgDuration: 5.4,
    cashProfit: 18420.00,
    tournamentProfit: 24160.00,
    cashSessions: 89,
    tournamentSessions: 67,
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Export button row
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () => _showExportOptions(context),
              icon: const Icon(Icons.file_download_outlined, color: AppColors.neonGold, size: 20),
              label: Text(
                'Export',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.neonGold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Period & Filter Row
        Row(
          children: [
            Expanded(
              child: _FilterDropdown(
                label: 'Period',
                value: _selectedPeriod,
                items: const [
                  'All Time',
                  'This Month',
                  'Last 30 Days',
                  'Last 90 Days',
                  'This Year'
                ],
                onChanged: (v) => setState(() => _selectedPeriod = v!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FilterDropdown(
                label: 'Game Type',
                value: _selectedGameType,
                items: const ['All', 'Cash', 'Tournament'],
                onChanged: (v) => setState(() => _selectedGameType = v!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Main Stats Card
        _MainStatsCard(stats: _stats),
        const SizedBox(height: 24),

        // Key Metrics Grid
        Text('Key Metrics', style: AppTextStyles.heading3),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _MetricCard(
              icon: Icons.percent,
              label: 'ROI',
              value: '${_stats.roi.toStringAsFixed(1)}%',
              trend: _stats.roi >= 0,
            ),
            _MetricCard(
              icon: Icons.emoji_events,
              label: 'ITM %',
              value: '${_stats.itmPercent.toStringAsFixed(1)}%',
              subtitle: 'In the money',
            ),
            _MetricCard(
              icon: Icons.schedule,
              label: 'Hourly Rate',
              value: '\$${_stats.hourlyRate.toStringAsFixed(2)}',
              trend: _stats.hourlyRate >= 0,
            ),
            _MetricCard(
              icon: Icons.trending_up,
              label: 'Win Rate',
              value: '${_stats.winRate.toStringAsFixed(1)}%',
              subtitle: 'of sessions',
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Game Type Breakdown
        Text('Game Type Breakdown', style: AppTextStyles.heading3),
        const SizedBox(height: 12),
        _GameTypeBreakdown(stats: _stats),
        const SizedBox(height: 24),

        // Performance Extremes
        Text('Performance', style: AppTextStyles.heading3),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ExtremeCard(
                label: 'Biggest Win',
                value: '\$${_stats.biggestWin.toStringAsFixed(0)}',
                icon: Icons.arrow_upward,
                color: AppColors.success,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ExtremeCard(
                label: 'Biggest Loss',
                value: '\$${_stats.biggestLoss.abs().toStringAsFixed(0)}',
                icon: Icons.arrow_downward,
                color: AppColors.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Session Stats
        Text('Session Stats', style: AppTextStyles.heading3),
        const SizedBox(height: 12),
        _SessionStatsCard(stats: _stats),
        const SizedBox(height: 32),
      ],
    );
  }

  void _showExportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Export Data', style: AppTextStyles.heading3),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.table_chart, color: AppColors.neonGold),
                title: const Text('Export as CSV'),
                subtitle: const Text('Spreadsheet format'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: AppColors.error),
                title: const Text('Export as PDF'),
                subtitle: const Text('Report format'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
