import 'package:dartz/dartz.dart';
import 'package:flutter_news_test_bloc/core/errors/exception.dart';
import 'package:flutter_news_test_bloc/core/errors/failure.dart';
import 'package:flutter_news_test_bloc/core/network/connection/network_info.dart';
import 'package:flutter_news_test_bloc/features/news/data/datasources/news_remote_data_source.dart';
import 'package:flutter_news_test_bloc/features/news/data/models/article_model.dart';
import 'package:flutter_news_test_bloc/features/news/data/models/news_response_model.dart';
import 'package:flutter_news_test_bloc/features/news/data/models/source_model.dart';
import 'package:flutter_news_test_bloc/features/news/data/repositories/news_repository.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/news_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_repository_test.mocks.dart';

@GenerateMocks([
  NewsRemoteDataSource,
  NetworkInfo,
])
void main() {
  late NewsRepository newsRepository;
  late MockNewsRemoteDataSource mockNewsRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNewsRemoteDataSource = MockNewsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    newsRepository = NewsRepository(
      newsRemoteDataSource: mockNewsRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tNewsResponseModel = NewsResponseModel(
    status: 'ok',
    totalResults: 2,
    articles: [
      ArticleModel(
        author: 'Author',
        title: "Title 1",
        description: 'Description 1',
        url: "https://example.com",
        urlToImage: "https://example.com",
        publishedAt: DateTime.parse("2021-08-12T06:58:26.000Z"),
        content: null,
        source: SourceModel(id: '1', name: 'name1'),
      ),
      ArticleModel(
        author: 'Author2',
        title: "Title 2",
        description: 'Description 2',
        url: "https://example.com",
        urlToImage: "https://example.com",
        publishedAt: DateTime.parse("2021-08-12T05:16:00.000Z"),
        content: 'Content',
        source: SourceModel(id: null, name: 'name2'),
      ),
    ],
  );

  final NewsResponse tNewsResponse = tNewsResponseModel;

  test(
    'should check if the device is online',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockNewsRemoteDataSource.getNews())
          .thenAnswer((_) async => tNewsResponseModel);
      // act
      newsRepository.getNews();

      //assert
      verify(mockNetworkInfo.isConnected);
    },
  );

  test(
    "should return remote data when the call to remote data source is sucessful",
    () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockNewsRemoteDataSource.getNews())
          .thenAnswer((_) async => tNewsResponseModel);

      // act
      final result = await newsRepository.getNews();

      // assert
      verify(mockNewsRemoteDataSource.getNews());
      expect(result, Right(tNewsResponse));
    },
  );

  test(
    "should return ServerFailure when the call to remote data source is unsucessful",
    () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockNewsRemoteDataSource.getNews()).thenThrow(ServerException());

      // act
      final result = await newsRepository.getNews();

      // assert
      verify(mockNewsRemoteDataSource.getNews());
      expect(result, Left(ServerFailure()));
    },
  );

  test(
    "should return NetworkFailure when there is not internet connection",
    () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockNewsRemoteDataSource.getNews())
          .thenAnswer((_) async => tNewsResponseModel);

      // act
      final result = await newsRepository.getNews();

      // assert
      verifyZeroInteractions(mockNewsRemoteDataSource);
      expect(result, Left(NetworkFailure()));
    },
  );
}
