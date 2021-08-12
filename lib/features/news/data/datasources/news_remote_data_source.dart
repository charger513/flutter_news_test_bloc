import 'dart:convert';

import '../../../../core/errors/exception.dart';
import '../models/news_response_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSourceContract {
  /// Calls the https://newsapi.org/v2/top-headlines endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NewsResponseModel> getNews();
}

class NewsRemoteDataSource implements NewsRemoteDataSourceContract {
  final http.Client client;

  NewsRemoteDataSource(this.client);

  @override
  Future<NewsResponseModel> getNews() async {
    final uri = Uri.https("newsapi.org", "/v2/top-headlines", {
      'apiKey': '626a3fc2ddd4439f9d7ff96786deb733',
      'sortBy': 'publishedAt',
      'country': 'mx',
    });

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return NewsResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
