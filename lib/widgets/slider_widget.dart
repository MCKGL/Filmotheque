import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmotheque/screens/details_screen.dart';
import 'package:flutter/material.dart';

import '../env.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data.length,
        options: CarouselOptions(
          // aspectRatio: 16/9,
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(
                              movie: snapshot.data[itemIndex],
                            )));
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 300,
                    width: 200,
                    child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Env.IMAGE_PATH}${snapshot.data[itemIndex].posterPath}',
                    ),
                  )));
        },
      ),
    );
  }
}
