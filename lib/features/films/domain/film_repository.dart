import 'package:ghibli_entry/features/films/domain/film.dart';

// Repository contract is intentionally kept even while it has one method.
// Later phases add details and persistence without changing consumers.
// ignore: one_member_abstracts
abstract interface class FilmRepository {
  Future<List<Film>> fetchFilms();
}
