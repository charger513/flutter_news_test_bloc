import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/news_response.dart';

abstract class NewsRepositoryContract {
  Future<Either<Failure, NewsResponse>> getNews();
}
