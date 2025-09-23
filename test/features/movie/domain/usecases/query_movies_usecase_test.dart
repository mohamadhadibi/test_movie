import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'package:test_movie/features/movie/domain/usecases/query_movie_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(QueryMovieParams(page: 0, text: 'hi'));
  });
  late MockMovieRepository repo;
  late QueryMoviesUseCase usecase;

  setUp(() {
    repo = MockMovieRepository();
    usecase = QueryMoviesUseCase(repo);
  });

  test('returns Right(List<MovieEntity>) from repository', () async {
    final list = [MovieEntity(id: 1, title: 'A'), MovieEntity(id: 2, title: 'B')];
    when(() => repo.query(any())).thenAnswer((_) async => Right(list));

    final result = await usecase.call(QueryMovieParams(page: 1, isFavorite: false));

    expect(result.isRight(), true);
    expect(result.getOrElse(() => []), hasLength(2));
    verify(() => repo.query(any())).called(1);
  });

  test('returns Left(Failure) on error', () async {
    when(() => repo.query(any())).thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase.call(QueryMovieParams(page: 1));

    expect(result.isLeft(), true);
    expect(result.swap().getOrElse(() => UnknownFailure()), isA<ServerFailure>());
  });
}
