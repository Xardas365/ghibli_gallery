import 'package:ghibli_entry/core/network/api_client.dart';
import 'package:ghibli_entry/features/films/data/models/film_dto.dart';

class FilmApi {
  const FilmApi(this.client);

  final ApiClient client;

  Future<List<FilmDto>> fetchFilms() {
    throw UnimplementedError(
      'Film API implementation belongs in the API step.',
    );
  }

  Future<Object?> fetchReferencedResource(String url) {
    throw UnimplementedError(
      'Referenced resource loading belongs in the API step.',
    );
  }
}
