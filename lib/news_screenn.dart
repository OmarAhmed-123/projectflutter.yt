import 'package:flutter/material.dart';
import 'news_service.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News> _newsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    NewsService newsService = NewsService();
    try {
      List<News> newsList = (await newsService.fetchNews()).cast<News>();
      setState(() {
        _newsList = newsList;
        _isLoading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: fetchNews,
                child: ListView.builder(
                  itemCount: _newsList.length,
                  itemBuilder: (context, index) {
                    final newsItem = _newsList[index];
                    return ListTile(
                      // ignore: unnecessary_null_comparison
                      leading: newsItem.imageUrl != null
                          ? Image.network(newsItem.imageUrl,
                              width: 50, height: 50, fit: BoxFit.cover)
                          : null,
                      title: Text(newsItem.title),
                      subtitle: Text(newsItem.author),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailScreen(
                              title: newsItem.title,
                              imageUrl: newsItem.imageUrl,
                              author: newsItem.author,
                              content: newsItem.content,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}

//news
class News {
  final String title;
  final String author;
  final String content;
  final String imageUrl;

  News({
    required this.title,
    required this.author,
    required this.content,
    required this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] as String,
      author: json['author'] as String? ?? 'Unknown Author',
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}
