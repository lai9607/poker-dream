import 'package:json_annotation/json_annotation.dart';

part 'tournament_model.g.dart';

// Custom converter to handle string-to-double conversion for Decimal fields
class DecimalConverter implements JsonConverter<double?, dynamic> {
  const DecimalConverter();

  @override
  double? fromJson(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  @override
  dynamic toJson(double? value) => value;
}

@JsonSerializable()
class TournamentModel {
  final String id;
  final String name;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? venue;
  final TournamentStatus status;
  @DecimalConverter()
  final double? prizePool;
  @DecimalConverter()
  final double? buyIn;
  final int totalEntries;
  final String? bannerImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  TournamentModel({
    required this.id,
    required this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.venue,
    required this.status,
    this.prizePool,
    this.buyIn,
    required this.totalEntries,
    this.bannerImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentModelToJson(this);
}

enum TournamentStatus {
  @JsonValue('UPCOMING')
  upcoming,
  @JsonValue('LIVE')
  live,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELLED')
  cancelled,
}

@JsonSerializable()
class PaginatedTournaments {
  final List<TournamentModel> data;
  final PaginationMeta pagination;

  PaginatedTournaments({
    required this.data,
    required this.pagination,
  });

  factory PaginatedTournaments.fromJson(Map<String, dynamic> json) =>
      _$PaginatedTournamentsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedTournamentsToJson(this);
}

@JsonSerializable()
class PaginationMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  PaginationMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);
}

@JsonSerializable()
class TournamentStats {
  final int total;
  final int upcoming;
  final int live;
  final int completed;

  TournamentStats({
    required this.total,
    required this.upcoming,
    required this.live,
    required this.completed,
  });

  factory TournamentStats.fromJson(Map<String, dynamic> json) =>
      _$TournamentStatsFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentStatsToJson(this);
}
