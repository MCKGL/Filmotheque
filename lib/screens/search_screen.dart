import 'package:filmotheque/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:filmotheque/services/movie_service.dart';
import 'package:filmotheque/models/movie.dart';
import 'package:filmotheque/widgets/list_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final MovieService _movieService = MovieService();
  List<Movie> _searchResults = [];

  void _searchMovies() async {
    if (_controller.text.isNotEmpty) {
      final results = await _movieService.searchMovies(_controller.text);
      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: _searchMovies,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      drawer: const AppDrawer(),
      body: ListWidget(movies: _searchResults),
    );
  }
}