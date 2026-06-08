import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_gallery/features/films/data/shared_preferences_favorite_movie_storage.dart';
import 'package:ghibli_gallery/features/films/domain/favorite_movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SharedPreferencesFavoriteMovieStorage', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('saving favorite persists it', () async {
      final storage = await _createStorage();

      final movie = await storage.setFavorite('film-id', isFavorite: true);

      expect(movie, FavoriteMovie(filmId: 'film-id', isFavorite: true));
      expect(await storage.getByFilmId('film-id'), movie);
    });

    test('saving rating persists it', () async {
      final storage = await _createStorage();

      final movie = await storage.setRating('film-id', 4);

      expect(
        movie,
        FavoriteMovie(filmId: 'film-id', isFavorite: false, rating: 4),
      );
      expect(await storage.getByFilmId('film-id'), movie);
    });

    test('removing favorite preserves rating', () async {
      final storage = await _createStorage();
      await storage.setRating('film-id', 5);

      final movie = await storage.setFavorite('film-id', isFavorite: false);

      expect(movie.isFavorite, isFalse);
      expect(movie.rating, 5);
      expect(await storage.getByFilmId('film-id'), movie);
    });

    test('getByFilmId returns null when missing', () async {
      final storage = await _createStorage();

      expect(await storage.getByFilmId('missing-film-id'), isNull);
    });

    test('getAll returns all saved user data', () async {
      final storage = await _createStorage();
      final favorite = FavoriteMovie(
        filmId: 'favorite-film-id',
        isFavorite: true,
      );
      final rated = FavoriteMovie(
        filmId: 'rated-film-id',
        isFavorite: false,
        rating: 3,
      );

      await storage.save(favorite);
      await storage.save(rated);

      expect(await storage.getAll(), unorderedEquals([favorite, rated]));
    });

    test('data survives creating a new storage instance', () async {
      final preferences = await SharedPreferences.getInstance();
      final storage = SharedPreferencesFavoriteMovieStorage(
        preferences: preferences,
      );
      final movie = FavoriteMovie(
        filmId: 'film-id',
        isFavorite: true,
        rating: 2,
      );

      await storage.save(movie);
      final reloadedStorage = SharedPreferencesFavoriteMovieStorage(
        preferences: preferences,
      );

      expect(await reloadedStorage.getByFilmId('film-id'), movie);
    });

    test('corrupted JSON is handled safely', () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesFavoriteMovieStorage.defaultStorageKey: 'not-json',
      });
      final storage = await _createStorage();

      expect(await storage.getAll(), isEmpty);
      expect(await storage.getByFilmId('film-id'), isNull);
    });

    test('invalid persisted rating does not enter app state', () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesFavoriteMovieStorage.defaultStorageKey: jsonEncode({
          'film-id': {
            'filmId': 'film-id',
            'isFavorite': true,
            'rating': 6,
          },
        }),
      });
      final storage = await _createStorage();

      expect(await storage.getAll(), isEmpty);
      expect(await storage.getByFilmId('film-id'), isNull);
    });

    test('save propagates write failures', () async {
      final storage = SharedPreferencesFavoriteMovieStorage(
        preferences: _FailingWriteSharedPreferences(),
      );

      await expectLater(
        storage.save(FavoriteMovie(filmId: 'film-id', isFavorite: true)),
        throwsA(same(_writeFailure)),
      );
    });

    test('setFavorite propagates write failures', () async {
      final storage = SharedPreferencesFavoriteMovieStorage(
        preferences: _FailingWriteSharedPreferences(),
      );

      await expectLater(
        storage.setFavorite('film-id', isFavorite: true),
        throwsA(same(_writeFailure)),
      );
    });

    test('setRating propagates write failures', () async {
      final storage = SharedPreferencesFavoriteMovieStorage(
        preferences: _FailingWriteSharedPreferences(),
      );

      await expectLater(
        storage.setRating('film-id', 4),
        throwsA(same(_writeFailure)),
      );
    });
  });
}

Future<SharedPreferencesFavoriteMovieStorage> _createStorage() async {
  final preferences = await SharedPreferences.getInstance();
  return SharedPreferencesFavoriteMovieStorage(preferences: preferences);
}

final _writeFailure = StateError('write failed');

class _FailingWriteSharedPreferences implements SharedPreferences {
  @override
  String? getString(String key) => null;

  @override
  Future<bool> setString(String key, String value) async {
    throw _writeFailure;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
