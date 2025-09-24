import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/features/movie/data/models/movie_cache_model.dart';
import 'package:test_movie/features/movie/data/models/movie_remote_detail_model.dart';
import 'package:test_movie/features/movie/data/models/movie_remote_model.dart';
import 'package:test_movie/features/movie/data/movie_cache_datasource.dart';
import 'package:test_movie/features/movie/data/movie_remote_datasource.dart';
import 'package:test_movie/features/movie/data/movie_repository_impl.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';

class MockRemoteDataSource extends Mock implements MovieRemoteDataSource {}
class MockCacheDataSource extends Mock implements MovieCacheDataSource {}

class GetMovieParamsFake extends Fake implements GetMovieParams {}
class QueryMovieParamsFake extends Fake implements QueryMovieParams {}

void main() {
  setUpAll(() {
    registerFallbackValue(GetMovieParamsFake());
    registerFallbackValue(QueryMovieParamsFake());
  });

  late MockRemoteDataSource remote;
  late MockCacheDataSource cache;
  late MovieRepositoryImpl repo;

  setUp(() {
    remote = MockRemoteDataSource();
    cache = MockCacheDataSource();
    repo = MovieRepositoryImpl(remote, cache);
  });

  group('MovieRepositoryImpl', () {
    test('query returns cache entities when isFavorite=true', () async {
      when(() => cache.query(any())).thenAnswer((_) async => [
        MovieCacheModel(id: 1, title: 'Cached 1'),
        MovieCacheModel(id: 2, title: 'Cached 2'),
      ]);

      final result = await repo.query(QueryMovieParams(isFavorite: true, page: 1));

      expect(result.isRight(), true);
      final list = result.getOrElse(() => []);
      expect(list.length, 2);
      expect(list.first, isA<MovieEntity>());
      expect(list.first.title, 'Cached 1');
      verify(() => cache.query(any(that: isA<QueryMovieParams>()))).called(1);
      verifyNever(() => remote.query(any()));
    });

    test('query returns remote entities when isFavorite=false', () async {
      when(() => remote.query(any())).thenAnswer((_) async => [
        MovieRemoteModel(id: 10, title: 'Remote 10'),
        MovieRemoteModel(id: 11, title: 'Remote 11'),
      ]);

      final result = await repo.query(QueryMovieParams(isFavorite: false, page: 1));

      expect(result.isRight(), true);
      final list = result.getOrElse(() => []);
      expect(list.length, 2);
      expect(list.first.title, 'Remote 10');
      verify(() => remote.query(any(that: isA<QueryMovieParams>()))).called(1);
      verifyNever(() => cache.query(any()));
    });

    test('get returns entity converted from remote detail model', () async {
      when(() => remote.get(any())).thenAnswer((_) async => MovieRemoteDetailModel(
        id: 42,
        title: 'The Answer',
        overview: 'Life, Universe, Everything',
        poster_path: 'poster.png',
        vote_average: 9.9,
      ));

      final result = await repo.get(GetMovieParams(movieId: 42));

      expect(result.isRight(), true);
      final entity = result.getOrElse(() => MovieEntity());
      expect(entity.id, 42);
      expect(entity.title, 'The Answer');
      expect(entity.description, 'Life, Universe, Everything');
      expect(entity.poster, 'https://image.tmdb.org/t/p/w500poster.png');
      expect(entity.rate, 9.9);
      verify(() => remote.get(any(that: isA<GetMovieParams>()))).called(1);
    });

    test('query returns Failure on exception', () async {
      when(() => remote.query(any())).thenThrow(ServerFailure());

      final result = await repo.query(QueryMovieParams(isFavorite: false, page: 1));

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => UnknownFailure()), isA<ServerFailure>());
    });
  });
}
