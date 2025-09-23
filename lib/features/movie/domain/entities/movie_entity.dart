class MovieEntity {
  int? id;
  String? title;
  String? description;
  String? poster;
  double? rate;


  MovieEntity({
    this.id,
    this.title,
    this.description,
    this.poster,
    this.rate,
  });

  MovieEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? poster,
    double? rate,
  }) {
    return MovieEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      poster: poster ?? this.poster,
      rate: rate ?? this.rate,
    );
  }
}
