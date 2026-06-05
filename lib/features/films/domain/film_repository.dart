import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/domain/film_details.dart';

abstract interface class FilmRepository {
  Future<List<Film>> fetchFilms();

  Future<FilmDetails> fetchFilmDetails(String filmId);

  Future<FavoriteMovie?> loadFavorite(String filmId);

  Future<void> saveFavorite(FavoriteMovie favorite);
}
