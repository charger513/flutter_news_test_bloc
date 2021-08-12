import 'package:dartz/dartz.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/article.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/news_response.dart';
import 'package:flutter_news_test_bloc/features/news/domain/repositories/news_repository_contract.dart';
import 'package:flutter_news_test_bloc/features/news/domain/usecases/get_news.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_news_test.mocks.dart';

@GenerateMocks([NewsRepositoryContract])
void main() {
  late MockNewsRepositoryContract mockNewsRepository;
  late GetNews getNews;

  setUp(() {
    mockNewsRepository = MockNewsRepositoryContract();
    getNews = GetNews(mockNewsRepository);
  });

  final tNewsResponse = NewsResponse(
    status: 'ok',
    totalResults: 1,
    articles: [
      Article(
        author: 'Emmanuel',
        description: 'description',
        content: 'content',
      )
    ],
  );

  test("should get the news from the repository", () async {
    when(mockNewsRepository.getNews())
        .thenAnswer((_) async => Right(tNewsResponse));

    final result = await getNews();

    expect(result, Right(tNewsResponse));

    verify(mockNewsRepository.getNews());

    verifyNoMoreInteractions(mockNewsRepository);
  });
}
