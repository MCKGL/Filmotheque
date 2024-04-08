import 'package:filmotheque/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:filmotheque/services/movie_service.dart';
import 'package:filmotheque/widgets/list_widget.dart';

class ToWatchScreen extends StatefulWidget {
  const ToWatchScreen({super.key});

  @override
  State<ToWatchScreen> createState() => _ToWatchScreenState();
}

class _ToWatchScreenState extends State<ToWatchScreen> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _moviesToWatch;

  @override
  void initState() {
    super.initState();
    _moviesToWatch = _movieService.getToWatchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Watch Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _moviesToWatch,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListWidget(movies: snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}