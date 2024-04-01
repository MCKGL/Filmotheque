import 'package:filmotheque/screens/details_screen.dart';
import 'package:flutter/material.dart';

import '../env.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      movie: snapshot.data[index],
                                    )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                            height: 200,
                            width: 150,
                            child: Image.network(
                              '${Env.IMAGE_PATH}${snapshot.data[index].posterPath}',
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            )),
                      )));
            }));
  }
}
