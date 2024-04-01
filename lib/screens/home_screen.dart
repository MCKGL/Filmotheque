import 'package:filmotheque/widgets/list_widget.dart';
import 'package:filmotheque/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/movie.dart';
import '../services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late is used to declare a non-nullable variable that will be initialized later.
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = MovieService().getTrendingMovies();
    topRatedMovies = MovieService().getTopRatedMovies();
    upcomingMovies = MovieService().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Movies',
                style: GoogleFonts.aBeeZee(
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  child: FutureBuilder(
                      future: trendingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          if (snapshot.hasData) {
                            return SliderWidget(snapshot: snapshot);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Top Rated Movies',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  child: FutureBuilder(
                      future: topRatedMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          if (snapshot.hasData) {
                            return ListWidget(snapshot: snapshot);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Upcoming Movies',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  child: FutureBuilder(
                      future: upcomingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          if (snapshot.hasData) {
                            return ListWidget(snapshot: snapshot);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
