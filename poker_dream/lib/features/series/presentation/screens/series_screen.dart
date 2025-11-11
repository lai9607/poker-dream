import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
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
              'Series',
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
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tournament Image
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.componentDark,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: tournament.bannerImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(tournament.bannerImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: tournament.bannerImageUrl == null
                ? Center(
                    child: Icon(
                      Icons.emoji_events,
                      size: 48,
                      color: AppColors.textMuted.withValues(alpha: 0.3),
                    ),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        tournament.name,
                        style: AppTextStyles.heading4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _getStatusColor(tournament.status).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getStatusLabel(tournament.status),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: _getStatusColor(tournament.status),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDateRange(tournament.startDate, tournament.endDate),
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
                if (tournament.location != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tournament.location!,
                          style: AppTextStyles.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                if (tournament.prizePool != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        size: 16,
                        color: AppColors.accentGold,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Prize Pool: ${_formatCurrency(tournament.prizePool)}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.accentGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentGold.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? AppColors.accentGold : AppColors.textMuted,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
