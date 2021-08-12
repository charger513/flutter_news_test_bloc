import 'dart:convert';

import 'package:flutter_news_test_bloc/features/news/data/models/article_model.dart';
import 'package:flutter_news_test_bloc/features/news/data/models/news_response_model.dart';
import 'package:flutter_news_test_bloc/features/news/data/models/source_model.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/news_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
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

  test("should be a subclass of NewsResponse entity", () {
    expect(tNewsResponseModel, isA<NewsResponse>());
  });

  group("fromJson", () {
    test("should return a valid NewsResponseModel", () {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('news.json'));

      // act
      final result = NewsResponseModel.fromJson(jsonMap);

      // assert
      expect(result, tNewsResponseModel);
    });
  });

  group("toJson", () {
    test("should return a JSON map containing the proper data", () {
      //arrange

      // act
      final json = tNewsResponseModel.toJson();

      final expectedMap = {
        "status": "ok",
        "totalResults": 2,
        "articles": [
          {
            "source": {"id": "1", "name": "name1"},
            "author": "Author",
            "title": "Title 1",
            "description": "Description 1",
            "url": "https://example.com",
            "urlToImage": "https://example.com",
            "publishedAt": "2021-08-12T06:58:26.000Z",
            "content": null
          },
          {
            "source": {"id": null, "name": "name2"},
            "author": "Author2",
            "title": "Title 2",
            "description": "Description 2",
            "url": "https://example.com",
            "urlToImage": "https://example.com",
            "publishedAt": "2021-08-12T05:16:00.000Z",
            "content": "Content"
          }
        ]
      };

      // assert
      expect(json, expectedMap);
    });
  });
}
