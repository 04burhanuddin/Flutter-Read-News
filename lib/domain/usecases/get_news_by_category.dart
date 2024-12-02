import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetNewsByCategory {
  final NewsRepository repository;

  GetNewsByCategory(this.repository);

  Future<List<Article>> call(String category) async {
    return await repository.fetchNews(category);
  }
}
