import 'package:test_movie/features/movie/data/models/movie_remote_detail_model.dart';
import 'package:test_movie/features/movie/data/models/movie_remote_model.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';

abstract class MovieRemoteDataSource {
  Future<MovieRemoteDetailModel> get(GetMovieParams params);

  Future<List<MovieRemoteModel>> query(QueryMovieParams params);
}