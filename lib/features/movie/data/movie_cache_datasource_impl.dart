import 'package:hive_flutter/adapters.dart';
import '/features/movie/data/models/movie_cache_model.dart';
import '/features/movie/domain/repositories/params.dart';
import 'movie_cache_datasource.dart';

class MovieCacheDataSourceImpl implements MovieCacheDataSource {
  MovieCacheDataSourceImpl(this._box);
  final Box<MovieCacheModel> _box;

  @override
  Future<bool> create(SubmitMovieParams params) async {

    try {
      _box.put(
        params.id.toString(),
        MovieCacheModel(
          id: params.id,
          title: params.title,
          description: params.description,
          rate: params.rate,
          poster: params.poster,
        ),
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(DeleteMovieParams params) async {
    try{
      _box.delete(params.movieId.toString());
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MovieCacheModel>> query(QueryMovieParams params) async {
    return _box.values.toList();
  }

}
