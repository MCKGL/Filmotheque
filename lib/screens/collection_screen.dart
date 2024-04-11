import 'package:filmotheque/models/movie.dart';
import 'package:filmotheque/services/movie_service.dart';
import 'package:filmotheque/widgets/app_drawer.dart';
import 'package:filmotheque/widgets/list_widget.dart';
import 'package:flutter/material.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _collection;

  @override
  void initState() {
    super.initState();
    _collection = _movieService.getCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<Movie>>(
        future: _collection,
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
