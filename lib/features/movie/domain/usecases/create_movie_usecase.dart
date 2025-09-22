import 'package:dartz/dartz.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/core/utils/usecase.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';

class CreateMovieUseCase implements UseCase<bool, CreateMovieParams> {
  final MovieRepository repository;

  CreateMovieUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CreateMovieParams params) async {
    return await repository.create(params);
  }
}
