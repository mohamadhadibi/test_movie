import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'models/movie_cache_model.dart';

abstract class MovieCacheDataSource {
  Future<List<MovieCacheModel>> query(QueryMovieParams params);

  Future<bool> create(SubmitMovieParams params);

  Future<bool> delete(DeleteMovieParams params);
}