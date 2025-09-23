List<T> getDataListFromJson<T>(Map<String, dynamic> json, Function fromJson) =>
    List<T>.from(json["data"].map((x) => fromJson(x)));

const String hiveMovie = "HIVE_MOVIE";