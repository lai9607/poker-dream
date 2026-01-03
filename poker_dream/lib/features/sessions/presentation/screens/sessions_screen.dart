import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/neon_components.dart';

class SessionsScreen extends StatefulWidget {
  final bool showLogForm;

  const SessionsScreen({super.key, this.showLogForm = false});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Cash', 'Tournament'];

  @override
  void initState() {
    super.initState();
    if (widget.showLogForm) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLogSessionSheet(context);
      });
    }
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
                    'Sessions',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Summary Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.charcoal,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Row(
                  children: [
                    _buildSummaryStat('Sessions', '47', Icons.history),
                    Container(width: 1, height: 40, color: AppColors.borderSubtle),
                    _buildSummaryStat('Profit', '+\$15,050', Icons.trending_up, color: AppColors.success),
                    Container(width: 1, height: 40, color: AppColors.borderSubtle),
                    _buildSummaryStat('Win Rate', '68%', Icons.pie_chart, color: AppColors.neonGold),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _filters.map((filter) {
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
            const SizedBox(height: 16),

            // Sessions List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _getSessions().length,
                itemBuilder: (context, index) {
                  return _buildSessionCard(_getSessions()[index], index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLogSessionSheet(context),
        backgroundColor: AppColors.neonGold,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text(
          'Log Session',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildSummaryStat(String label, String value, IconData icon, {Color? color}) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: color ?? AppColors.textMuted),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color ?? Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSessions() {
    final allSessions = [
      {'venue': 'Aria Poker Room', 'stakes': '2/5 NLH', 'buyIn': 1000, 'cashOut': 2250, 'duration': '6h 30m', 'type': 'cash', 'date': 'Today', 'notes': 'Great session, ran well'},
      {'venue': 'WSOP Daily #15', 'stakes': '\$500', 'buyIn': 500, 'cashOut': 0, 'duration': '4h 15m', 'type': 'tournament', 'date': 'Yesterday', 'position': 45, 'entries': 180},
      {'venue': 'Bellagio', 'stakes': '5/10 NLH', 'buyIn': 2000, 'cashOut': 4850, 'duration': '8h 00m', 'type': 'cash', 'date': 'Nov 25'},
      {'venue': 'Venetian Deepstack', 'stakes': '\$300', 'buyIn': 300, 'cashOut': 2100, 'duration': '7h 45m', 'type': 'tournament', 'date': 'Nov 24', 'position': 3, 'entries': 450},
      {'venue': 'Aria Poker Room', 'stakes': '2/5 NLH', 'buyIn': 1000, 'cashOut': 320, 'duration': '3h 20m', 'type': 'cash', 'date': 'Nov 23'},
      {'venue': 'Wynn', 'stakes': '2/5 NLH', 'buyIn': 1000, 'cashOut': 1650, 'duration': '5h 15m', 'type': 'cash', 'date': 'Nov 22'},
      {'venue': 'MSPT Main Event', 'stakes': '\$1,100', 'buyIn': 1100, 'cashOut': 0, 'duration': '6h 00m', 'type': 'tournament', 'date': 'Nov 21', 'position': 89, 'entries': 500},
    ];

    if (_selectedFilter == 'All') return allSessions;
    return allSessions.where((s) => s['type'] == _selectedFilter.toLowerCase()).toList();
  }

  Widget _buildSessionCard(Map<String, dynamic> session, int index) {
    final buyIn = session['buyIn'] as int;
    final cashOut = session['cashOut'] as int;
    final profit = cashOut - buyIn;
    final isWin = profit > 0;
    final isTournament = session['type'] == 'tournament';

    return PressableCard(
      onTap: () => _showSessionDetails(context, session),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
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
                    isTournament ? Icons.emoji_events : Icons.casino,
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
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        session['date'] as String,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isWin ? '+' : ''}\$${profit.abs()}',
                      style: TextStyle(
                        color: profit == 0
                            ? AppColors.textMuted
                            : (isWin ? AppColors.success : AppColors.cerise),
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    if (isTournament && session['position'] != null)
                      Text(
                        '${session['position']}/${session['entries']}',
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(height: 1, color: AppColors.borderSubtle),
            const SizedBox(height: 12),
            // Details Row
            Row(
              children: [
                _buildDetailChip(Icons.attach_money, session['stakes'] as String),
                const SizedBox(width: 8),
                _buildDetailChip(Icons.timer_outlined, session['duration'] as String),
                const SizedBox(width: 8),
                _buildDetailChip(
                  Icons.arrow_downward,
                  '\$${buyIn}',
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 8),
                _buildDetailChip(
                  Icons.arrow_upward,
                  '\$${cashOut}',
                  color: cashOut > buyIn ? AppColors.success : AppColors.textMuted,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color ?? AppColors.textMuted),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color ?? AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showSessionDetails(BuildContext context, Map<String, dynamic> session) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _SessionDetailsSheet(session: session),
    );
  }

  void _showLogSessionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _LogSessionSheet(),
    );
  }
}

class _SessionDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> session;

  const _SessionDetailsSheet({required this.session});

  @override
  Widget build(BuildContext context) {
    final buyIn = session['buyIn'] as int;
    final cashOut = session['cashOut'] as int;
    final profit = cashOut - buyIn;
    final isWin = profit > 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
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
          Text(
            session['venue'] as String,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            session['date'] as String,
            style: const TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          // Profit Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: (isWin ? AppColors.success : AppColors.cerise).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (isWin ? AppColors.success : AppColors.cerise).withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Text(
                  '${isWin ? '+' : ''}\$${profit.abs()}',
                  style: TextStyle(
                    color: profit == 0 ? AppColors.textMuted : (isWin ? AppColors.success : AppColors.cerise),
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isWin ? 'Profit' : (profit == 0 ? 'Break Even' : 'Loss'),
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Details Grid
          Row(
            children: [
              Expanded(child: _buildDetailItem('Stakes', session['stakes'] as String)),
              Expanded(child: _buildDetailItem('Duration', session['duration'] as String)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDetailItem('Buy-in', '\$${buyIn}')),
              Expanded(child: _buildDetailItem('Cash-out', '\$${cashOut}')),
            ],
          ),
          if (session['notes'] != null) ...[
            const SizedBox(height: 16),
            const Text('Notes', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              session['notes'] as String,
              style: const TextStyle(color: Colors.white),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.borderSubtle),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Edit', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGold,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Close', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.componentDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _LogSessionSheet extends StatefulWidget {
  const _LogSessionSheet();

  @override
  State<_LogSessionSheet> createState() => _LogSessionSheetState();
}

class _LogSessionSheetState extends State<_LogSessionSheet> {
  String _sessionType = 'cash';
  final _venueController = TextEditingController();
  final _stakesController = TextEditingController();
  final _buyInController = TextEditingController();
  final _cashOutController = TextEditingController();
  final _durationController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _venueController.dispose();
    _stakesController.dispose();
    _buyInController.dispose();
    _cashOutController.dispose();
    _durationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      decoration: const BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
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
          Row(
            children: [
              const Text(
                'Log Session',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Session Type Toggle
          Row(
            children: [
              _buildTypeToggle('Cash Game', 'cash', Icons.casino),
              const SizedBox(width: 8),
              _buildTypeToggle('Tournament', 'tournament', Icons.emoji_events),
            ],
          ),
          const SizedBox(height: 20),

          // Form Fields
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(_venueController, 'Venue', Icons.location_on),
                  const SizedBox(height: 12),
                  _buildTextField(_stakesController, _sessionType == 'cash' ? 'Stakes (e.g., 2/5)' : 'Buy-in Amount', Icons.attach_money),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(_buyInController, 'Buy-in', Icons.arrow_downward, isNumber: true)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTextField(_cashOutController, _sessionType == 'cash' ? 'Cash-out' : 'Payout', Icons.arrow_upward, isNumber: true)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(_durationController, 'Duration (e.g., 6h 30m)', Icons.timer),
                  const SizedBox(height: 12),
                  _buildTextField(_notesController, 'Notes (optional)', Icons.notes, maxLines: 3),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Session logged successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
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
                'Save Session',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeToggle(String label, String value, IconData icon) {
    final isSelected = _sessionType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _sessionType = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.neonGold.withOpacity(0.2) : AppColors.componentDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.neonGold : AppColors.borderSubtle,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? AppColors.neonGold : AppColors.textMuted, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.neonGold : AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textMuted),
        prefixIcon: Icon(icon, color: AppColors.textMuted),
        filled: true,
        fillColor: AppColors.componentDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
