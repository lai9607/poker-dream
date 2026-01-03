import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/neon_components.dart';

class BankrollDashboardScreen extends StatefulWidget {
  const BankrollDashboardScreen({super.key});

  @override
  State<BankrollDashboardScreen> createState() => _BankrollDashboardScreenState();
}

class _BankrollDashboardScreenState extends State<BankrollDashboardScreen> {
  String _selectedPeriod = '30D';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.feltBlack,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Track. Analyze. Improve.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.componentDark,
                        child: const Icon(Icons.person, color: AppColors.neonGold, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Balance Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.neonGold.withOpacity(0.2),
                        AppColors.cerise.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.neonGold.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Total Bankroll',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.trending_up, size: 14, color: AppColors.success),
                                SizedBox(width: 4),
                                Text(
                                  '+12.5%',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '\$24,850',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '+\$2,780 this month',
                        style: TextStyle(
                          color: AppColors.success,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Mini Chart Placeholder
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomPaint(
                          size: const Size(double.infinity, 60),
                          painter: _MiniChartPainter(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Period Filter
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: ['7D', '30D', '90D', '1Y', 'All'].map((period) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: NeonFilterChip(
                        label: period,
                        isSelected: _selectedPeriod == period,
                        onTap: () => setState(() => _selectedPeriod = period),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Quick Stats Grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: _buildStatCard('Sessions', '47', Icons.history)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('Win Rate', '68%', Icons.trending_up)),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: _buildStatCard('Hourly', '\$42/hr', Icons.timer)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('ROI', '24.5%', Icons.pie_chart)),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Recent Sessions
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      'Recent Sessions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(color: AppColors.neonGold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Session List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildSessionItem(index),
                childCount: 5,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.componentDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.neonGold, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionItem(int index) {
    final sessions = [
      {'venue': 'Aria Poker Room', 'stakes': '2/5 NLH', 'profit': 1250, 'duration': '6h 30m', 'type': 'cash'},
      {'venue': 'WSOP Daily #15', 'stakes': '\$500 Buy-in', 'profit': -500, 'duration': '4h 15m', 'type': 'tournament'},
      {'venue': 'Bellagio', 'stakes': '5/10 NLH', 'profit': 2850, 'duration': '8h 00m', 'type': 'cash'},
      {'venue': 'Venetian Deepstack', 'stakes': '\$300 Buy-in', 'profit': 1800, 'duration': '7h 45m', 'type': 'tournament'},
      {'venue': 'Aria Poker Room', 'stakes': '2/5 NLH', 'profit': -680, 'duration': '3h 20m', 'type': 'cash'},
    ];

    final session = sessions[index];
    final isWin = (session['profit'] as int) > 0;
    final isTournament = session['type'] == 'tournament';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: PressableCard(
        onTap: () {},
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
                  color: isTournament
                      ? AppColors.cerise.withOpacity(0.2)
                      : AppColors.neonGold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isTournament ? Icons.emoji_events : Icons.attach_money,
                  color: isTournament ? AppColors.cerise : AppColors.neonGold,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session['venue'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          session['stakes'] as String,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.textSubtle,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          session['duration'] as String,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '${isWin ? '+' : ''}\$${(session['profit'] as int).abs()}',
                style: TextStyle(
                  color: isWin ? AppColors.success : AppColors.cerise,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonGold
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final points = [0.3, 0.5, 0.4, 0.7, 0.6, 0.8, 0.75, 0.9, 0.85];

    for (int i = 0; i < points.length; i++) {
      final x = (size.width / (points.length - 1)) * i;
      final y = size.height - (size.height * points[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Draw gradient fill
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.neonGold.withOpacity(0.3),
          AppColors.neonGold.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
