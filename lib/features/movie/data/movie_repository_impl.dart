import 'package:dartz/dartz.dart';
import 'package:test_movie/features/movie/data/movie_remote_datasource.dart';
import '/core/error/failure.dart';
import '/features/movie/domain/entities/movie_entity.dart';
import '/features/movie/domain/repositories/movie_repository.dart';
import '/features/movie/domain/repositories/params.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;
  final MovieCacheDataSource _cacheDataSource;

  MovieRepositoryImpl(
    this._remoteDataSource,
    this._cacheDataSource,
  );

  @override
  Future<Either<Failure, MovieEntity>> get(GetMovieParams params) async {
    try {
      MovieEntity movie = await _remoteDataSource.get(params);
      return Right(movie);
    } catch (e) {
      return Left(e is Failure ? e : UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> query(QueryMovieParams params) async {
    try {
      List<MovieEntity> movies = [];
      if (params.isFavorite?? false) {
        var cacheMovies = await _cacheDataSource.getAll();
        movies = cacheMovies;// FIXME: convert objects
      } else {
        var onlineMovies = await _remoteDataSource.query(params);
        movies = onlineMovies;// FIXME: convert objects
      }
      return Right(movies);
    } catch (e) {
      return Left(e is Failure ? e : UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> create(CreateMovieParams params) async {
    try {
      await _cacheDataSource.create(params);
      return Right(true);
    } catch (e) {
      return Left(e is Failure ? e : UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> delete(DeleteMovieParams params) async {
    try {
      await _cacheDataSource.delete(params);
      return const Right(true);
    } catch (e) {
      return Left(e is Failure ? e : UnknownFailure());
    }
  }
}
