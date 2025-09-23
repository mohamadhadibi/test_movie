   import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';

class MovieRemoteModel {
    final bool? adult;
    final String? backdrop_path;
    final List<int>? genre_ids;
    final int? id;
    final String? original_language;
    final String? original_title;
    final String? overview;
    final double? popularity;
    final String? poster_path;
    final String? release_date;
    final String? title;
    final bool? video;
    final double? vote_average;
    final int? vote_count;

    MovieRemoteModel({
      this.adult,
      this.backdrop_path,
      this.genre_ids,
      this.id,
      this.original_language,
      this.original_title,
      this.overview,
      this.popularity,
      this.poster_path,
      this.release_date,
      this.title,
      this.video,
      this.vote_average,
      this.vote_count,
    });

    MovieEntity toEntity() {
      return MovieEntity(
        id: id,
        title: title ?? original_title ?? '',
        description: overview ?? '',
        poster: poster_path?? '',
        rate: vote_average?? 0,
      );
    }

    static List<MovieEntity> listToEntity(List<MovieRemoteModel> list) {
      return list.map((remote) => remote.toEntity()).toList();
    }

    factory MovieRemoteModel.fromJson(Map<dynamic, dynamic> json) {
      return MovieRemoteModel(
        adult: json['adult'] as bool?,
        backdrop_path: json['backdrop_path'] as String?,
        genre_ids: (json['genre_ids'] as List?)?.whereType<int>().toList(),
        id: json['id'] as int?,
        original_language: json['original_language'] as String?,
        original_title: json['original_title'] as String?,
        overview: json['overview'] as String?,
        popularity: (json['popularity'] as num?)?.toDouble(),
        poster_path: json['poster_path'] as String?,
        release_date: json['release_date'] as String?,
        title: json['title'] as String?,
        video: json['video'] as bool?,
        vote_average: (json['vote_average'] as num?)?.toDouble(),
        vote_count: json['vote_count'] as int?,
      );
    }
}

   