import 'package:flutter_news_test_bloc/core/errors/exception.dart';
import 'package:flutter_news_test_bloc/core/network/connection/network_info.dart';
import 'package:flutter_news_test_bloc/features/news/data/datasources/news_remote_data_source.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/news_response.dart';
import 'package:flutter_news_test_bloc/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news_test_bloc/features/news/domain/repositories/news_repository_contract.dart';

class NewsRepository implements NewsRepositoryContract {
  final NetworkInfo _networkInfo;
  final NewsRemoteDataSource _newsRemoteDataSource;

  NewsRepository({
    required NetworkInfo networkInfo,
    required NewsRemoteDataSource newsRemoteDataSource,
  })  : _networkInfo = networkInfo,
        _newsRemoteDataSource = newsRemoteDataSource;

  @override
  Future<Either<Failure, NewsResponse>> getNews() async {
    if (await _networkInfo.isConnected) {
      try {
        final news = await _newsRemoteDataSource.getNews();
        return Right(news);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
