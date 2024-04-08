import 'package:filmotheque/models/movie.dart';
import 'package:filmotheque/screens/details_screen.dart';
import 'package:filmotheque/env.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final List<Movie> movies;

  const ListWidget({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      movie: movies[index],
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: Image.network('${Env.IMAGE_PATH}${movies[index].posterPath}'),
                title: Text(movies[index].title),
              ),
            ),
          );
        },
      ),
    );
  }
}