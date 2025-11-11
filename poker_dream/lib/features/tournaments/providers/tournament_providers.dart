import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../models/tournament_model.dart';
import '../services/tournament_service.dart';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Tournament Service Provider
final tournamentServiceProvider = Provider<TournamentService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return TournamentService(apiService);
});

// Get all tournaments with pagination
final tournamentsProvider = FutureProvider.family<PaginatedTournaments, TournamentQuery>(
  (ref, query) async {
    final service = ref.watch(tournamentServiceProvider);
    return service.getAllTournaments(
      page: query.page,
      limit: query.limit,
      status: query.status,
      search: query.search,
    );
  },
);

// Get tournament by ID
final tournamentByIdProvider = FutureProvider.family<TournamentModel, String>(
  (ref, id) async {
    final service = ref.watch(tournamentServiceProvider);
    return service.getTournamentById(id);
  },
);

// Get upcoming tournaments
final upcomingTournamentsProvider = FutureProvider.family<List<TournamentModel>, int>(
  (ref, limit) async {
    final service = ref.watch(tournamentServiceProvider);
    return service.getUpcomingTournaments(limit: limit);
  },
);

// Get live tournaments
final liveTournamentsProvider = FutureProvider<List<TournamentModel>>(
  (ref) async {
    final service = ref.watch(tournamentServiceProvider);
    return service.getLiveTournaments();
  },
);

// Get tournament statistics
final tournamentStatsProvider = FutureProvider<TournamentStats>(
  (ref) async {
    final service = ref.watch(tournamentServiceProvider);
    return service.getTournamentStats();
  },
);

// Query class for tournament filters
class TournamentQuery {
  final int page;
  final int limit;
  final TournamentStatus? status;
  final String? search;

  const TournamentQuery({
    this.page = 1,
    this.limit = 10,
    this.status,
    this.search,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TournamentQuery &&
        other.page == page &&
        other.limit == limit &&
        other.status == status &&
        other.search == search;
  }

  @override
  int get hashCode {
    return page.hashCode ^ limit.hashCode ^ status.hashCode ^ search.hashCode;
  }
}
