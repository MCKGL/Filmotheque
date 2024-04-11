import 'package:filmotheque/models/movie.dart';
import 'package:filmotheque/services/movie_service.dart';
import 'package:filmotheque/widgets/app_drawer.dart';
import 'package:filmotheque/widgets/list_widget.dart';
import 'package:flutter/material.dart';

class WatchedScreen extends StatefulWidget {
  const WatchedScreen({super.key});

  @override
  State<WatchedScreen> createState() => _WatchedScreenState();
}

class _WatchedScreenState extends State<WatchedScreen> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _moviesWatched;

  @override
  void initState() {
    super.initState();
    _moviesWatched = _movieService.getWatchedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watched Movies'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<Movie>>(
        future: _moviesWatched,
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

