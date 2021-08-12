import 'package:equatable/equatable.dart';

import 'article.dart';

class NewsResponse extends Equatable {
  const NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  @override
  List<Object?> get props => [status, totalResults, articles];
}
