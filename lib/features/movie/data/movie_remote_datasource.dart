import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';

abstract class MovieRemoteDataSource {
  Future<MovieEntity> get(GetMovieParams params);

  Future<List<MovieEntity>> query(QueryMovieParams params);
}