import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/article.dart';
import '../../domain/usecases/get_news_by_category.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsByCategory getNewsByCategory;

  NewsBloc(this.getNewsByCategory) : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final articles = await getNewsByCategory(event.category);
        emit(NewsLoaded(category: event.category, articles: articles));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });
  }
}
