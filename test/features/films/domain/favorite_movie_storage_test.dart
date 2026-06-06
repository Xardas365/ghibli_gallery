import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie_storage.dart';

void main() {
  group('FavoriteMovieStorage contract', () {
    test('persists and reads user data by filmId', () async {
      final storage = _InMemoryFavoriteMovieStorage();
      final movie = FavoriteMovie(
        filmId: 'film-id',
        isFavorite: true,
        rating: 3,
      );

      await storage.save(movie);

      expect(await storage.getByFilmId('film-id'), movie);
      expect(await storage.getByFilmId('other-film-id'), isNull);
      expect(await storage.getAll(), [movie]);
    });

    test('setFavorite preserves an existing rating', () async {
      final storage = _InMemoryFavoriteMovieStorage();
      await storage.setRating('film-id', 4);

      final movie = await storage.setFavorite('film-id', isFavorite: false);

      expect(movie.isFavorite, isFalse);
      expect(movie.rating, 4);
    });

    test('setRating preserves existing favorite state', () async {
      final storage = _InMemoryFavoriteMovieStorage();
      await storage.setFavorite('film-id', isFavorite: true);

      final movie = await storage.setRating('film-id', 2);

      expect(movie.isFavorite, isTrue);
      expect(movie.rating, 2);
    });
  });
}

class _InMemoryFavoriteMovieStorage implements FavoriteMovieStorage {
  final _moviesByFilmId = <String, FavoriteMovie>{};

  @override
  Future<List<FavoriteMovie>> getAll() async {
    return _moviesByFilmId.values.toList(growable: false);
  }

  @override
  Future<FavoriteMovie?> getByFilmId(String filmId) async {
    return _moviesByFilmId[filmId];
  }

  @override
  Future<void> save(FavoriteMovie movie) async {
    _moviesByFilmId[movie.filmId] = movie;
  }

  @override
  Future<FavoriteMovie> setFavorite(
    String filmId, {
    required bool isFavorite,
  }) async {
    final movie =
        _moviesByFilmId[filmId]?.copyWith(
          isFavorite: isFavorite,
        ) ??
        FavoriteMovie(
          filmId: filmId,
          isFavorite: isFavorite,
        );
    _moviesByFilmId[filmId] = movie;
    return movie;
  }

  @override
  Future<FavoriteMovie> setRating(String filmId, int? rating) async {
    final movie =
        _moviesByFilmId[filmId]?.copyWith(
          rating: rating,
        ) ??
        FavoriteMovie(
          filmId: filmId,
          isFavorite: false,
          rating: rating,
        );
    _moviesByFilmId[filmId] = movie;
    return movie;
  }
}
