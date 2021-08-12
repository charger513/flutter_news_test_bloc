// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_news_test_bloc/features/news/domain/entities/news_response.dart';

import 'article_model.dart';

NewsResponseModel newsResponseFromJson(String str) =>
    NewsResponseModel.fromJson(json.decode(str));

String newsResponseToJson(NewsResponseModel data) => json.encode(data.toJson());

class NewsResponseModel extends NewsResponse {
  NewsResponseModel({
    required String status,
    required int totalResults,
    required List<ArticleModel> articles,
  }) : super(
          status: status,
          totalResults: totalResults,
          articles: articles,
        );

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      NewsResponseModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<ArticleModel>.from(
            json["articles"].map((x) => ArticleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(
            articles.map((x) => (x as ArticleModel).toJson())),
      };
}
