import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/news_response.dart';
import '../repositories/news_repository_contract.dart';

class GetNews {
  final NewsRepositoryContract newsRepository;

  GetNews(this.newsRepository);

  Future<Either<Failure, NewsResponse>> call() async {
    return await newsRepository.getNews();
  }
}
