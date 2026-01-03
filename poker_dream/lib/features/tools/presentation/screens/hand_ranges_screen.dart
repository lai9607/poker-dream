import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class HandRangesScreen extends StatefulWidget {
  const HandRangesScreen({super.key});

  @override
  State<HandRangesScreen> createState() => _HandRangesScreenState();
}

class _HandRangesScreenState extends State<HandRangesScreen> {
  // 13x13 matrix: [row][col] where row is first card, col is second card
  // Upper triangle (row < col) = suited, Lower triangle = offsuit, Diagonal = pairs
  final List<List<bool>> _selected = List.generate(
    13,
    (_) => List.generate(13, (_) => false),
  );

  String _currentRangeName = 'UTG Open';
  double _rangePercentage = 0;

  // Card ranks from Ace to Deuce
  static const List<String> _ranks = [
    'A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'
  ];

  // Preset ranges
  final Map<String, List<String>> _presets = {
    'UTG Open': ['AA', 'KK', 'QQ', 'JJ', 'TT', '99', 'AKs', 'AKo', 'AQs', 'AJs', 'KQs'],
    'BTN Open': [
      'AA', 'KK', 'QQ', 'JJ', 'TT', '99', '88', '77', '66', '55', '44', '33', '22',
      'AKs', 'AQs', 'AJs', 'ATs', 'A9s', 'A8s', 'A7s', 'A6s', 'A5s', 'A4s', 'A3s', 'A2s',
      'KQs', 'KJs', 'KTs', 'K9s', 'K8s',
      'QJs', 'QTs', 'Q9s',
      'JTs', 'J9s',
      'T9s', 'T8s',
      '98s', '97s',
      '87s', '86s',
      '76s', '75s',
      '65s', '64s',
      '54s',
      'AKo', 'AQo', 'AJo', 'ATo', 'A9o',
      'KQo', 'KJo', 'KTo',
      'QJo', 'QTo',
      'JTo',
    ],
    'BB Defense': ['AA', 'KK', 'QQ', 'JJ', 'TT', '99', '88', '77', '66', '55', '44', '33', '22',
      'AKs', 'AQs', 'AJs', 'ATs', 'A9s', 'A8s', 'A7s', 'A6s', 'A5s', 'A4s', 'A3s', 'A2s',
      'KQs', 'KJs', 'KTs', 'K9s', 'K8s', 'K7s', 'K6s', 'K5s', 'K4s',
      'QJs', 'QTs', 'Q9s', 'Q8s',
      'JTs', 'J9s', 'J8s',
      'T9s', 'T8s',
      '98s', '97s',
      '87s', '86s',
      '76s', '75s',
      '65s', '64s',
      '54s', '53s',
      '43s',
      'AKo', 'AQo', 'AJo', 'ATo', 'A9o', 'A8o',
      'KQo', 'KJo', 'KTo', 'K9o',
      'QJo', 'QTo',
      'JTo', 'J9o',
      'T9o',
    ],
    'Clear All': [],
  };

  @override
  void initState() {
    super.initState();
    _loadPreset('UTG Open');
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text('Hand Ranges', style: AppTextStyles.heading2),
            actions: [
              IconButton(
                icon: const Icon(Icons.save_outlined, color: AppColors.neonGold),
                onPressed: () => _showSaveDialog(context),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: AppColors.textMuted),
                onPressed: () => _shareRange(),
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
                  // Range Info Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.componentDark,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_currentRangeName,
                                  style: AppTextStyles.heading4),
                              const SizedBox(height: 4),
                              Text(
                                '${_rangePercentage.toStringAsFixed(1)}% of hands',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.neonGold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _PercentageCircle(percentage: _rangePercentage),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Preset Buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _presets.keys.map((preset) {
                        final isSelected = preset == _currentRangeName;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => _loadPreset(preset),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.neonGold.withOpacity(0.2)
                                    : AppColors.componentDark,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.neonGold
                                      : AppColors.borderSubtle,
                                ),
                              ),
                              child: Text(
                                preset,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: isSelected
                                      ? AppColors.neonGold
                                      : AppColors.textMuted,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 13x13 Matrix
                  _HandMatrix(
                    selected: _selected,
                    onToggle: _toggleHand,
                  ),
                  const SizedBox(height: 16),

                  // Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LegendItem(color: AppColors.cerise, label: 'Suited'),
                      const SizedBox(width: 20),
                      _LegendItem(color: AppColors.neonGold, label: 'Pairs'),
                      const SizedBox(width: 20),
                      _LegendItem(color: AppColors.info, label: 'Offsuit'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Selected Hands Display
                  Text('Selected Hands', style: AppTextStyles.heading4),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.charcoal,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.borderSubtle),
                    ),
                    child: Text(
                      _getSelectedHandsString(),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontFamily: 'monospace',
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleHand(int row, int col) {
    setState(() {
      _selected[row][col] = !_selected[row][col];
      _updateRangePercentage();
      _currentRangeName = 'Custom';
    });
  }

  void _loadPreset(String presetName) {
    final hands = _presets[presetName] ?? [];

    // Clear all
    for (int i = 0; i < 13; i++) {
      for (int j = 0; j < 13; j++) {
        _selected[i][j] = false;
      }
    }

    // Set selected hands
    for (final hand in hands) {
      final indices = _parseHand(hand);
      if (indices != null) {
        _selected[indices[0]][indices[1]] = true;
      }
    }

    setState(() {
      _currentRangeName = presetName;
      _updateRangePercentage();
    });
  }

  List<int>? _parseHand(String hand) {
    if (hand.length < 2) return null;

    final rank1 = _ranks.indexOf(hand[0]);
    final rank2 = _ranks.indexOf(hand[1]);

    if (rank1 == -1 || rank2 == -1) return null;

    // Pair
    if (rank1 == rank2) {
      return [rank1, rank2];
    }

    // Suited (upper triangle)
    if (hand.length >= 3 && hand[2] == 's') {
      return [rank1.compareTo(rank2) < 0 ? rank1 : rank2,
              rank1.compareTo(rank2) < 0 ? rank2 : rank1];
    }

    // Offsuit (lower triangle)
    return [rank1.compareTo(rank2) < 0 ? rank2 : rank1,
            rank1.compareTo(rank2) < 0 ? rank1 : rank2];
  }

  void _updateRangePercentage() {
    int totalCombos = 0;
    int selectedCombos = 0;

    for (int row = 0; row < 13; row++) {
      for (int col = 0; col < 13; col++) {
        final combos = _getCombos(row, col);
        totalCombos += combos;
        if (_selected[row][col]) {
          selectedCombos += combos;
        }
      }
    }

    _rangePercentage = totalCombos > 0 ? (selectedCombos / 1326 * 100) : 0;
  }

  int _getCombos(int row, int col) {
    if (row == col) return 6; // Pairs
    if (row < col) return 4; // Suited
    return 12; // Offsuit
  }

  String _getSelectedHandsString() {
    final hands = <String>[];

    for (int row = 0; row < 13; row++) {
      for (int col = 0; col < 13; col++) {
        if (_selected[row][col]) {
          final hand = _getHandNotation(row, col);
          hands.add(hand);
        }
      }
    }

    if (hands.isEmpty) return 'No hands selected';
    return hands.join(', ');
  }

  String _getHandNotation(int row, int col) {
    if (row == col) {
      return '${_ranks[row]}${_ranks[col]}';
    } else if (row < col) {
      return '${_ranks[row]}${_ranks[col]}s';
    } else {
      return '${_ranks[col]}${_ranks[row]}o';
    }
  }

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.charcoal,
        title: Text('Save Range', style: AppTextStyles.heading4),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Range name',
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
            onPressed: () {
              Navigator.pop(context);
              // TODO: Save range
            },
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

  void _shareRange() {
    // TODO: Share range
  }
}

class _HandMatrix extends StatelessWidget {
  final List<List<bool>> selected;
  final Function(int row, int col) onToggle;

  const _HandMatrix({
    required this.selected,
    required this.onToggle,
  });

  static const List<String> _ranks = [
    'A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 13,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemCount: 169,
          itemBuilder: (context, index) {
            final row = index ~/ 13;
            final col = index % 13;
            final isSelected = selected[row][col];

            Color cellColor;
            if (row == col) {
              cellColor = isSelected
                  ? AppColors.neonGold
                  : AppColors.neonGold.withOpacity(0.1);
            } else if (row < col) {
              cellColor = isSelected
                  ? AppColors.cerise
                  : AppColors.cerise.withOpacity(0.1);
            } else {
              cellColor = isSelected
                  ? AppColors.info
                  : AppColors.info.withOpacity(0.1);
            }

            return GestureDetector(
              onTap: () => onToggle(row, col),
              child: Container(
                decoration: BoxDecoration(
                  color: cellColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Text(
                        _getCellLabel(row, col),
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getCellLabel(int row, int col) {
    if (row == col) {
      return '${_ranks[row]}${_ranks[col]}';
    } else if (row < col) {
      return '${_ranks[row]}${_ranks[col]}s';
    } else {
      return '${_ranks[col]}${_ranks[row]}o';
    }
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class _PercentageCircle extends StatelessWidget {
  final double percentage;

  const _PercentageCircle({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: percentage / 100,
            strokeWidth: 5,
            backgroundColor: AppColors.componentDark,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.neonGold),
          ),
          Center(
            child: Text(
              '${percentage.toStringAsFixed(0)}%',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
