import 'package:dartz/dartz.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/core/utils/usecase.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';

class DeleteMovieUseCase implements UseCase<bool, DeleteMovieParams> {
  final MovieRepository repository;

  DeleteMovieUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteMovieParams params) async {
    return await repository.delete(params);
  }
}
