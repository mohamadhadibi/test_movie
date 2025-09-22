import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:test_movie/core/utils/api_constants.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_movie/app/application_cubit.dart';
import 'package:test_movie/features/movie/data/movie_repository_impl.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/usecases/create_movie_usecase.dart';
import 'package:test_movie/features/movie/domain/usecases/delete_movie_usecase.dart';
import 'package:test_movie/features/movie/domain/usecases/get_movie_usecase.dart';
import 'package:test_movie/features/movie/domain/usecases/query_movie_usecase.dart';

final get = GetIt.instance;

Future<void> init() async {
  //get.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  final prefs = await SharedPreferences.getInstance();
  get.registerLazySingleton<SharedPreferences>(() => prefs);
  Dio dio = Dio();
  BaseOptions options = BaseOptions(
    connectTimeout: const Duration(minutes: 3),
    receiveTimeout: const Duration(minutes: 3),
  );
  dio.interceptors.add(LogInterceptor(
    responseBody: true,
    requestBody: true,
  ));
  dio.options = options;
  get.registerLazySingleton<Dio>(() => dio);
  final tmdb = TMDB(
    ApiKeys(tmdbApiKey, tmdbToken), 
    logConfig: const ConfigLogger.showAll(),
  );
  get.registerLazySingleton<TMDB>(() => tmdb);

  // NOTE: cubits
  get.registerFactory(() => ApplicationCubit());

  // NOTE: use-cases
  get.registerLazySingleton(() => CreateMovieUseCase(get()));
  get.registerLazySingleton(() => DeleteMovieUseCase(get()));
  get.registerLazySingleton(() => GetMovieUseCase(get()));
  get.registerLazySingleton(() => QueryExamsUseCase(get()));

  // NOTE: repositories
  get.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(get(), get()));

  // NOTE: data-sources
  //get.registerLazySingleton<AttachmentLocalDataSource>(() => AttachmentLocalDataSourceImpl());

}
