import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'bankroll_dashboard_screen.dart';
import 'bankroll_management_screen.dart';
import '../../../sessions/presentation/screens/sessions_screen.dart';
import '../../../statistics/presentation/screens/stats_screen.dart';
import '../../../tools/presentation/screens/tools_hub_screen.dart';

class BankrollMainScreen extends StatefulWidget {
  const BankrollMainScreen({super.key});

  @override
  State<BankrollMainScreen> createState() => _BankrollMainScreenState();
}

class _BankrollMainScreenState extends State<BankrollMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const BankrollDashboardScreen(),
    const BankrollManagementScreen(),
    const SessionsScreen(),
    const StatsScreen(),
    const ToolsHubScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.feltBlack,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          border: Border(
            top: BorderSide(
              color: AppColors.borderSubtle,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.dashboard_rounded, 'Dashboard'),
                _buildNavItem(1, Icons.account_balance_wallet_rounded, 'Bankroll'),
                _buildNavItem(2, Icons.history_rounded, 'Sessions'),
                _buildNavItem(3, Icons.bar_chart_rounded, 'Stats'),
                _buildNavItem(4, Icons.calculate_rounded, 'Tools'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to log session
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SessionsScreen(showLogForm: true),
            ),
          );
        },
        backgroundColor: AppColors.neonGold,
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neonGold.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.neonGold : AppColors.textMuted,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.neonGold : AppColors.textMuted,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
