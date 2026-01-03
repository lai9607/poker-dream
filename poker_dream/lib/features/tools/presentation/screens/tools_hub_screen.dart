import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';
import 'icm_calculator_screen.dart';
import 'hand_ranges_screen.dart';
import 'equity_calculator_screen.dart';

class ToolsHubScreen extends StatelessWidget {
  final bool showBackButton;

  const ToolsHubScreen({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.feltBlack,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.backgroundDark,
            automaticallyImplyLeading: false,
            leading: showBackButton
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  )
                : null,
            title: Text('Tools', style: AppTextStyles.heading2),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Calculators', style: AppTextStyles.heading4),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _ToolCard(
                          icon: Icons.calculate,
                          title: 'ICM Calculator',
                          description: 'Calculate deal equity',
                          color: AppColors.neonGold,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ICMCalculatorScreen(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ToolCard(
                          icon: Icons.percent,
                          title: 'Equity Calc',
                          description: 'Hand vs hand odds',
                          color: AppColors.cerise,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EquityCalculatorScreen(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Text('Hand Analysis', style: AppTextStyles.heading4),
                  const SizedBox(height: 12),
                  _ToolCard(
                    icon: Icons.grid_on,
                    title: 'Hand Ranges',
                    description: 'Build and save custom hand ranges by position',
                    color: AppColors.info,
                    isFullWidth: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HandRangesScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text('Utilities', style: AppTextStyles.heading4),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _ToolCard(
                          icon: Icons.note_alt,
                          title: 'Notepad',
                          description: 'Quick notes',
                          color: AppColors.success,
                          onTap: () => _showNotepad(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ToolCard(
                          icon: Icons.timer,
                          title: 'Blind Timer',
                          description: 'Tournament timer',
                          color: AppColors.warning,
                          onTap: () {
                            // TODO: Implement blind timer
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Coming Soon Section
                  Container(
                    padding: const EdgeInsets.all(16),
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
                            Icon(Icons.upcoming, color: AppColors.neonGold),
                            const SizedBox(width: 8),
                            Text('Coming Soon', style: AppTextStyles.heading4),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _ComingSoonItem(
                          icon: Icons.replay,
                          title: 'Hand Replayer',
                          description: 'Replay and analyze hands',
                        ),
                        const SizedBox(height: 8),
                        _ComingSoonItem(
                          icon: Icons.school,
                          title: 'Training Mode',
                          description: 'Practice scenarios',
                        ),
                        const SizedBox(height: 8),
                        _ComingSoonItem(
                          icon: Icons.auto_graph,
                          title: 'GTO Trainer',
                          description: 'Learn optimal play',
                        ),
                      ],
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

  void _showNotepad(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Quick Notes', style: AppTextStyles.heading4),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 8,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Write your notes here...',
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
          ],
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;
  final bool isFullWidth;

  const _ToolCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: isFullWidth
            ? Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(description, style: AppTextStyles.labelSmall),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textMuted),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
      ),
    );
  }
}

class _ComingSoonItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ComingSoonItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textMuted),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.bodyMedium),
              Text(description, style: AppTextStyles.labelSmall),
            ],
          ),
        ),
      ],
    );
  }
}
