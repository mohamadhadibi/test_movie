import 'package:flutter_test/flutter_test.dart';
import 'package:test_movie/features/movie/data/models/movie_cache_model.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';

void main() {
  group('MovieCacheModel', () {
    test('toEntity converts correctly', () {
      final cache = MovieCacheModel(
        id: 1,
        title: 'Test',
        description: 'Desc',
        poster: 'poster.png',
        rate: 8.5,
      );

      final entity = cache.toEntity();

      expect(entity, isA<MovieEntity>());
      expect(entity.id, 1);
      expect(entity.title, 'Test');
      expect(entity.description, 'Desc');
      expect(entity.poster, 'poster.png');
      expect(entity.rate, 8.5);
    });

    test('listToEntity converts list correctly', () {
      final list = [
        MovieCacheModel(id: 1, title: 'A'),
        MovieCacheModel(id: 2, title: 'B'),
      ];

      final entities = MovieCacheModel.listToEntity(list);

      expect(entities.length, 2);
      expect(entities[0].title, 'A');
      expect(entities[1].title, 'B');
    });
  });
}
