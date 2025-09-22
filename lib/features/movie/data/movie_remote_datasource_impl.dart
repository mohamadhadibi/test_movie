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
        final response = await tmdb.v3.movies.getDetails(params.movieId);
        return Future.value(response as MovieRemoteDetailModel);
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
      if(params.text != null && params.text!.isNotEmpty){
        final response = await tmdb.v3.search.queryMovies(params.text!, page: params.page);
        return Future.value(response['result'] ?? []);
      } else {
        final response = await tmdb.v3.movies.getPopular(page: params.page);
        return Future.value(response['result'] ?? []);
      }
     /* List<Exam> model = getDataListFromJson<Exam>(
              response.data, (jsonItem) => Exam.fromJson(jsonItem));*/
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
