import 'package:filmotheque/env.dart';
import 'package:filmotheque/models/movie.dart';
import 'package:filmotheque/services/movie_service.dart';
import 'package:filmotheque/utils/format_tools.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isInCollection = false;
  bool _isInToWatch = false;
  bool _isInWatched = false;
  final _movieService = MovieService();

  @override
  void initState() {
    super.initState();
    _checkIfMovieInList(
        Env.COLLECTION_LIST_ID, (value) => _isInCollection = value);
    _checkIfMovieInList(
        Env.TO_WATCH_LIST_ID, (value) => _isInToWatch = value);
    _checkIfMovieInList(Env.WATCHED_LIST_ID, (value) => _isInWatched = value);
  }

  Future<void> _checkIfMovieInList(
      int listId, ValueSetter<bool> setStateValue) async {
    bool isInList = await _movieService.isMovieInList(listId, widget.movie.id);
    setState(() {
      setStateValue(isInList);
    });
  }

  Future<void> _toggleMovieInList(int listId, ValueGetter<bool> getStateValue,
      ValueSetter<bool> setStateValue) async {
    if (getStateValue()) {
      await _movieService.removeMovieFromList(listId, widget.movie.id);
    } else {
      await _movieService.addMovieToList(listId, widget.movie.id);
    }
    setState(() {
      setStateValue(!getStateValue());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar.large(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const BackButton(),
        expandedHeight: 350,
        pinned: true,
        floating: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.collections,
              color: _isInCollection ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              _toggleMovieInList(Env.COLLECTION_LIST_ID, () => _isInCollection,
                  (value) => _isInCollection = value);
            },
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.movie.title,
              style: GoogleFonts.belleza(
                  fontSize: 17, fontWeight: FontWeight.w600),
            ),
            background: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.network(
                '${Env.IMAGE_PATH}${widget.movie.backdropPath}',
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
              widget.movie.overview,
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
                          FormatTools.formatDateToString(
                              widget.movie.releaseDate),
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
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.bookmark_border,
                                color: _isInToWatch ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                _toggleMovieInList(
                                    Env.TO_WATCH_LIST_ID,
                                    () => _isInToWatch,
                                    (value) => _isInToWatch = value);
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
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.check_circle_outline,
                                color:
                                    _isInWatched ? Colors.green : Colors.grey,
                              ),
                              onPressed: () {
                                _toggleMovieInList(
                                    Env.WATCHED_LIST_ID,
                                    () => _isInWatched,
                                    (value) => _isInWatched = value);
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
