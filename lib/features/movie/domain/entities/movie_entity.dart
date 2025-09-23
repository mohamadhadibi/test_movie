class MovieEntity {
  int? id;
  String? title;
  String? description;
  String? poster;
  double? rate;
  bool? isFav;

  MovieEntity({
    this.id,
    this.title,
    this.description,
    this.poster,
    this.rate,
    this.isFav
  });

  MovieEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? poster,
    double? rate,
    bool? isFav
  }) {
    return MovieEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      poster: poster ?? this.poster,
      rate: rate ?? this.rate,
      isFav: isFav ?? this.isFav,
    );
  }

  void setIsFav(bool fav) => isFav = fav;

  bool getIsFav() => isFav?? false;

}
