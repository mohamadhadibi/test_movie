import 'package:dartz/dartz.dart';
import 'package:test_movie/features/movie/data/models/movie_cache_model.dart';
import 'package:test_movie/features/movie/data/models/movie_remote_detail_model.dart';
import 'package:test_movie/features/movie/data/models/movie_remote_model.dart';
import 'package:test_movie/features/movie/data/movie_cache_datasource.dart';
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
      MovieRemoteDetailModel movie = await _remoteDataSource.get(params);
      return Right(movie.toEntity());
    } catch (e) {
      return Left(e is Failure ? e : UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> query(QueryMovieParams params) async {
    try {
      List<MovieEntity> movies = [];
      if (params.isFavorite?? false) {
        List<MovieCacheModel> cacheList = await _cacheDataSource.query(params);
        movies = MovieCacheModel.listToEntity(cacheList);
      } else {
        List<MovieRemoteModel> remoteList = await _remoteDataSource.query(params);
        movies = MovieRemoteModel.listToEntity(remoteList);
      }
      return Right(movies);
    } catch (e) {
      return Left(e is Failure ? e : UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> create(SubmitMovieParams params) async {
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
