import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class EquityCalculatorScreen extends StatefulWidget {
  const EquityCalculatorScreen({super.key});

  @override
  State<EquityCalculatorScreen> createState() => _EquityCalculatorScreenState();
}

class _EquityCalculatorScreenState extends State<EquityCalculatorScreen> {
  final List<_Hand> _hands = [
    _Hand(cards: ['As', 'Ah']),
    _Hand(cards: ['Ks', 'Kh']),
  ];

  final List<String> _board = [];
  bool _isCalculating = false;
  List<double> _equities = [];

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
            title: Text('Equity Calculator', style: AppTextStyles.heading2),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: AppColors.textMuted),
                onPressed: _resetCalculator,
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
                  // Board Section
                  Text('Board', style: AppTextStyles.heading4),
                  const SizedBox(height: 12),
                  _BoardSection(
                    board: _board,
                    onCardTap: (index) => _showCardPicker(context, 'board', index),
                    onAddCard: _board.length < 5
                        ? () => _showCardPicker(context, 'board', _board.length)
                        : null,
                  ),
                  const SizedBox(height: 24),

                  // Hands Section
                  Row(
                    children: [
                      Text('Hands', style: AppTextStyles.heading4),
                      const Spacer(),
                      if (_hands.length < 6)
                        TextButton.icon(
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add Hand'),
                          onPressed: _addHand,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Hand Cards
                  ...List.generate(_hands.length, (index) {
                    final hand = _hands[index];
                    final equity = index < _equities.length ? _equities[index] : null;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _HandRow(
                        hand: hand,
                        index: index,
                        equity: equity,
                        onCardTap: (cardIndex) =>
                            _showCardPicker(context, 'hand_$index', cardIndex),
                        onRemove: _hands.length > 2
                            ? () => setState(() {
                                  _hands.removeAt(index);
                                  _equities = [];
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
                      onPressed: _isCalculating ? null : _calculateEquity,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.neonGold,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _isCalculating
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.calculate),
                                const SizedBox(width: 8),
                                Text(
                                  'Calculate Equity',
                                  style: AppTextStyles.buttonText.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  // Results
                  if (_equities.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _ResultsSection(
                      hands: _hands,
                      equities: _equities,
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Quick Scenarios
                  Text('Quick Scenarios', style: AppTextStyles.heading4),
                  const SizedBox(height: 12),
                  _QuickScenarios(onSelect: _loadScenario),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addHand() {
    setState(() {
      _hands.add(_Hand(cards: ['?', '?']));
      _equities = [];
    });
  }

  void _calculateEquity() async {
    // Check if all hands have valid cards
    for (final hand in _hands) {
      if (hand.cards.any((c) => c == '?')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select all cards first')),
        );
        return;
      }
    }

    setState(() => _isCalculating = true);

    // Simulate calculation delay (in production, use proper equity calculation)
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock equity calculation based on hand strength
    final equities = <double>[];
    double totalEquity = 0;

    for (final hand in _hands) {
      final strength = _getHandStrength(hand.cards);
      equities.add(strength);
      totalEquity += strength;
    }

    // Normalize to 100%
    for (int i = 0; i < equities.length; i++) {
      equities[i] = (equities[i] / totalEquity) * 100;
    }

    setState(() {
      _equities = equities;
      _isCalculating = false;
    });
  }

  double _getHandStrength(List<String> cards) {
    // Simple mock hand strength calculation
    // In production, use proper poker equity calculator
    final ranks = {
      'A': 14, 'K': 13, 'Q': 12, 'J': 11, 'T': 10,
      '9': 9, '8': 8, '7': 7, '6': 6, '5': 5, '4': 4, '3': 3, '2': 2,
    };

    final rank1 = ranks[cards[0][0]] ?? 0;
    final rank2 = ranks[cards[1][0]] ?? 0;
    final suited = cards[0].length > 1 && cards[1].length > 1 &&
        cards[0][1] == cards[1][1];
    final paired = rank1 == rank2;

    double strength = (rank1 + rank2).toDouble();
    if (paired) strength *= 2;
    if (suited) strength *= 1.2;

    // Add some randomness for realism
    return strength + (math.Random().nextDouble() * 5);
  }

  void _resetCalculator() {
    setState(() {
      _hands.clear();
      _hands.addAll([
        _Hand(cards: ['?', '?']),
        _Hand(cards: ['?', '?']),
      ]);
      _board.clear();
      _equities = [];
    });
  }

  void _showCardPicker(BuildContext context, String target, int cardIndex) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _CardPickerSheet(
        onSelect: (card) {
          Navigator.pop(context);
          _setCard(target, cardIndex, card);
        },
        usedCards: _getUsedCards(),
      ),
    );
  }

  List<String> _getUsedCards() {
    final used = <String>[];
    for (final hand in _hands) {
      for (final card in hand.cards) {
        if (card != '?') used.add(card);
      }
    }
    used.addAll(_board);
    return used;
  }

  void _setCard(String target, int cardIndex, String card) {
    setState(() {
      if (target == 'board') {
        if (cardIndex < _board.length) {
          _board[cardIndex] = card;
        } else {
          _board.add(card);
        }
      } else if (target.startsWith('hand_')) {
        final handIndex = int.parse(target.substring(5));
        _hands[handIndex].cards[cardIndex] = card;
      }
      _equities = [];
    });
  }

  void _loadScenario(_Scenario scenario) {
    setState(() {
      _hands.clear();
      _hands.addAll(scenario.hands.map((h) => _Hand(cards: List.from(h))));
      _board.clear();
      _board.addAll(scenario.board);
      _equities = [];
    });
    _calculateEquity();
  }
}

class _BoardSection extends StatelessWidget {
  final List<String> board;
  final Function(int) onCardTap;
  final VoidCallback? onAddCard;

  const _BoardSection({
    required this.board,
    required this.onCardTap,
    this.onAddCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A472A), // Green felt color
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(5, (index) {
            if (index < board.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _CardWidget(
                  card: board[index],
                  onTap: () => onCardTap(index),
                ),
              );
            } else if (index == board.length && onAddCard != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _AddCardButton(onTap: onAddCard!),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _EmptyCardSlot(),
              );
            }
          }),
        ],
      ),
    );
  }
}

class _HandRow extends StatelessWidget {
  final _Hand hand;
  final int index;
  final double? equity;
  final Function(int) onCardTap;
  final VoidCallback? onRemove;

  const _HandRow({
    required this.hand,
    required this.index,
    this.equity,
    required this.onCardTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: equity != null && equity! > 50
              ? AppColors.success.withOpacity(0.5)
              : AppColors.borderSubtle,
        ),
      ),
      child: Row(
        children: [
          // Hand label
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getPlayerColor(index).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: AppTextStyles.labelMedium.copyWith(
                  color: _getPlayerColor(index),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Cards
          _CardWidget(
            card: hand.cards[0],
            onTap: () => onCardTap(0),
          ),
          const SizedBox(width: 6),
          _CardWidget(
            card: hand.cards[1],
            onTap: () => onCardTap(1),
          ),

          const Spacer(),

          // Equity
          if (equity != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: equity! > 50
                    ? AppColors.success.withOpacity(0.2)
                    : AppColors.componentDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${equity!.toStringAsFixed(1)}%',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: equity! > 50 ? AppColors.success : AppColors.textLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          // Remove button
          if (onRemove != null)
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              color: AppColors.textMuted,
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }

  Color _getPlayerColor(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    return colors[index % colors.length];
  }
}

class _CardWidget extends StatelessWidget {
  final String card;
  final VoidCallback onTap;

  const _CardWidget({
    required this.card,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPlaceholder = card == '?';
    final suit = !isPlaceholder && card.length > 1 ? card[1] : '';
    final rank = !isPlaceholder ? card[0] : '?';

    Color suitColor;
    String suitSymbol;
    switch (suit) {
      case 's':
        suitColor = Colors.black;
        suitSymbol = '♠';
        break;
      case 'h':
        suitColor = Colors.red;
        suitSymbol = '♥';
        break;
      case 'd':
        suitColor = Colors.blue;
        suitSymbol = '♦';
        break;
      case 'c':
        suitColor = Colors.green;
        suitSymbol = '♣';
        break;
      default:
        suitColor = AppColors.textMuted;
        suitSymbol = '';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 60,
        decoration: BoxDecoration(
          color: isPlaceholder ? AppColors.componentDark : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPlaceholder ? AppColors.borderSubtle : Colors.grey.shade300,
          ),
          boxShadow: isPlaceholder
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              rank,
              style: TextStyle(
                color: isPlaceholder ? AppColors.textMuted : suitColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (!isPlaceholder)
              Text(
                suitSymbol,
                style: TextStyle(
                  color: suitColor,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddCardButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddCardButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.neonGold.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neonGold),
        ),
        child: const Icon(Icons.add, color: AppColors.neonGold),
      ),
    );
  }
}

class _EmptyCardSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.borderSubtle,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}

class _ResultsSection extends StatelessWidget {
  final List<_Hand> hands;
  final List<double> equities;

  const _ResultsSection({
    required this.hands,
    required this.equities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
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
              Text('Results', style: AppTextStyles.heading4),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(hands.length, (index) {
            final equity = equities[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hand ${index + 1}: ${hands[index].cards.join(' ')}',
                        style: AppTextStyles.bodyMedium,
                      ),
                      const Spacer(),
                      Text(
                        '${equity.toStringAsFixed(1)}%',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: equity > 50 ? AppColors.success : AppColors.textMuted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: equity / 100,
                      backgroundColor: AppColors.componentDark,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        equity > 50 ? AppColors.success : AppColors.textMuted,
                      ),
                      minHeight: 8,
                    ),
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

class _QuickScenarios extends StatelessWidget {
  final Function(_Scenario) onSelect;

  const _QuickScenarios({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final scenarios = [
      _Scenario(
        name: 'AA vs KK',
        hands: [['As', 'Ah'], ['Ks', 'Kh']],
        board: [],
      ),
      _Scenario(
        name: 'AK vs QQ',
        hands: [['As', 'Kh'], ['Qs', 'Qh']],
        board: [],
      ),
      _Scenario(
        name: 'Flush Draw',
        hands: [['As', 'Ks'], ['Qh', 'Qd']],
        board: ['Ts', '7s', '2h'],
      ),
      _Scenario(
        name: 'Set vs Flush',
        hands: [['7h', '7d'], ['As', 'Ks']],
        board: ['7s', '4s', '2s'],
      ),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: scenarios.map((scenario) {
        return GestureDetector(
          onTap: () => onSelect(scenario),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.componentDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Text(
              scenario.name,
              style: AppTextStyles.labelMedium,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _CardPickerSheet extends StatelessWidget {
  final Function(String) onSelect;
  final List<String> usedCards;

  const _CardPickerSheet({
    required this.onSelect,
    required this.usedCards,
  });

  @override
  Widget build(BuildContext context) {
    final ranks = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'];
    final suits = ['s', 'h', 'd', 'c'];
    final suitSymbols = {'s': '♠', 'h': '♥', 'd': '♦', 'c': '♣'};
    final suitColors = {'s': Colors.black, 'h': Colors.red, 'd': Colors.blue, 'c': Colors.green};

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Card', style: AppTextStyles.heading4),
            const SizedBox(height: 16),
            ...suits.map((suit) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ranks.map((rank) {
                    final card = '$rank$suit';
                    final isUsed = usedCards.contains(card);

                    return GestureDetector(
                      onTap: isUsed ? null : () => onSelect(card),
                      child: Container(
                        width: 24,
                        height: 34,
                        decoration: BoxDecoration(
                          color: isUsed ? AppColors.componentDark : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: isUsed ? AppColors.borderSubtle : Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              rank,
                              style: TextStyle(
                                color: isUsed ? AppColors.textMuted : suitColors[suit],
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              suitSymbols[suit]!,
                              style: TextStyle(
                                color: isUsed ? AppColors.textMuted : suitColors[suit],
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _Hand {
  List<String> cards;

  _Hand({required this.cards});
}

class _Scenario {
  final String name;
  final List<List<String>> hands;
  final List<String> board;

  _Scenario({
    required this.name,
    required this.hands,
    required this.board,
  });
}
