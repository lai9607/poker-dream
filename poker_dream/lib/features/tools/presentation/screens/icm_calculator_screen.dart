import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ICMCalculatorScreen extends StatefulWidget {
  const ICMCalculatorScreen({super.key});

  @override
  State<ICMCalculatorScreen> createState() => _ICMCalculatorScreenState();
}

class _ICMCalculatorScreenState extends State<ICMCalculatorScreen> {
  final List<_PlayerStack> _players = [
    _PlayerStack(name: 'Player 1', chips: 500000),
    _PlayerStack(name: 'Player 2', chips: 350000),
    _PlayerStack(name: 'Player 3', chips: 200000),
    _PlayerStack(name: 'Player 4', chips: 150000),
  ];

  final List<double> _payouts = [50000, 30000, 20000, 15000];

  bool _isCalculated = false;
  List<double> _icmValues = [];

  @override
  Widget build(BuildContext context) {
    final totalChips = _players.fold<int>(0, (sum, p) => sum + p.chips);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.backgroundDark,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('ICM Calculator', style: AppTextStyles.heading2),
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline, color: AppColors.textMuted),
                onPressed: () => _showHelp(context),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total Chips Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.componentDark,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.casino, color: AppColors.neonGold, size: 28),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Chips', style: AppTextStyles.labelMedium),
                            Text(
                              _formatNumber(totalChips),
                              style: AppTextStyles.heading3.copyWith(
                                color: AppColors.neonGold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Players', style: AppTextStyles.labelMedium),
                            Text(
                              '${_players.length}',
                              style: AppTextStyles.heading3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payouts Section
                  Row(
                    children: [
                      Text('Payout Structure', style: AppTextStyles.heading4),
                      const Spacer(),
                      TextButton.icon(
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Edit'),
                        onPressed: () => _showPayoutEditor(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.charcoal,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(_payouts.length, (index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getPositionColor(index).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${index + 1}${_getOrdinal(index + 1)}',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: _getPositionColor(index),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${_formatNumber(_payouts[index].toInt())}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Player Stacks Section
                  Row(
                    children: [
                      Text('Player Stacks', style: AppTextStyles.heading4),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.add_circle,
                            color: AppColors.neonGold),
                        onPressed: () => _addPlayer(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Player Cards
                  ...List.generate(_players.length, (index) {
                    final player = _players[index];
                    final percentage = totalChips > 0
                        ? (player.chips / totalChips * 100)
                        : 0.0;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _PlayerStackCard(
                        player: player,
                        index: index,
                        percentage: percentage,
                        icmValue: _isCalculated && index < _icmValues.length
                            ? _icmValues[index]
                            : null,
                        onChipsChanged: (chips) {
                          setState(() {
                            _players[index] = _PlayerStack(
                              name: player.name,
                              chips: chips,
                            );
                            _isCalculated = false;
                          });
                        },
                        onRemove: _players.length > 2
                            ? () => setState(() {
                                  _players.removeAt(index);
                                  _isCalculated = false;
                                })
                            : null,
                      ),
                    );
                  }),

                  const SizedBox(height: 24),

                  // Calculate Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _calculateICM,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.neonGold,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calculate),
                          const SizedBox(width: 8),
                          Text(
                            'Calculate ICM',
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Results Section
                  if (_isCalculated) ...[
                    const SizedBox(height: 32),
                    _ResultsSection(
                      players: _players,
                      icmValues: _icmValues,
                      payouts: _payouts,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _calculateICM() {
    // Simple ICM approximation for demo purposes
    // In production, use proper Malmuth-Harville algorithm
    final totalChips = _players.fold<int>(0, (sum, p) => sum + p.chips);
    final totalPayout = _payouts.fold<double>(0, (sum, p) => sum + p);

    _icmValues = _players.map((player) {
      final chipPercentage = player.chips / totalChips;
      // Simplified ICM - actual calculation is more complex
      return totalPayout * chipPercentage * 0.85 +
          totalPayout * (1 - chipPercentage) * 0.15 / (_players.length - 1);
    }).toList();

    setState(() => _isCalculated = true);
  }

  void _addPlayer() {
    if (_players.length >= 9) return;
    setState(() {
      _players.add(_PlayerStack(
        name: 'Player ${_players.length + 1}',
        chips: 100000,
      ));
      _isCalculated = false;
    });
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  Color _getPositionColor(int index) {
    switch (index) {
      case 0:
        return AppColors.neonGold;
      case 1:
        return const Color(0xFFC0C0C0);
      case 2:
        return const Color(0xFFCD7F32);
      default:
        return AppColors.textMuted;
    }
  }

  String _getOrdinal(int number) {
    if (number >= 11 && number <= 13) return 'th';
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  void _showHelp(BuildContext context) {
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
              Text('What is ICM?', style: AppTextStyles.heading3),
              const SizedBox(height: 16),
              Text(
                'ICM (Independent Chip Model) calculates the monetary value of tournament chips based on the payout structure and remaining players.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Use this tool to:',
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _HelpItem('Calculate deal equity at final tables'),
              _HelpItem('Make better ICM-informed decisions'),
              _HelpItem('Negotiate fair chip chops'),
            ],
          ),
        ),
      ),
    );
  }

  void _showPayoutEditor(BuildContext context) {
    // TODO: Implement payout editor
  }
}

class _HelpItem extends StatelessWidget {
  final String text;

  const _HelpItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: AppColors.neonGold),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _PlayerStackCard extends StatelessWidget {
  final _PlayerStack player;
  final int index;
  final double percentage;
  final double? icmValue;
  final ValueChanged<int> onChipsChanged;
  final VoidCallback? onRemove;

  const _PlayerStackCard({
    required this.player,
    required this.index,
    required this.percentage,
    this.icmValue,
    required this.onChipsChanged,
    this.onRemove,
  });

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
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.neonGold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.neonGold,
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
                    Text(player.name, style: AppTextStyles.bodyMedium),
                    Text(
                      '${percentage.toStringAsFixed(1)}% of chips',
                      style: AppTextStyles.labelSmall,
                    ),
                  ],
                ),
              ),
              if (icmValue != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '\$${icmValue!.toStringAsFixed(0)}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (onRemove != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  color: AppColors.textMuted,
                  onPressed: onRemove,
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Chip slider
          Row(
            children: [
              Text(
                _formatNumber(player.chips),
                style: AppTextStyles.heading4.copyWith(
                  color: AppColors.neonGold,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.casino, size: 16, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.neonGold,
              inactiveTrackColor: AppColors.componentDark,
              thumbColor: AppColors.neonGold,
              overlayColor: AppColors.neonGold.withOpacity(0.2),
            ),
            child: Slider(
              value: player.chips.toDouble(),
              min: 0,
              max: 1000000,
              divisions: 100,
              onChanged: (value) => onChipsChanged(value.toInt()),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

class _ResultsSection extends StatelessWidget {
  final List<_PlayerStack> players;
  final List<double> icmValues;
  final List<double> payouts;

  const _ResultsSection({
    required this.players,
    required this.icmValues,
    required this.payouts,
  });

  @override
  Widget build(BuildContext context) {
    final totalChips = players.fold<int>(0, (sum, p) => sum + p.chips);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.neonGold.withOpacity(0.1),
            AppColors.cerise.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neonGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: AppColors.neonGold),
              const SizedBox(width: 8),
              Text('ICM Results', style: AppTextStyles.heading4),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(players.length, (index) {
            final player = players[index];
            final icm = index < icmValues.length ? icmValues[index] : 0.0;
            final chipEV = totalChips > 0
                ? payouts.reduce((a, b) => a + b) *
                    (player.chips / totalChips)
                : 0.0;
            final diff = icm - chipEV;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    player.name,
                    style: AppTextStyles.bodyMedium,
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${icm.toStringAsFixed(0)}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${diff >= 0 ? '+' : ''}\$${diff.toStringAsFixed(0)} vs chip EV',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: diff >= 0 ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PlayerStack {
  final String name;
  final int chips;

  _PlayerStack({
    required this.name,
    required this.chips,
  });
}
