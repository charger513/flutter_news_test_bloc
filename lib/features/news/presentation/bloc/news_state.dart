part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class Empty extends NewsState {}

class Loading extends NewsState {}

class Loaded extends NewsState {
  final NewsResponse news;

  const Loaded({
    required this.news,
  });

  @override
  List<Object> get props => [news];
}

class Error extends NewsState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
