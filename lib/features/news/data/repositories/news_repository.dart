import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/repositories/network_info_contract.dart';
import '../../domain/entities/news_response.dart';
import '../../domain/repositories/news_repository_contract.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepository implements NewsRepositoryContract {
  final NetworkInfoContract _networkInfo;
  final NewsRemoteDataSourceContract _newsRemoteDataSource;

  NewsRepository({
    required NetworkInfoContract networkInfo,
    required NewsRemoteDataSourceContract newsRemoteDataSource,
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
