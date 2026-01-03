import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/neon_components.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _darkMode = true;
  bool _biometricAuth = false;
  String _currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.feltBlack,
      appBar: AppBar(
        backgroundColor: AppColors.feltBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account Section
          _buildSectionTitle('Account'),
          _buildSettingsCard([
            _buildNavigationItem(Icons.person_outline, 'Edit Profile', () {}),
            _buildNavigationItem(Icons.lock_outline, 'Change Password', () {}),
            _buildNavigationItem(Icons.email_outlined, 'Email Preferences', () {}),
          ]),
          const SizedBox(height: 24),

          // Notifications Section
          _buildSectionTitle('Notifications'),
          _buildSettingsCard([
            _buildSwitchItem(
              Icons.notifications_outlined,
              'Push Notifications',
              'Receive push notifications',
              _pushNotifications,
              (value) => setState(() => _pushNotifications = value),
            ),
            _buildSwitchItem(
              Icons.email_outlined,
              'Email Notifications',
              'Receive email updates',
              _emailNotifications,
              (value) => setState(() => _emailNotifications = value),
            ),
          ]),
          const SizedBox(height: 24),

          // Appearance Section
          _buildSectionTitle('Appearance'),
          _buildSettingsCard([
            _buildSwitchItem(
              Icons.dark_mode_outlined,
              'Dark Mode',
              'Use dark theme',
              _darkMode,
              (value) => setState(() => _darkMode = value),
            ),
            _buildDropdownItem(
              Icons.attach_money,
              'Currency',
              _currency,
              ['USD', 'EUR', 'GBP', 'MYR', 'SGD'],
              (value) => setState(() => _currency = value!),
            ),
          ]),
          const SizedBox(height: 24),

          // Security Section
          _buildSectionTitle('Security'),
          _buildSettingsCard([
            _buildSwitchItem(
              Icons.fingerprint,
              'Biometric Authentication',
              'Use Face ID or fingerprint',
              _biometricAuth,
              (value) => setState(() => _biometricAuth = value),
            ),
            _buildNavigationItem(Icons.devices, 'Manage Devices', () {}),
            _buildNavigationItem(Icons.history, 'Login History', () {}),
          ]),
          const SizedBox(height: 24),

          // Data Section
          _buildSectionTitle('Data & Storage'),
          _buildSettingsCard([
            _buildNavigationItem(Icons.cloud_sync, 'Sync Settings', () {}),
            _buildNavigationItem(Icons.download, 'Export Data', () {}),
            _buildNavigationItem(Icons.delete_outline, 'Clear Cache', () {}, isDestructive: true),
          ]),
          const SizedBox(height: 24),

          // Support Section
          _buildSectionTitle('Support'),
          _buildSettingsCard([
            _buildNavigationItem(Icons.help_outline, 'Help Center', () {}),
            _buildNavigationItem(Icons.chat_bubble_outline, 'Contact Support', () {}),
            _buildNavigationItem(Icons.feedback_outlined, 'Send Feedback', () {}),
            _buildNavigationItem(Icons.star_outline, 'Rate the App', () {}),
          ]),
          const SizedBox(height: 24),

          // Legal Section
          _buildSectionTitle('Legal'),
          _buildSettingsCard([
            _buildNavigationItem(Icons.description_outlined, 'Terms of Service', () {}),
            _buildNavigationItem(Icons.privacy_tip_outlined, 'Privacy Policy', () {}),
            _buildNavigationItem(Icons.gavel, 'Licenses', () {}),
          ]),
          const SizedBox(height: 24),

          // App Info
          Center(
            child: Column(
              children: [
                Text(
                  'Poker Dream v1.0.0',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Made with ♠️ for poker players',
                  style: TextStyle(color: AppColors.textSubtle, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: AppColors.cerise),
              label: const Text('Sign Out', style: TextStyle(color: AppColors.cerise)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.cerise),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Delete Account
          Center(
            child: TextButton(
              onPressed: () => _showDeleteAccountDialog(context),
              child: const Text(
                'Delete Account',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: children
            .asMap()
            .entries
            .map((entry) => Column(
                  children: [
                    entry.value,
                    if (entry.key < children.length - 1)
                      Divider(height: 1, color: AppColors.borderSubtle, indent: 56),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildNavigationItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? AppColors.cerise : AppColors.textMuted, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDestructive ? AppColors.cerise : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textMuted, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.neonGold,
            activeTrackColor: AppColors.neonGold.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(IconData icon, String title, String value, List<String> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textMuted, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.componentDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: value,
              items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
              onChanged: onChanged,
              dropdownColor: AppColors.charcoal,
              style: const TextStyle(color: Colors.white),
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.charcoal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Account', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: TextStyle(color: AppColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cerise,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
