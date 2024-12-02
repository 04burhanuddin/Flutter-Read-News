import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required super.title,
    required super.author,
    required super.description,
    required super.urlToImage,
    required super.category,
    required super.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No title',
      author: json['author'] ?? 'No Author',
      description: json['description'] ?? 'No description',
      urlToImage: json['urlToImage'] ?? '',
      category: json['category'] ?? 'uncategorized',
      publishedAt: json['publishedAt'] ?? 'no',
    );
  }
}
