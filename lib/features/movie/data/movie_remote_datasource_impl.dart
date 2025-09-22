import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'movie_remote_datasource.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  //final NetworkInfo networkInfo;
  final TMDB tmdb;

  MovieRemoteDataSourceImpl(this.tmdb);

  @override
  Future<MovieEntity> get(GetMovieParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      Response response = await tmdb.('exam/get/${params.examId}');
      try {
        Exam model = Exam.fromJson(response.data["data"]);
        return Future.value(model);
      } catch (e) {
        throw ParseFailure();
      }
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
  Future<List<Exam>> query(QueryExamParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      Response response = await dio.get('exam/query', queryParameters: {
        "page": params.page,
      });
      try {
        try {
          List<Exam> model = getDataListFromJson<Exam>(
              response.data, (jsonItem) => Exam.fromJson(jsonItem));
          return Future.value(model);
        } catch (e) {
          throw ParseFailure();
        }
      } catch (e) {
        throw ParseFailure();
      }
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
