import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_article_model.dart';

final newsProvider = FutureProvider<List<NewsArticleModel>>((ref) async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:3001/api/news?isPublished=true'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> newsJson = jsonData['data'];
      return newsJson
          .map((json) => NewsArticleModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching news: $e');
  }
});
