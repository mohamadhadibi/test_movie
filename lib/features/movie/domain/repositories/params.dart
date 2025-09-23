class GetMovieParams {
  int movieId;
  GetMovieParams({
    required this.movieId,
  });
}
class QueryMovieParams {
  bool? isFavorite;
  int page;
  String? text;

  QueryMovieParams({
    this.isFavorite,
    required this.page,
    this.text,
  });
}
class SubmitMovieParams {
  int? id;
  String? title;
  String? description;
  String? poster;
  double? rate;

  SubmitMovieParams({
    this.id,
    this.title,
    this.description,
    this.poster,
    this.rate,
  });
}
class DeleteMovieParams {
  int movieId;
  DeleteMovieParams({
    required this.movieId,
  });
}
