import 'dart:convert';

import 'package:flutter_news_test_bloc/core/errors/exception.dart';
import 'package:flutter_news_test_bloc/features/news/data/datasources/news_remote_data_source.dart';
import 'package:flutter_news_test_bloc/features/news/data/models/news_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'news_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late NewsRemoteDataSource newsRemoteDataSource;

  final tNewsResponseModel = NewsResponseModel.fromJson(
    json.decode(
      fixture('news.json'),
    ),
  );

  setUp(() {
    mockClient = MockClient();
    newsRemoteDataSource = NewsRemoteDataSource(mockClient);
  });

  void setUpMockClientSuccess200(MockClient mockClient) {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('news.json'), 200));
  }

  void setUpMockClientFailure404(MockClient mockClient) {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response('Error', 404));
  }

  test(
    "should perform a GET request on a URL with number being the endpoint and with application/json header",
    () async {
      // arrange
      setUpMockClientSuccess200(mockClient);

      // act
      await newsRemoteDataSource.getNews();

      // assert
      final uri = Uri.https('newsapi.org', '/v2/top-headlines', {
        'apiKey': '626a3fc2ddd4439f9d7ff96786deb733',
        'sortBy': 'publishedAt',
        'country': 'mx',
      });

      verify(mockClient.get(uri));
    },
  );

  test(
    "should return NewsResponseModel when de response code is 200 (success)",
    () async {
      // arrange
      setUpMockClientSuccess200(mockClient);
      // act
      final result = await newsRemoteDataSource.getNews();
      // assert
      expect(result, tNewsResponseModel);
    },
  );

  test(
    "should throw ServerException when response code is 404 or other",
    () async {
      // arrange
      setUpMockClientFailure404(mockClient);
      // act
      final call = await newsRemoteDataSource.getNews;
      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    },
  );
}
