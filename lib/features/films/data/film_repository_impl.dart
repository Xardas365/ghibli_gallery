import 'package:ghibli_entry/features/films/data/api/film_api.dart';
import 'package:ghibli_entry/features/films/data/mappers/film_mappers.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/domain/film_repository.dart';

class FilmRepositoryImpl implements FilmRepository {
  const FilmRepositoryImpl({required this.api});

  final FilmApi api;

  @override
  Future<List<Film>> fetchFilms() async {
    final films = await api.fetchFilms();
    return films.map((film) => film.toDomain()).toList();
  }
}
