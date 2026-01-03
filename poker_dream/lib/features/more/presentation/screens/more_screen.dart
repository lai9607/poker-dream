import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../tools/presentation/screens/tools_hub_screen.dart';
import '../../../tools/presentation/screens/icm_calculator_screen.dart';
import '../../../tools/presentation/screens/hand_ranges_screen.dart';
import '../../../tools/presentation/screens/equity_calculator_screen.dart';
import '../../../staking/presentation/screens/staking_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          // Tools Section
          _SettingsSection(
            title: 'Poker Tools',
            items: [
              _SettingsItem(
                icon: Icons.build,
                title: 'Tools Hub',
                subtitle: 'All poker tools in one place',
                onTap: () => _navigate(context, const ToolsHubScreen()),
              ),
              _SettingsItem(
                icon: Icons.calculate,
                title: 'ICM Calculator',
                subtitle: 'Calculate deal equity',
                onTap: () => _navigate(context, const ICMCalculatorScreen()),
              ),
              _SettingsItem(
                icon: Icons.grid_on,
                title: 'Hand Ranges',
                subtitle: 'Build custom hand ranges',
                onTap: () => _navigate(context, const HandRangesScreen()),
              ),
              _SettingsItem(
                icon: Icons.percent,
                title: 'Equity Calculator',
                subtitle: 'Hand vs hand odds',
                onTap: () => _navigate(context, const EquityCalculatorScreen()),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Marketplace Section
          _SettingsSection(
            title: 'Marketplace',
            items: [
              _SettingsItem(
                icon: Icons.handshake,
                title: 'Staking',
                subtitle: 'Buy & sell tournament action',
                onTap: () => _navigate(context, const StakingScreen()),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Settings Section
          _SettingsSection(
            title: 'Settings',
            items: [
              _SettingsItem(
                icon: Icons.person_outline,
                title: 'Account',
                subtitle: 'Manage your profile',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.notifications,
                title: 'Notifications',
                subtitle: 'Manage your alerts',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                subtitle: 'Enabled',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            title: 'Support',
            items: [
              _SettingsItem(
                icon: Icons.help_outline,
                title: 'Help & FAQ',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.contact_support,
                title: 'Contact Us',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            title: 'Legal',
            items: [
              _SettingsItem(
                icon: Icons.description,
                title: 'Terms of Service',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'Version 2.0.0',
              style: AppTextStyles.bodySmall,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<_SettingsItem> items;

  const _SettingsSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: AppTextStyles.heading4,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: List.generate(
              items.length,
              (index) => Column(
                children: [
                  items[index],
                  if (index < items.length - 1)
                    const Divider(
                      height: 1,
                      indent: 60,
                      color: AppColors.dividerDark,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.textLight,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTextStyles.bodySmall,
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textMuted,
      ),
      onTap: onTap,
    );
  }
}
