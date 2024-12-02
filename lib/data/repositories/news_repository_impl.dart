import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../model/article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  // Create API Key here https://newsapi.org/
  static const _apiKey = "";
  static const _baseUrl = "https://newsapi.org/v2/everything";

  @override
  Future<List<Article>> fetchNews(String category) async {
    final response =
        await http.get(Uri.parse("$_baseUrl?q=$category&apiKey=$_apiKey"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['articles'] as List;
      return data.map((article) => ArticleModel.fromJson(article)).toList();
    } else {
      throw Exception("Failed to fetch news: ${response.statusCode}");
    }
  }
}
