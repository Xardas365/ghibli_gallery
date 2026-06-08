import 'package:ghibli_gallery/core/network/api_client.dart';
import 'package:ghibli_gallery/features/films/data/models/film_dto.dart';
import 'package:ghibli_gallery/features/films/data/models/location_dto.dart';
import 'package:ghibli_gallery/features/films/data/models/person_dto.dart';
import 'package:ghibli_gallery/features/films/data/models/species_dto.dart';
import 'package:ghibli_gallery/features/films/data/models/vehicle_dto.dart';

class FilmApi {
  const FilmApi(this.client);

  final ApiClient client;

  Future<List<FilmDto>> fetchFilms() {
    return client.get<List<FilmDto>>(
      '/films',
      parser: _parseFilms,
    );
  }

  Future<PersonDto> fetchPersonByUrl(String url) {
    return client.get<PersonDto>(
      url,
      parser: (json) => PersonDto.fromJson(_parseObject(json)),
    );
  }

  Future<SpeciesDto> fetchSpeciesByUrl(String url) {
    return client.get<SpeciesDto>(
      url,
      parser: (json) => SpeciesDto.fromJson(_parseObject(json)),
    );
  }

  Future<LocationDto> fetchLocationByUrl(String url) {
    return client.get<LocationDto>(
      url,
      parser: (json) => LocationDto.fromJson(_parseObject(json)),
    );
  }

  Future<VehicleDto> fetchVehicleByUrl(String url) {
    return client.get<VehicleDto>(
      url,
      parser: (json) => VehicleDto.fromJson(_parseObject(json)),
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
  return FilmDto.fromJson(_parseObject(json));
}

Map<String, dynamic> _parseObject(Object? json) {
  return switch (json) {
    final Map<String, dynamic> object => object,
    {'data': final Map<String, dynamic> object} => object,
    _ => throw const FormatException('Expected response to be an object.'),
  };
}
