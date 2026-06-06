import 'package:ghibli_entry/features/films/data/api/film_api.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/domain/film_details.dart';
import 'package:ghibli_entry/features/films/domain/film_repository.dart';

class FilmRepositoryImpl implements FilmRepository {
  const FilmRepositoryImpl({required this.api});

  final FilmApi api;

  @override
  Future<List<Film>> fetchFilms() {
    throw UnimplementedError(
      'Repository implementation belongs in a later step.',
    );
  }

  @override
  Future<FilmDetails> fetchFilmDetails(String filmId) {
    throw UnimplementedError(
      'Repository implementation belongs in a later step.',
    );
  }

  @override
  Future<FavoriteMovie?> loadFavorite(String filmId) {
    throw UnimplementedError(
      'Persistence implementation belongs in a later step.',
    );
  }

  @override
  Future<void> saveFavorite(FavoriteMovie favorite) {
    throw UnimplementedError(
      'Persistence implementation belongs in a later step.',
    );
  }
}
