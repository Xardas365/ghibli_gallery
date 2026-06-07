import 'dart:convert';

import 'package:ghibli_gallery/features/films/domain/favorite_movie.dart';
import 'package:ghibli_gallery/features/films/domain/favorite_movie_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFavoriteMovieStorage implements FavoriteMovieStorage {
  const SharedPreferencesFavoriteMovieStorage({
    required SharedPreferences preferences,
    this.storageKey = defaultStorageKey,
  }) : _preferences = preferences;

  static const defaultStorageKey = 'films.favorite_movie_user_data.v1';

  final SharedPreferences _preferences;
  final String storageKey;

  @override
  Future<List<FavoriteMovie>> getAll() async {
    final moviesByFilmId = _readMoviesByFilmId();
    return moviesByFilmId.values.toList(growable: false);
  }

  @override
  Future<FavoriteMovie?> getByFilmId(String filmId) async {
    final moviesByFilmId = _readMoviesByFilmId();
    return moviesByFilmId[filmId];
  }

  @override
  Future<void> save(FavoriteMovie movie) async {
    final moviesByFilmId = _readMoviesByFilmId();
    moviesByFilmId[movie.filmId] = movie;
    await _writeMoviesByFilmId(moviesByFilmId);
  }

  @override
  Future<FavoriteMovie> setFavorite(
    String filmId, {
    required bool isFavorite,
  }) async {
    final moviesByFilmId = _readMoviesByFilmId();
    final movie =
        moviesByFilmId[filmId]?.copyWith(
          isFavorite: isFavorite,
        ) ??
        FavoriteMovie(
          filmId: filmId,
          isFavorite: isFavorite,
        );

    moviesByFilmId[filmId] = movie;
    await _writeMoviesByFilmId(moviesByFilmId);
    return movie;
  }

  @override
  Future<FavoriteMovie> setRating(String filmId, int? rating) async {
    final moviesByFilmId = _readMoviesByFilmId();
    final movie =
        moviesByFilmId[filmId]?.copyWith(
          rating: rating,
        ) ??
        FavoriteMovie(
          filmId: filmId,
          isFavorite: false,
          rating: rating,
        );

    moviesByFilmId[filmId] = movie;
    await _writeMoviesByFilmId(moviesByFilmId);
    return movie;
  }

  Map<String, FavoriteMovie> _readMoviesByFilmId() {
    try {
      final storedValue = _preferences.getString(storageKey);
      if (storedValue == null) {
        return <String, FavoriteMovie>{};
      }

      final decoded = jsonDecode(storedValue);
      if (decoded is! Map<String, dynamic>) {
        return <String, FavoriteMovie>{};
      }

      return decoded.entries.fold(<String, FavoriteMovie>{}, (movies, entry) {
        final movie = _movieFromEntry(entry);
        if (movie != null) {
          movies[movie.filmId] = movie;
        }
        return movies;
      });
    } on Object {
      return <String, FavoriteMovie>{};
    }
  }

  FavoriteMovie? _movieFromEntry(MapEntry<String, dynamic> entry) {
    final value = entry.value;
    if (value is! Map<String, dynamic>) {
      return null;
    }

    try {
      final movie = FavoriteMovie.fromJson(value.cast<String, Object?>());
      if (movie.filmId != entry.key) {
        return null;
      }
      return movie;
    } on Object {
      return null;
    }
  }

  Future<void> _writeMoviesByFilmId(
    Map<String, FavoriteMovie> moviesByFilmId,
  ) async {
    try {
      final jsonByFilmId = moviesByFilmId.map(
        (filmId, movie) => MapEntry(filmId, movie.toJson()),
      );
      await _preferences.setString(storageKey, jsonEncode(jsonByFilmId));
    } on Object {
      return;
    }
  }
}
