part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNews extends NewsEvent {
  final String category;

  LoadNews(this.category);

  @override
  List<Object?> get props => [category];
}
