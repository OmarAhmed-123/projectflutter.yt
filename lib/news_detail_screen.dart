import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String author;
  final String content;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ignore: unnecessary_null_comparison
            if (imageUrl != null) Image.network(imageUrl),
            const SizedBox(height: 16.0),
            Text(
              title,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('By $author',
                style: const TextStyle(
                    fontSize: 16.0, fontStyle: FontStyle.italic)),
            const SizedBox(height: 16.0),
            Text(content, style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
