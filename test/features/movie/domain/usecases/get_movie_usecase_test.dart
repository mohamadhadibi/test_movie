import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'package:test_movie/features/movie/domain/usecases/get_movie_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(GetMovieParams(movieId: 1));
  });

  late MockMovieRepository repo;
  late GetMovieUseCase usecase;

  setUp(() {
    repo = MockMovieRepository();
    usecase = GetMovieUseCase(repo);
  });

  test('returns Right(MovieEntity) from repository', () async {
    final entity = MovieEntity(id: 1, title: 'Test');
    when(() => repo.get(any())).thenAnswer((_) async => Right(entity));

    final result = await usecase.call(GetMovieParams(movieId: 1));

    expect(result.isRight(), true);
    expect(result.getOrElse(() => MovieEntity()).title, 'Test');
    verify(() => repo.get(any())).called(1);
  });

  test('returns Left(Failure) on error', () async {
    when(() => repo.get(any())).thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase.call(GetMovieParams(movieId: 1));

    expect(result.isLeft(), true);
    expect(result.swap().getOrElse(() => UnknownFailure()), isA<ServerFailure>());
  });
}
