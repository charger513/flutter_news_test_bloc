import 'package:dartz/dartz.dart';
import 'package:flutter_news_test_bloc/core/errors/failure.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/news_response.dart';
import 'package:flutter_news_test_bloc/features/news/domain/repositories/news_repository_contract.dart';

class GetNews {
  final NewsRepositoryContract newsRepository;

  GetNews(this.newsRepository);

  Future<Either<Failure, NewsResponse>> call() async {
    return await newsRepository.getNews();
  }
}
