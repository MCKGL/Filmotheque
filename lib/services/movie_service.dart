import 'dart:convert';
import '../env.dart';
import '../models/movie.dart';
import 'package:http/http.dart' as http;

class MovieService {

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(Env.TRENDING), headers: {
      'Authorization': 'Bearer ${Env.TOKEN}',
      'accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<Movie>> getWatchedMovies() async {
    final response = await http.get(Uri.parse(Env.WATCHED), headers: {
      'Authorization': 'Bearer ${Env.TOKEN}',
      'accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['items'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load watched movies');
    }
  }

  Future<List<Movie>> getToWatchMovies() async {
    final response = await http.get(Uri.parse(Env.TO_WATCH), headers: {
      'Authorization': 'Bearer ${Env.TOKEN}',
      'accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['items'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load watched movies');
    }
  }

  Future<List<Movie>> getCollection() async {
    final response = await http.get(Uri.parse(Env.COLLECTION), headers: {
      'Authorization': 'Bearer ${Env.TOKEN}',
      'accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['items'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load watched movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    String formattedQuery = query.replaceAll(' ', '%20');
    final response =
        await http.get(Uri.parse(Env.searchMovie(formattedQuery)), headers: {
      'Authorization': 'Bearer ${Env.TOKEN}',
      'accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load searched movies');
    }
  }

  Future<void> addMovieToList(int listId, int movieId) async {
    final response = await http.post(
      Uri.parse(Env.addMovieToList(listId)),
      headers: {
        'Authorization': 'Bearer ${Env.TOKEN}',
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "media_id": movieId,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add movie to list');
    }
  }

  Future<void> removeMovieFromList(int listId, int movieId) async {
    final response = await http.post(
      Uri.parse(Env.removeMovieFromList(listId)),
      headers: {
        'Authorization': 'Bearer ${Env.TOKEN}',
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "media_id": movieId,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to remove movie from list');
    }
  }

  Future<bool> isMovieInList(int listId, int movieId) async {
    final response = await http.get(
      Uri.parse(Env.isMovieInList(listId, movieId)),
      headers: {
        'Authorization': 'Bearer ${Env.TOKEN}',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return decodedData['item_present'];
    } else {
      throw Exception('Failed to check if movie is in list');
    }
  }
}
