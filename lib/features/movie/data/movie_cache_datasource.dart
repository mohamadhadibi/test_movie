import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';

abstract class MovieCacheDatasource {
  Future<List<MovieEntity>> query(QueryMovieParams params);

  Future<bool> create(CreateMovieParams params);

  Future<bool> delete(DeleteMovieParams params);
}