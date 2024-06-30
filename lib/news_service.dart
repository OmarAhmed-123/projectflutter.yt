import 'dart:convert';
// ignore: unused_import
import 'package:firstproject/news_screenn.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '4ae0ee9e8a864dd5a1d3b053f26e2cf9';
  final String apiUrl =
      'https://newsapi.org/v2/everything?q=Apple&from=2024-06-30&sortBy=popularity&apiKey=API_KEY';

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
