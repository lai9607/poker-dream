class VideoHighlightModel {
  final String id;
  final String title;
  final String? description;
  final String videoUrl;
  final String? thumbnailUrl;
  final int? durationSeconds;
  final int viewCount;
  final DateTime publishedAt;

  VideoHighlightModel({
    required this.id,
    required this.title,
    this.description,
    required this.videoUrl,
    this.thumbnailUrl,
    this.durationSeconds,
    required this.viewCount,
    required this.publishedAt,
  });

  factory VideoHighlightModel.fromJson(Map<String, dynamic> json) {
    return VideoHighlightModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      durationSeconds: json['durationSeconds'] as int?,
      viewCount: json['viewCount'] as int,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'durationSeconds': durationSeconds,
      'viewCount': viewCount,
      'publishedAt': publishedAt.toIso8601String(),
    };
  }

  String get formattedDuration {
    if (durationSeconds == null) return '';
    final mins = durationSeconds! ~/ 60;
    final secs = durationSeconds! % 60;
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }
}
