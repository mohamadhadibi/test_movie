import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:test_movie/features/movie/data/models/movie_cache_model.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'package:test_movie/features/movie/data/movie_cache_datasource_impl.dart';

class MockMovieCacheBox extends Mock implements Box<MovieCacheModel> {}
class MovieCacheModelFake extends Fake implements MovieCacheModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(MovieCacheModelFake());
  });

  late MockMovieCacheBox box;
  late MovieCacheDataSourceImpl dataSource;

  setUp(() {
    box = MockMovieCacheBox();
    dataSource = MovieCacheDataSourceImpl(box);
  });

  group('MovieCacheDataSourceImpl', () {
    test('create stores movie with int key', () async {
      when(() => box.put(any(), any())).thenAnswer((_) async {});
      final params = SubmitMovieParams(id: 1, title: 'Test');

      final result = await dataSource.create(params);

      expect(result, true);
      verify(() => box.put(any(), any())).called(1);
    });

    test('delete removes movie by int key', () async {
      when(() => box.delete(any())).thenAnswer((_) async {});
      final params = DeleteMovieParams(movieId: 1);

      final result = await dataSource.delete(params);

      expect(result, true);
      verify(() => box.delete(any())).called(1);
    });

    test('query returns values.toList()', () async {
      final values = <MovieCacheModel>[
        MovieCacheModel(id: 1, title: 'A'),
        MovieCacheModel(id: 2, title: 'B'),
      ];
      when(() => box.values).thenReturn(values);

      final result = await dataSource.query(QueryMovieParams(page: 1));

      expect(result.length, 2);
      expect(result.first.title, 'A');
      verify(() => box.values).called(1);
    });
  });
}
