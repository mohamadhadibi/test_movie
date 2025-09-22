class MovieEntity {
  String? id;
  String? title;

  MovieEntity({
    this.id,
    this.title,
  });

  MovieEntity copyWith({
    String? id,
    String? title,
  }) {
    return MovieEntity(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
