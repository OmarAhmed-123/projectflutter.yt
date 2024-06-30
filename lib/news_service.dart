import 'dart:convert';
// ignore: unused_import
import 'package:firstproject/news_screenn.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = 'YOUR_API_KEY_HERE';
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=YOUR_API_KEY_HERE';

  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
