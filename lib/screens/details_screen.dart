import 'package:filmotheque/colors.dart';
import 'package:filmotheque/env.dart';
import 'package:filmotheque/models/movie.dart';
import 'package:filmotheque/utils/format_tools.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar.large(
        leading: const BackButton(),
        backgroundColor: Colours.scaffoldBgColor,
        expandedHeight: 350,
        pinned: true,
        floating: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.collections),
            onPressed: () {
              // TODO Handle the action here
            },
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
            title: Text(
              movie.title,
              style: GoogleFonts.belleza(
                  fontSize: 17, fontWeight: FontWeight.w600),
            ),
            background: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.network(
                '${Env.IMAGE_PATH}${movie.backdropPath}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            )),
      ),
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              'Overview',
              style: GoogleFonts.openSans(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.overview,
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Release Date: ',
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          FormatTools.formatDateToString(movie.releaseDate),
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(children: [
                          IconButton(
                            icon: const Icon(Icons.bookmark_border, color: Colors.grey),
                            onPressed: () {
                              // TODO Handle the action here
                            },
                          ),
                        ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle_outline, color: Colors.grey),
                            onPressed: () {
                              // TODO Handle the action here
                            },
                          ),
                        ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    ]));
  }
}
