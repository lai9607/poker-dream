import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/video_highlight_model.dart';

final videosProvider = FutureProvider<List<VideoHighlightModel>>((ref) async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:3001/api/videos'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> videosJson = jsonData['data'];
      return videosJson
          .map((json) => VideoHighlightModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load videos: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching videos: $e');
  }
});
