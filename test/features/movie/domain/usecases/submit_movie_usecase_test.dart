import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'package:test_movie/features/movie/domain/usecases/submit_movie_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(SubmitMovieParams(id: 1, title: 'X', description: ''));
  });
  late MockMovieRepository repo;
  late SubmitMovieUseCase usecase;

  setUp(() {
    repo = MockMovieRepository();
    usecase = SubmitMovieUseCase(repo);
  });

  test('returns Right(true) on success', () async {
    when(() => repo.create(any())).thenAnswer((_) async => const Right(true));

    final result = await usecase.call(SubmitMovieParams(id: 1, title: 'X'));

    expect(result.isRight(), true);
    expect(result.getOrElse(() => false), true);
    verify(() => repo.create(any())).called(1);
  });

  test('returns Left(Failure) on error', () async {
    when(() => repo.create(any())).thenAnswer((_) async => Left(CacheFailure()));

    final result = await usecase.call(SubmitMovieParams(id: 1));

    expect(result.isLeft(), true);
    expect(result.swap().getOrElse(() => UnknownFailure()), isA<CacheFailure>());
  });
}
