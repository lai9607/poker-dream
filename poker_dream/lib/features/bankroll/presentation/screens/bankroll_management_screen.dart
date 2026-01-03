import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/neon_components.dart';

class BankrollManagementScreen extends StatefulWidget {
  const BankrollManagementScreen({super.key});

  @override
  State<BankrollManagementScreen> createState() => _BankrollManagementScreenState();
}

class _BankrollManagementScreenState extends State<BankrollManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

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
                    'Bankroll',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _showAddTransactionSheet(context),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.neonGold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.add, color: AppColors.neonGold, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            // Balance Overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.charcoal,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Current Balance',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$24,850',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildBalanceStat('Deposits', '\$15,000', AppColors.success)),
                        Container(width: 1, height: 40, color: AppColors.borderSubtle),
                        Expanded(child: _buildBalanceStat('Withdrawals', '\$5,200', AppColors.cerise)),
                        Container(width: 1, height: 40, color: AppColors.borderSubtle),
                        Expanded(child: _buildBalanceStat('Net Profit', '\$15,050', AppColors.neonGold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

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
                  Tab(text: 'Transactions'),
                  Tab(text: 'Goals'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ['All', 'Deposits', 'Withdrawals', 'Wins', 'Losses'].map((filter) {
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
            const SizedBox(height: 12),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTransactionsList(),
                  _buildGoalsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsList() {
    final transactions = [
      {'type': 'win', 'title': 'Session at Aria', 'amount': 1250, 'date': 'Today'},
      {'type': 'loss', 'title': 'Tournament Buy-in', 'amount': -500, 'date': 'Yesterday'},
      {'type': 'deposit', 'title': 'Bank Transfer', 'amount': 2000, 'date': '3 days ago'},
      {'type': 'win', 'title': 'Session at Bellagio', 'amount': 2850, 'date': '5 days ago'},
      {'type': 'withdrawal', 'title': 'Cash Out', 'amount': -1000, 'date': '1 week ago'},
      {'type': 'loss', 'title': 'Session at Aria', 'amount': -680, 'date': '1 week ago'},
      {'type': 'win', 'title': 'Venetian Tournament', 'amount': 1800, 'date': '2 weeks ago'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final type = tx['type'] as String;
        final amount = tx['amount'] as int;
        final isPositive = amount > 0;

        IconData icon;
        Color color;
        switch (type) {
          case 'deposit':
            icon = Icons.arrow_downward;
            color = AppColors.success;
            break;
          case 'withdrawal':
            icon = Icons.arrow_upward;
            color = AppColors.cerise;
            break;
          case 'win':
            icon = Icons.trending_up;
            color = AppColors.success;
            break;
          case 'loss':
            icon = Icons.trending_down;
            color = AppColors.cerise;
            break;
          default:
            icon = Icons.swap_horiz;
            color = AppColors.textMuted;
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.charcoal,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tx['date'] as String,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${isPositive ? '+' : ''}\$${amount.abs()}',
                  style: TextStyle(
                    color: isPositive ? AppColors.success : AppColors.cerise,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGoalsList() {
    final goals = [
      {'name': 'Build to \$30K', 'current': 24850, 'target': 30000, 'deadline': 'Dec 31, 2025'},
      {'name': 'Vegas Trip Fund', 'current': 3200, 'target': 5000, 'deadline': 'Mar 1, 2025'},
      {'name': 'New Stakes Bankroll', 'current': 8500, 'target': 15000, 'deadline': 'Jun 30, 2025'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: goals.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neonGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.neonGold.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: AppColors.neonGold),
                    SizedBox(width: 8),
                    Text(
                      'Add New Goal',
                      style: TextStyle(
                        color: AppColors.neonGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final goal = goals[index - 1];
        final current = goal['current'] as int;
        final target = goal['target'] as int;
        final progress = current / target;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
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
                    Expanded(
                      child: Text(
                        goal['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        color: AppColors.neonGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.componentDark,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.neonGold),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${current.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} / \$${target.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Due: ${goal['deadline']}',
                      style: const TextStyle(
                        color: AppColors.textSubtle,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddTransactionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _AddTransactionSheet(),
    );
  }
}

class _AddTransactionSheet extends StatefulWidget {
  @override
  State<_AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<_AddTransactionSheet> {
  String _selectedType = 'deposit';
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
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      decoration: const BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderSubtle,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Add Transaction',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Transaction Type
            Row(
              children: [
                _buildTypeChip('Deposit', 'deposit', AppColors.success),
                const SizedBox(width: 8),
                _buildTypeChip('Withdrawal', 'withdrawal', AppColors.cerise),
              ],
            ),
            const SizedBox(height: 20),

            // Amount Input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(color: AppColors.textMuted.withOpacity(0.5)),
                prefixText: '\$ ',
                prefixStyle: const TextStyle(color: AppColors.neonGold, fontSize: 24, fontWeight: FontWeight.w700),
                filled: true,
                fillColor: AppColors.componentDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title Input
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Description (optional)',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.componentDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Save Transaction',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String label, String value, Color color) {
    final isSelected = _selectedType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : AppColors.componentDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : AppColors.borderSubtle,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? color : AppColors.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
