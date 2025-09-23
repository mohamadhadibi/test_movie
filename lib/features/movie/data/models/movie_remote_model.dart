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
   }

   