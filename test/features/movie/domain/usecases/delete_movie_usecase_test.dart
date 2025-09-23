import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'package:test_movie/features/movie/domain/usecases/delete_movie_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(DeleteMovieParams(movieId: 0));
  });

  late MockMovieRepository repo;
  late DeleteMovieUseCase usecase;

  setUp(() {
    repo = MockMovieRepository();
    usecase = DeleteMovieUseCase(repo);
  });

  test('returns Right(true) on success', () async {
    when(() => repo.delete(any())).thenAnswer((_) async => const Right(true));

    final result = await usecase.call(DeleteMovieParams(movieId: 1));

    expect(result.isRight(), true);
    expect(result.getOrElse(() => false), true);
    verify(() => repo.delete(any())).called(1);
  });

  test('returns Left(Failure) on error', () async {
    when(() => repo.delete(any())).thenAnswer((_) async => Left(CacheFailure()));

    final result = await usecase.call(DeleteMovieParams(movieId: 1));

    expect(result.isLeft(), true);
    expect(result.swap().getOrElse(() => UnknownFailure()), isA<CacheFailure>());
  });
}
