import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';

class BankrollScreen extends StatefulWidget {
  const BankrollScreen({super.key});

  @override
  State<BankrollScreen> createState() => _BankrollScreenState();
}

class _BankrollScreenState extends State<BankrollScreen> {
  String _selectedPeriod = '30D';

  // Mock data
  final double _currentBalance = 25847.50;
  final double _monthlyChange = 3245.00;
  final double _changePercent = 14.4;

  final List<_Transaction> _transactions = [
    _Transaction(
      type: TransactionType.win,
      title: 'WSOP Main Event',
      amount: 5200.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    _Transaction(
      type: TransactionType.loss,
      title: '2/5 NLH Cash Game',
      amount: -850.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    _Transaction(
      type: TransactionType.deposit,
      title: 'Bank Deposit',
      amount: 2000.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    _Transaction(
      type: TransactionType.win,
      title: 'Venetian \$600 Daily',
      amount: 1875.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    _Transaction(
      type: TransactionType.withdrawal,
      title: 'Bank Withdrawal',
      amount: -1500.00,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    _Transaction(
      type: TransactionType.loss,
      title: '1/3 NLH Cash Game',
      amount: -320.00,
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

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
                Text('Bankroll', style: AppTextStyles.heading2),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: AppColors.neonGold),
                  onPressed: () => _showAddTransactionSheet(context),
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
                  // Balance Card
                  _BalanceCard(
                    balance: _currentBalance,
                    change: _monthlyChange,
                    changePercent: _changePercent,
                  ),
                  const SizedBox(height: 24),

                  // Period Selector
                  Row(
                    children: [
                      Text('Performance', style: AppTextStyles.heading3),
                      const Spacer(),
                      _PeriodSelector(
                        selected: _selectedPeriod,
                        onChanged: (period) {
                          setState(() => _selectedPeriod = period);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Chart Placeholder
                  _ChartPlaceholder(),
                  const SizedBox(height: 32),

                  // Quick Stats
                  Row(
                    children: [
                      Expanded(
                        child: _QuickStatCard(
                          label: 'Sessions',
                          value: '47',
                          icon: Icons.event_note,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickStatCard(
                          label: 'Win Rate',
                          value: '62%',
                          icon: Icons.trending_up,
                          valueColor: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickStatCard(
                          label: 'Avg Profit',
                          value: '\$285',
                          icon: Icons.attach_money,
                          valueColor: AppColors.neonGold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Transactions Header
                  Row(
                    children: [
                      Text('Recent Transactions', style: AppTextStyles.heading3),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.neonGold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Transactions List
                  ...List.generate(
                    _transactions.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _TransactionCard(transaction: _transactions[index]),
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

  void _showAddTransactionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _AddTransactionSheet(),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final double balance;
  final double change;
  final double changePercent;

  const _BalanceCard({
    required this.balance,
    required this.change,
    required this.changePercent,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = change >= 0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.componentDark,
            AppColors.charcoal,
          ],
        ),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [AppColors.glowShadow(blur: 20, opacity: 0.15)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total Balance',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.success.withOpacity(0.15)
                      : AppColors.error.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 14,
                      color: isPositive ? AppColors.success : AppColors.error,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${changePercent.toStringAsFixed(1)}%',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isPositive ? AppColors.success : AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_formatCurrency(balance)}',
            style: AppTextStyles.heading1.copyWith(
              fontSize: 36,
              color: AppColors.neonGold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${isPositive ? '+' : ''}\$${_formatCurrency(change)} this month',
            style: AppTextStyles.bodySmall.copyWith(
              color: isPositive ? AppColors.success : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    return value.abs().toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

class _PeriodSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _PeriodSelector({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final periods = ['7D', '30D', '90D', '1Y', 'ALL'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: periods.map((period) {
          final isSelected = period == selected;
          return GestureDetector(
            onTap: () => onChanged(period),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.neonGold : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                period,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected ? Colors.black : AppColors.textMuted,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ChartPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Stack(
        children: [
          // Fake chart lines
          CustomPaint(
            size: const Size(double.infinity, 180),
            painter: _ChartPainter(),
          ),
          // Placeholder text
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.show_chart, color: AppColors.neonGold, size: 32),
                SizedBox(height: 8),
                Text(
                  'Profit Trend Chart',
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonGold.withOpacity(0.2)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.cubicTo(
      size.width * 0.25,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.6,
      size.width * 0.75,
      size.height * 0.3,
    );
    path.lineTo(size.width, size.height * 0.4);

    canvas.drawPath(path, paint);

    // Gradient fill
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.neonGold.withOpacity(0.15),
          AppColors.neonGold.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _QuickStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _QuickStatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.textMuted),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.heading3.copyWith(
              color: valueColor ?? AppColors.textLight,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final _Transaction transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: transaction.iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                transaction.icon,
                color: transaction.iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            // Title & Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(transaction.date),
                    style: AppTextStyles.labelSmall,
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              '${transaction.amount >= 0 ? '+' : ''}\$${transaction.amount.abs().toStringAsFixed(0)}',
              style: AppTextStyles.bodyLarge.copyWith(
                color: transaction.amount >= 0 ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _AddTransactionSheet extends StatefulWidget {
  const _AddTransactionSheet();

  @override
  State<_AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<_AddTransactionSheet> {
  TransactionType _selectedType = TransactionType.win;
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
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
              Text('Add Transaction', style: AppTextStyles.heading3),
              const SizedBox(height: 20),

              // Type Selector
              Row(
                children: TransactionType.values.map((type) {
                  final isSelected = type == _selectedType;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedType = type),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? type.color.withOpacity(0.2)
                              : AppColors.componentDark,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? type.color : AppColors.borderSubtle,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(type.icon, color: type.color, size: 20),
                            const SizedBox(height: 4),
                            Text(
                              type.label,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isSelected
                                    ? AppColors.textLight
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Amount Field
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: AppTextStyles.heading2.copyWith(color: AppColors.neonGold),
                decoration: InputDecoration(
                  hintText: '\$0.00',
                  hintStyle: AppTextStyles.heading2.copyWith(
                    color: AppColors.textMuted,
                  ),
                  filled: true,
                  fillColor: AppColors.componentDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.attach_money,
                      color: AppColors.neonGold),
                ),
              ),
              const SizedBox(height: 12),

              // Title Field
              TextField(
                controller: _titleController,
                style: AppTextStyles.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Description (optional)',
                  hintStyle: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textMuted,
                  ),
                  filled: true,
                  fillColor: AppColors.componentDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.notes,
                      color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Save transaction
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
                    'Save Transaction',
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
    );
  }
}

enum TransactionType {
  win,
  loss,
  deposit,
  withdrawal;

  String get label {
    switch (this) {
      case TransactionType.win:
        return 'Win';
      case TransactionType.loss:
        return 'Loss';
      case TransactionType.deposit:
        return 'Deposit';
      case TransactionType.withdrawal:
        return 'Withdraw';
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionType.win:
        return Icons.emoji_events;
      case TransactionType.loss:
        return Icons.trending_down;
      case TransactionType.deposit:
        return Icons.add_circle;
      case TransactionType.withdrawal:
        return Icons.remove_circle;
    }
  }

  Color get color {
    switch (this) {
      case TransactionType.win:
        return AppColors.success;
      case TransactionType.loss:
        return AppColors.error;
      case TransactionType.deposit:
        return AppColors.info;
      case TransactionType.withdrawal:
        return AppColors.warning;
    }
  }
}

class _Transaction {
  final TransactionType type;
  final String title;
  final double amount;
  final DateTime date;

  _Transaction({
    required this.type,
    required this.title,
    required this.amount,
    required this.date,
  });

  IconData get icon => type.icon;
  Color get iconColor => type.color;
}

/// Embeddable content version for use in tab views
class BankrollContent extends StatefulWidget {
  const BankrollContent({super.key});

  @override
  State<BankrollContent> createState() => _BankrollContentState();
}

class _BankrollContentState extends State<BankrollContent> {
  String _selectedPeriod = '30D';

  final double _currentBalance = 25847.50;
  final double _monthlyChange = 3245.00;
  final double _changePercent = 14.4;

  final List<_Transaction> _transactions = [
    _Transaction(
      type: TransactionType.win,
      title: 'WSOP Main Event',
      amount: 5200.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    _Transaction(
      type: TransactionType.loss,
      title: '2/5 NLH Cash Game',
      amount: -850.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    _Transaction(
      type: TransactionType.deposit,
      title: 'Bank Deposit',
      amount: 2000.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    _Transaction(
      type: TransactionType.win,
      title: 'Venetian \$600 Daily',
      amount: 1875.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    _Transaction(
      type: TransactionType.withdrawal,
      title: 'Bank Withdrawal',
      amount: -1500.00,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    _Transaction(
      type: TransactionType.loss,
      title: '1/3 NLH Cash Game',
      amount: -320.00,
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Add button row
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () => _showAddTransactionSheet(context),
              icon: const Icon(Icons.add_circle_outline, color: AppColors.neonGold, size: 20),
              label: Text(
                'Add Transaction',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.neonGold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Balance Card
        _BalanceCard(
          balance: _currentBalance,
          change: _monthlyChange,
          changePercent: _changePercent,
        ),
        const SizedBox(height: 24),

        // Period Selector
        Row(
          children: [
            Text('Performance', style: AppTextStyles.heading3),
            const Spacer(),
            _PeriodSelector(
              selected: _selectedPeriod,
              onChanged: (period) {
                setState(() => _selectedPeriod = period);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Chart Placeholder
        _ChartPlaceholder(),
        const SizedBox(height: 32),

        // Quick Stats
        Row(
          children: [
            Expanded(
              child: _QuickStatCard(
                label: 'Sessions',
                value: '47',
                icon: Icons.event_note,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickStatCard(
                label: 'Win Rate',
                value: '62%',
                icon: Icons.trending_up,
                valueColor: AppColors.success,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickStatCard(
                label: 'Avg Profit',
                value: '\$285',
                icon: Icons.attach_money,
                valueColor: AppColors.neonGold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Transactions Header
        Row(
          children: [
            Text('Recent Transactions', style: AppTextStyles.heading3),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.neonGold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Transactions List
        ...List.generate(
          _transactions.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _TransactionCard(transaction: _transactions[index]),
          ),
        ),
      ],
    );
  }

  void _showAddTransactionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _AddTransactionSheet(),
    );
  }
}
