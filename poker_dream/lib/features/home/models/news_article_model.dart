class NewsArticleModel {
  final String id;
  final String title;
  final String? summary;
  final String content;
  final String? imageUrl;
  final String category;
  final String? author;
  final bool isPublished;
  final DateTime? publishedAt;

  NewsArticleModel({
    required this.id,
    required this.title,
    this.summary,
    required this.content,
    this.imageUrl,
    required this.category,
    this.author,
    required this.isPublished,
    this.publishedAt,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String?,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String,
      author: json['author'] as String?,
      isPublished: json['isPublished'] as bool,
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'imageUrl': imageUrl,
      'category': category,
      'author': author,
      'isPublished': isPublished,
      'publishedAt': publishedAt?.toIso8601String(),
    };
  }

  String get timeAgo {
    if (publishedAt == null) return '';
    final difference = DateTime.now().difference(publishedAt!);

    if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
