import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../events/presentation/screens/events_screen.dart';
import '../../../live/presentation/screens/live_streams_screen.dart';
import '../../../social/presentation/screens/social_feed_screen.dart';
import '../../../chat/presentation/screens/chat_screen.dart';

class CommunityMainScreen extends StatefulWidget {
  const CommunityMainScreen({super.key});

  @override
  State<CommunityMainScreen> createState() => _CommunityMainScreenState();
}

class _CommunityMainScreenState extends State<CommunityMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const EventsScreen(),
    const LiveStreamsScreen(),
    const SocialFeedScreen(),
    const ChatScreen(),
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
                _buildNavItem(0, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.emoji_events_rounded, 'Events'),
                _buildNavItem(2, Icons.play_circle_rounded, 'Live'),
                _buildNavItem(3, Icons.forum_rounded, 'Social'),
                _buildNavItem(4, Icons.chat_bubble_rounded, 'Chat'),
              ],
            ),
          ),
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.neonGold : AppColors.textMuted,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
