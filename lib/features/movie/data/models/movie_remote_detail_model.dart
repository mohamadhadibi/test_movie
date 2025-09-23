import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';

class MovieRemoteDetailModel {
    final String? backdrop_path;
    final String? homepage;
    final int? id;
    final String? original_title;
    final String? overview;
    final String? poster_path;
    final String? release_date;
    final String? title;
    final double? vote_average;
    final int? vote_count;

    MovieRemoteDetailModel({
      this.backdrop_path,
      this.homepage,
      this.id,
      this.original_title,
      this.overview,
      this.poster_path,
      this.release_date,
      this.title,
      this.vote_average,
      this.vote_count,
    });

    MovieEntity toEntity() {
      return MovieEntity(
        id: id,
        title: title ?? original_title ?? '',
        description: overview ?? '',
        poster: (poster_path!= null) ? 'https://image.tmdb.org/t/p/w500$poster_path' :null,
        rate: vote_average?? 0,
      );
    }

    factory MovieRemoteDetailModel.fromJson(Map<dynamic, dynamic> json) {
      return MovieRemoteDetailModel(
        backdrop_path: json['backdrop_path'] as String?,
        homepage: json['homepage'] as String?,
        id: json['id'] as int?,
        original_title: json['original_title'] as String?,
        overview: json['overview'] as String?,
        poster_path: json['poster_path'] as String?,
        release_date: json['release_date'] as String?,
        title: json['title'] as String?,
        vote_average: (json['vote_average'] as num?)?.toDouble(),
        vote_count: json['vote_count'] as int?,
      );
    }
  }