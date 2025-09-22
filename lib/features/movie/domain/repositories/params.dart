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
class CreateMovieParams {}
class DeleteMovieParams {}
