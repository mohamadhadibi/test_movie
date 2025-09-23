import 'package:dio/dio.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/core/extentions/ext_int.dart';
import 'package:test_movie/features/movie/data/models/movie_remote_detail_model.dart';
import 'package:test_movie/features/movie/data/models/movie_remote_model.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'movie_remote_datasource.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  //final NetworkInfo networkInfo;
  final TMDB tmdb;

  MovieRemoteDataSourceImpl(this.tmdb);

  @override
  Future<MovieRemoteDetailModel> get(GetMovieParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
        final json = await tmdb.v3.movies.getDetails(params.movieId);
        return MovieRemoteDetailModel.fromJson(json);
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }

  @override
  Future<List<MovieRemoteModel>> query(QueryMovieParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      Map<dynamic, dynamic> json;
      if (params.text != null && params.text!.isNotEmpty) {
        json = await tmdb.v3.search.queryMovies(params.text!, page: params.page);
      } else {
        json = await tmdb.v3.movies.getPopular(page: params.page);
      }
      final results = (json['results'] as List?) ?? const [];
      return results
          .whereType<Map<dynamic, dynamic>>()
          .map(MovieRemoteModel.fromJson)
          .toList();
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }

}
