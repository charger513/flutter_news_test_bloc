import 'package:flutter_news_test_bloc/features/news/data/models/article_model.dart';
import 'package:flutter_news_test_bloc/features/news/data/models/source_model.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tArticle = ArticleModel(
    author: 'Emmanuel',
    content: 'content',
    description: 'description',
    publishedAt: DateTime.now(),
    // ignore: prefer_const_constructors
    source: SourceModel(id: 'id', name: 'name'),
    title: 'Title',
    url: 'Url',
    urlToImage: 'Url to image',
  );

  test("should be a subclass of Article entity", () {
    expect(tArticle, isA<Article>());
  });
}
