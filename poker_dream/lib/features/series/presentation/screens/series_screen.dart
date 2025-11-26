import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/neon_components.dart';
import '../../../tournaments/models/tournament_model.dart';
import '../../../tournaments/providers/tournament_providers.dart';

class SeriesScreen extends ConsumerStatefulWidget {
  const SeriesScreen({super.key});

  @override
  ConsumerState<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends ConsumerState<SeriesScreen> {
  TournamentStatus? _selectedStatus = TournamentStatus.upcoming;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final query = TournamentQuery(
      page: 1,
      limit: 50,
      status: _selectedStatus,
      search: _searchQuery.isEmpty ? null : _searchQuery,
    );

    final tournamentsAsync = ref.watch(tournamentsProvider(query));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo-white.png',
              height: 45,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Text(
              'Events',
              style: AppTextStyles.heading3,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Implement search dialog
              },
            ),
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () {
                // Implement filter dialog
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              children: [
                _FilterChip(
                  label: 'Upcoming',
                  isSelected: _selectedStatus == TournamentStatus.upcoming,
                  onTap: () =>
                      setState(() => _selectedStatus = TournamentStatus.upcoming),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Live',
                  isSelected: _selectedStatus == TournamentStatus.live,
                  onTap: () =>
                      setState(() => _selectedStatus = TournamentStatus.live),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Completed',
                  isSelected: _selectedStatus == TournamentStatus.completed,
                  onTap: () =>
                      setState(() => _selectedStatus = TournamentStatus.completed),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'All',
                  isSelected: _selectedStatus == null,
                  onTap: () => setState(() => _selectedStatus = null),
                ),
              ],
            ),
          ),

          // Tournament Cards
          Expanded(
            child: tournamentsAsync.when(
              data: (paginated) {
                if (paginated.data.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          size: 64,
                          color: AppColors.textMuted.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tournaments found',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(tournamentsProvider(query));
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: paginated.data.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final tournament = paginated.data[index];
                      return _TournamentCard(tournament: tournament);
                    },
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.accentGold,
                ),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      error.toString(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(tournamentsProvider(query));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TournamentCard extends StatelessWidget {
  final TournamentModel tournament;

  const _TournamentCard({required this.tournament});

  String _getStatusLabel(TournamentStatus status) {
    switch (status) {
      case TournamentStatus.upcoming:
        return 'Upcoming';
      case TournamentStatus.live:
        return 'Live';
      case TournamentStatus.completed:
        return 'Completed';
      case TournamentStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getStatusColor(TournamentStatus status) {
    switch (status) {
      case TournamentStatus.upcoming:
        return AppColors.accentGold;
      case TournamentStatus.live:
        return Colors.green;
      case TournamentStatus.completed:
        return AppColors.textMuted;
      case TournamentStatus.cancelled:
        return AppColors.primary;
    }
  }

  String _formatDateRange(DateTime? start, DateTime? end) {
    if (start == null) return 'Date TBA';

    final formatter = DateFormat('MMM d, yyyy');
    if (end == null) {
      return formatter.format(start);
    }

    return '${formatter.format(start)} - ${formatter.format(end)}';
  }

  String _formatCurrency(double? amount) {
    if (amount == null) return 'TBA';
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(18), // More rounded
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tournament Image (taller)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),
            child: tournament.bannerImageUrl != null
                ? Image.network(
                    tournament.bannerImageUrl!,
                    height: 170, // Taller!
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tournament.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Bordered status badge
                    NeonStatusBadge(
                      label: _getStatusLabel(tournament.status),
                      borderColor: _getStatusColor(tournament.status),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDateRange(tournament.startDate, tournament.endDate),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                if (tournament.location != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.place_outlined,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          tournament.location!,
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                if (tournament.prizePool != null) ...[
                  const SizedBox(height: 12),
                  // Prize pool meter with gradient!
                  PrizePoolMeter(
                    filled: 0.62, // TODO: Calculate based on registration
                    label: 'Prize Pool: ${_formatCurrency(tournament.prizePool)}',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 170,
      color: AppColors.componentDark,
      child: const Center(
        child: Icon(
          Icons.emoji_events,
          size: 48,
          color: Colors.white24,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Use the neon filter chip component
    return NeonFilterChip(
      label: label,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}
