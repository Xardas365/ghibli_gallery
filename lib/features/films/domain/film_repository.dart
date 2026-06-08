import 'package:ghibli_gallery/features/films/domain/film.dart';
import 'package:ghibli_gallery/features/films/domain/film_details.dart';

abstract interface class FilmRepository {
  Future<List<Film>> fetchFilms();

  Future<FilmDetails> fetchFilmDetails(String filmId);
}
