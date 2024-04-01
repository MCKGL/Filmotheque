import 'package:filmotheque/models/movie.dart';

class ListMovies {
  int id;
  List<Movie> movies;

  ListMovies({
    required this.id,
    required this.movies,
  });

  factory ListMovies.fromJson(Map<String, dynamic> json) {
    return ListMovies(
      id: json['id'],
      movies: (json['items'] as List).map((movie) => Movie.fromJson(movie)).toList(),
    );
  }

}