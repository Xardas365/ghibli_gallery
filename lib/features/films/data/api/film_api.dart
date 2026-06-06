import 'package:ghibli_entry/core/network/api_client.dart';
import 'package:ghibli_entry/features/films/data/models/film_dto.dart';

class FilmApi {
  const FilmApi(this.client);

  final ApiClient client;

  Future<List<FilmDto>> fetchFilms() {
    return client.get<List<FilmDto>>(
      '/films',
      parser: _parseFilms,
    );
  }
}

List<FilmDto> _parseFilms(Object? json) {
  final filmsJson = switch (json) {
    final List<dynamic> list => list,
    {'data': final List<dynamic> list} => list,
    _ => throw const FormatException(
      'Expected films response to be a list or an object with a data list.',
    ),
  };

  return filmsJson.map(_parseFilm).toList();
}

FilmDto _parseFilm(Object? json) {
  if (json is! Map<String, dynamic>) {
    throw const FormatException('Expected each film item to be an object.');
  }

  return FilmDto.fromJson(json);
}
