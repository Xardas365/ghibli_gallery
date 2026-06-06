import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';

abstract interface class FavoriteMovieStorage {
  Future<List<FavoriteMovie>> getAll();

  Future<FavoriteMovie?> getByFilmId(String filmId);

  Future<void> save(FavoriteMovie movie);

  Future<FavoriteMovie> setFavorite(String filmId, {required bool isFavorite});

  Future<FavoriteMovie> setRating(String filmId, int? rating);
}
