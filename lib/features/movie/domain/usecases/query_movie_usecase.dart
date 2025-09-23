import 'package:dartz/dartz.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/core/utils/usecase.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';

class QueryMoviesUseCase implements UseCase<List<MovieEntity>, QueryMovieParams> {
  final MovieRepository repository;

  QueryMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(QueryMovieParams params) async {
    return await repository.query(params);
  }
}
