import 'package:dio/dio.dart';
import '../../../core/services/api_service.dart';
import '../models/tournament_model.dart';

class TournamentService {
  final ApiService _apiService;

  TournamentService(this._apiService);

  // Get all tournaments with pagination and filters
  Future<PaginatedTournaments> getAllTournaments({
    int page = 1,
    int limit = 10,
    TournamentStatus? status,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (status != null) {
        queryParams['status'] = status.name.toUpperCase();
      }

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _apiService.get('/tournaments', queryParameters: queryParams);

      return PaginatedTournaments.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get tournament by ID
  Future<TournamentModel> getTournamentById(String id) async {
    try {
      final response = await _apiService.get('/tournaments/$id');
      final data = response.data as Map<String, dynamic>;
      return TournamentModel.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get upcoming tournaments
  Future<List<TournamentModel>> getUpcomingTournaments({int limit = 10}) async {
    try {
      final response = await _apiService.get(
        '/tournaments/upcoming',
        queryParameters: {'limit': limit.toString()},
      );

      final data = response.data as Map<String, dynamic>;
      final List<dynamic> tournamentsJson = data['data'] as List<dynamic>;

      return tournamentsJson
          .map((json) => TournamentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get live tournaments
  Future<List<TournamentModel>> getLiveTournaments() async {
    try {
      final response = await _apiService.get('/tournaments/live');

      final data = response.data as Map<String, dynamic>;
      final List<dynamic> tournamentsJson = data['data'] as List<dynamic>;

      return tournamentsJson
          .map((json) => TournamentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get tournament statistics
  Future<TournamentStats> getTournamentStats() async {
    try {
      final response = await _apiService.get('/tournaments/stats');

      final data = response.data as Map<String, dynamic>;
      return TournamentStats.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handler
  String _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      if (statusCode == 404) {
        return 'Tournament not found';
      } else if (statusCode == 500) {
        return 'Server error. Please try again later';
      } else if (data is Map && data.containsKey('error')) {
        return data['error'] as String;
      }
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'Connection timeout. Please check your internet connection';
    }

    if (error.type == DioExceptionType.connectionError) {
      return 'Unable to connect to server. Please check your internet connection';
    }

    return 'An unexpected error occurred';
  }
}
