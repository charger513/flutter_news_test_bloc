import 'package:dartz/dartz.dart';
import 'package:flutter_news_test_bloc/core/errors/failure.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/article.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/news_response.dart';
import 'package:flutter_news_test_bloc/features/news/domain/usecases/get_news.dart'
    as usecase;
import 'package:flutter_news_test_bloc/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_bloc_test.mocks.dart';

@GenerateMocks([usecase.GetNews])
void main() {
  late NewsBloc bloc;
  late MockGetNews mockGetNews;

  setUp(() {
    mockGetNews = MockGetNews();
    bloc = NewsBloc(getNews: mockGetNews);
  });

  test(
    "initialState should be Empty",
    () {
      // assert
      expect(bloc.state, equals(Empty()));
    },
  );

  group("GetNews", () {
    // ignore: prefer_const_constructors
    final tNewsResponse = NewsResponse(
      status: 'ok',
      totalResults: 1,
      // ignore: prefer_const_literals_to_create_immutables
      articles: [
        // ignore: prefer_const_constructors
        Article(
          author: 'Emmanuel',
          description: 'description',
          content: 'content',
        )
      ],
    );

    test(
      "should get data from the getNews use case",
      () async {
        // arrange
        when(mockGetNews()).thenAnswer((_) async => Right(tNewsResponse));
        // act
        bloc.add(GetNews());
        await untilCalled(mockGetNews());
        // assert
        verify(mockGetNews());
      },
    );

    test(
      "should emit [Loading, Loaded] when data is gotten successfully",
      () async {
        // arrange
        when(mockGetNews()).thenAnswer((_) async => Right(tNewsResponse));
        // assert later
        final expected = [
          Loading(),
          Loaded(news: tNewsResponse),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetNews());
      },
    );

    test(
      "should emit [Loading, Error] when getting data fails",
      () async {
        // arrange
        when(mockGetNews()).thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          const Error(serverFailureMessage),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetNews());
      },
    );

    test(
      "should emit [Loading, Error] with a proper message for the error when getting data fails",
      () async {
        // arrange
        when(mockGetNews()).thenAnswer((_) async => Left(NetworkFailure()));
        // assert later
        final expected = [
          Loading(),
          const Error(networkFailureMessage),
        ];
        expectLater(bloc.stream.asBroadcastStream(), emitsInOrder(expected));
        // act
        bloc.add(GetNews());
      },
    );
  });
}
