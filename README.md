# filmotheque

This is a movie management application built with Flutter. It utilizes the TMDB API to provide a vast collection of movies for users to manage.

## Features

- **Movie Lists**: Users can consult their watched, to-watch and collection movie lists.
- **Movie Details**: Detailed information about each movie is available, including the release date, overview, and more.
- **Movie Search**: A search feature allows users to find specific movies.
- **Add to List**: Users can add movies to their watched or to-watch lists.
- **Remove from List**: Users can remove movies from their lists.

## Possible Improvements
- Session ID validity management (TMDB only provides a session ID valid for one hour).
- Better user connection management: currently the user must reconnect each time. This must be thought out with the previous point (at the risk of seeing the list management bug).
- Better management of adding to a list: currently the user must leave and return to their list to see it updated.

For more information on how to get started with this project, please refer to the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Setup

To run this application, you need to create a `env.dart` file in the `lib` directory. This file should define a class `Env` that contains constants and variables necessary for the application to function. Here is what you need to include in the `env.dart` file:

```dart
class Env {
  // TMDB API key and token
  static const API_KEY = '<Your TMDB API Key>';
  static const TOKEN = '<Your TMDB Token>';

  // TMDB authentication variables
  static String requestToken = "";
  static String sessionId = "";

  // URLs for TMDB authentication
  static const CREATE_REQUEST_TOKEN = 'https://api.themoviedb.org/3/authentication/token/new';
  static const CREATE_SESSION_LOGIN = 'https://api.themoviedb.org/3/authentication/token/validate_with_login';
  static const CREATE_SESSION = 'https://api.themoviedb.org/3/authentication/session/new';
  static const DELETE_SESSION = 'https://api.themoviedb.org/3/authentication/session';
  
  // URLs for TMDB API
  static const IMAGE_PATH = 'https://image.tmdb.org/t/p/w500';
  static const TRENDING = 'https://api.themoviedb.org/3/trending/movie/day?language=en-US';
  static const COLLECTION = 'https://api.themoviedb.org/3/list/...';
  static const WATCHED = 'https://api.themoviedb.org/3/list/...';
  static const TO_WATCH = 'https://api.themoviedb.org/3/list/...';
  // other endpoints for whatever you want...
  
  // IDs for various lists
  static const COLLECTION_LIST_ID = <Your Collection List ID>;
  static const WATCHED_LIST_ID = <Your Watched List ID>;
  static const TO_WATCH_LIST_ID = <Your To Watch List ID>;

  // URLs for searching movies
  static searchMovie (String elem) => 'https://api.themoviedb.org/3/search/movie?query=$elem&language=en-US';
  
  // URLs for adding and removing movies from lists
  static addMovieToList (int listId) => 'https://api.themoviedb.org/3/list/$listId/add_item?session_id=$sessionId';
  static removeMovieFromList (int listId) => 'https://api.themoviedb.org/3/list/$listId/remove_item?session_id=$sessionId';

  // URL for checking if a movie is in a list
  static isMovieInList (int listId, int movieId) => 'https://api.themoviedb.org/3/list/$listId/item_status?movie_id=$movieId';
}
```