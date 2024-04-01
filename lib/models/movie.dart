class Movie {
  int id;
  String title;
  String originalTitle;
  String overview;
  String posterPath;
  String backdropPath;
  DateTime releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
  });

  /**
   * A factory constructor that creates a Movie instance from a JSON object.
   * We use Map with String keys and dynamic values to represent JSON objects.
   * Dynamic means that the value can be of any type.
   */
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? "Title not available",
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: DateTime.parse(json['release_date']),
    );
  }

  /**
   * A method that converts a Movie instance into a JSON object.
   * No need here.
   */
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate.toIso8601String(),
    };
  }

}