import 'package:flutter_news_test_bloc/features/news/domain/usecases/get_news.dart'
    as usecase;
import 'package:flutter_news_test_bloc/features/news/presentation/bloc/news_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/connection/network_info.dart';
import 'core/network/repositories/network_info_contract.dart';
import 'features/news/data/datasources/news_remote_data_source.dart';
import 'features/news/data/repositories/news_repository.dart';
import 'features/news/domain/repositories/news_repository_contract.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<NetworkInfoContract>(() => NetworkInfo(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => NewsBloc(
      getNews: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => usecase.GetNews(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepositoryContract>(
    () => NewsRepository(
      networkInfo: sl(),
      newsRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSourceContract>(
    () => NewsRemoteDataSource(sl()),
  );
}
