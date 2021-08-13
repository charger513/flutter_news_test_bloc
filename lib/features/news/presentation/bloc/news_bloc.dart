import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_test_bloc/core/errors/failure.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/news_response.dart';
import 'package:flutter_news_test_bloc/features/news/domain/usecases/get_news.dart'
    as usecase;

part 'news_event.dart';
part 'news_state.dart';

const String serverFailureMessage = 'Server Failure';
const String networkFailureMessage = 'Network Failure';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final usecase.GetNews getNews;

  NewsBloc({
    required this.getNews,
  }) : super(Empty());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is GetNews) {
      yield Loading();
      final failureOrNews = await getNews();
      yield failureOrNews.fold(
        (failure) => Error(_mapFailureToMessage(failure)),
        (news) => Loaded(news: news),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case NetworkFailure:
        return networkFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
