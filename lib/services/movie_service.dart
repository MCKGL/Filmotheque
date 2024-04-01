import 'dart:convert';
import '../env.dart';
import '../models/movie.dart';
import 'package:http/http.dart' as http;

class MovieService {

  /**
   * the method getTrendingMovies() returns a list of trending movies
   * asynchronously.
   */
  Future<List<Movie>> getTrendingMovies() async{
    final response = await http.get(
        Uri.parse(Env.TRENDING),
      headers: {
        'Authorization': 'Bearer ${Env.TOKEN}',
        'accept': 'application/json',
      }
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async{
    final response = await http.get(
        Uri.parse(Env.TOP_RATED),
        headers: {
          'Authorization': 'Bearer ${Env.TOKEN}',
          'accept': 'application/json',
        }
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async{
    final response = await http.get(
        Uri.parse(Env.UPCOMING),
        headers: {
          'Authorization': 'Bearer ${Env.TOKEN}',
          'accept': 'application/json',
        }
    );
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }
}