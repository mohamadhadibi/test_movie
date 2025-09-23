import 'package:hive/hive.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'dart:core';

part 'movie_cache_model.g.dart';

@HiveType(typeId: 1)
class MovieCacheModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? poster;

  @HiveField(4)
  final double? rate;

  const MovieCacheModel({
    this.id,
    this.title,
    this.description,
    this.poster,
    this.rate,
  });

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      description: description,
      poster: poster,
      rate: rate,
    );
  }

  static List<MovieEntity> listToEntity(List<MovieCacheModel> list) {
    return list.map((cache) => cache.toEntity()).toList();
  }
}
