import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_movie/core/utils/api_constants.dart';
import 'package:test_movie/core/utils/utils.dart';
import 'package:test_movie/features/movie/data/models/movie_cache_model.dart';
import 'package:test_movie/features/movie/data/movie_cache_datasource.dart';
import 'package:test_movie/features/movie/data/movie_cache_datasource_impl.dart';
import 'package:test_movie/features/movie/data/movie_remote_datasource.dart';
import 'package:test_movie/features/movie/data/movie_remote_datasource_impl.dart';
import 'package:test_movie/features/movie/presentation/pages/favorites/movie_favorites_cubit.dart';
import 'package:test_movie/features/movie/presentation/pages/info/movie_info_cubit.dart';
import 'package:test_movie/features/movie/presentation/pages/list/movie_list_cubit.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:test_movie/app/application_cubit.dart';
import 'package:test_movie/features/movie/data/movie_repository_impl.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/usecases/submit_movie_usecase.dart';
import 'package:test_movie/features/movie/domain/usecases/delete_movie_usecase.dart';
import 'package:test_movie/features/movie/domain/usecases/get_movie_usecase.dart';
import 'package:test_movie/features/movie/domain/usecases/query_movie_usecase.dart';

final get = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieCacheModelAdapter());
  final movieCacheBox = await Hive.openBox<MovieCacheModel>(hiveMovie);
  get.registerLazySingleton<Box<MovieCacheModel>>(() => movieCacheBox);

  final tmdb = TMDB(
    ApiKeys(tmdbApiKey, tmdbToken),
    logConfig: const ConfigLogger.showAll(),
  );
  get.registerLazySingleton<TMDB>(() => tmdb);

  // NOTE: cubits
  get.registerFactory(() => ApplicationCubit());
  get.registerFactory(() => MovieListCubit(get()));
  get.registerFactory(() => MovieInfoCubit(get(), get(), get()));
  get.registerFactory(() => MovieFavoritesCubit(get(), get()));

  // NOTE: use-cases
  get.registerLazySingleton(() => SubmitMovieUseCase(get()));
  get.registerLazySingleton(() => DeleteMovieUseCase(get()));
  get.registerLazySingleton(() => GetMovieUseCase(get()));
  get.registerLazySingleton(() => QueryMoviesUseCase(get()));

  // NOTE: repositories
  get.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(get(), get()),
  );

  // NOTE: data-sources
  get.registerLazySingleton<MovieCacheDataSource>(
    () => MovieCacheDataSourceImpl(get()),
  );
  get.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(get()),
  );
}
