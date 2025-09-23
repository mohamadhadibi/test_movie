import 'package:dartz/dartz.dart';
import '/core/error/failure.dart';
import '../entities/movie_entity.dart';
import 'params.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieEntity>> get(GetMovieParams params);

  Future<Either<Failure, List<MovieEntity>>> query(QueryMovieParams params);

  Future<Either<Failure, bool>> create(SubmitMovieParams params);

  Future<Either<Failure, bool>> delete(DeleteMovieParams params);
}
