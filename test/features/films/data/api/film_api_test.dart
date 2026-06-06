import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/core/network/api_client.dart';
import 'package:ghibli_entry/core/network/dio_provider.dart';
import 'package:ghibli_entry/features/films/data/api/film_api.dart';

void main() {
  group('FilmApi', () {
    test('fetchFilms calls /films', () async {
      final adapter = JsonResponseAdapter({
        'data': [castleInTheSkyJson],
      });
      final api = FilmApi(ApiClient(dio: createTestDio(adapter: adapter)));

      await api.fetchFilms();

      expect(adapter.lastRequestedPath, '/films');
    });

    test('fetchFilms returns List<FilmDto>', () async {
      final api = FilmApi(
        ApiClient(
          dio: createTestDio(
            adapter: JsonResponseAdapter({
              'data': [castleInTheSkyJson],
            }),
          ),
        ),
      );

      final films = await api.fetchFilms();

      expect(films, hasLength(1));
      expect(films.first.title, 'Castle in the Sky');
    });

    test('fetchFilms parses snake_case fields correctly', () async {
      final api = FilmApi(
        ApiClient(
          dio: createTestDio(
            adapter: JsonResponseAdapter({
              'data': [castleInTheSkyJson],
            }),
          ),
        ),
      );

      final film = (await api.fetchFilms()).single;

      expect(film.originalTitle, '天空の城ラピュタ');
      expect(film.originalTitleRomanised, 'Tenkū no shiro Rapyuta');
      expect(film.movieBanner, contains('3cyjYtLWCBE1uvWINHFsFnE8LUK'));
      expect(film.rtScore, '95');
    });

    test(
      'fetchFilms throws FormatException for invalid response shape',
      () async {
        final api = FilmApi(
          ApiClient(
            dio: createTestDio(
              adapter: JsonResponseAdapter({'data': 'invalid'}),
            ),
          ),
        );

        await expectLater(
          api.fetchFilms(),
          throwsA(isA<FormatException>()),
        );
      },
    );

    test('fetchPersonByUrl parses PersonDto', () async {
      final api = FilmApi(
        ApiClient(dio: createTestDio(adapter: JsonResponseAdapter(personJson))),
      );

      final person = await api.fetchPersonByUrl(personUrl);

      expect(person.id, '598f7048-74ff-41e0-92ef-87dc1ad980a9');
      expect(person.name, 'Lusheeta Toel Ul Laputa');
      expect(person.eyeColor, 'Black');
      expect(person.hairColor, 'Black');
    });

    test('fetchSpeciesByUrl parses SpeciesDto', () async {
      final api = FilmApi(
        ApiClient(
          dio: createTestDio(adapter: JsonResponseAdapter(speciesJson)),
        ),
      );

      final species = await api.fetchSpeciesByUrl(speciesUrl);

      expect(species.id, 'af3910a6-429f-4c74-9ad5-dfe1c4aa04f2');
      expect(species.name, 'Human');
      expect(species.classification, 'Mammal');
      expect(species.eyeColors, contains('Black'));
    });

    test('fetchLocationByUrl parses LocationDto', () async {
      final api = FilmApi(
        ApiClient(
          dio: createTestDio(adapter: JsonResponseAdapter(locationJson)),
        ),
      );

      final location = await api.fetchLocationByUrl(locationUrl);

      expect(location.id, '6ba60a86-7c74-4ec4-a6f4-7112b5705a2f');
      expect(location.name, 'Gondoa');
      expect(location.surfaceWater, '40');
      expect(location.terrain, 'Plain');
    });

    test('fetchVehicleByUrl parses VehicleDto', () async {
      final api = FilmApi(
        ApiClient(
          dio: createTestDio(adapter: JsonResponseAdapter(vehicleJson)),
        ),
      );

      final vehicle = await api.fetchVehicleByUrl(vehicleUrl);

      expect(vehicle.id, '4e09b023-f650-4747-9ab9-eacf14540cfb');
      expect(vehicle.name, 'Air Destroyer Goliath');
      expect(vehicle.vehicleClass, 'Airship');
      expect(vehicle.length, '1,000');
    });

    test('resource methods pass absolute URL to ApiClient and Dio', () async {
      final adapter = JsonResponseAdapter(personJson);
      final api = FilmApi(ApiClient(dio: createTestDio(adapter: adapter)));

      await api.fetchPersonByUrl(personUrl);

      expect(adapter.lastRequestedUri, personUrl);
    });
  });
}

Dio createTestDio({required HttpClientAdapter adapter}) {
  final dio = createDio()..httpClientAdapter = adapter;
  return dio;
}

class JsonResponseAdapter implements HttpClientAdapter {
  JsonResponseAdapter(this.json);

  final Object json;
  String? lastRequestedPath;
  String? lastRequestedUri;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequestedPath = options.path;
    lastRequestedUri = options.uri.toString();

    return ResponseBody.fromString(
      jsonEncode(json),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

const Map<String, Object?> castleInTheSkyJson = {
  'id': '2baf70d1-42bb-4437-b551-e5fed5a87abe',
  'title': 'Castle in the Sky',
  'original_title': '天空の城ラピュタ',
  'original_title_romanised': 'Tenkū no shiro Rapyuta',
  'image':
      'https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg',
  'movie_banner':
      'https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg',
  'description': 'The orphan Sheeta inherited a mysterious crystal.',
  'director': 'Hayao Miyazaki',
  'producer': 'Isao Takahata',
  'release_date': '1986',
  'running_time': '124',
  'rt_score': '95',
  'people': [
    'https://ghibli-api.vercel.app/api/people/598f7048-74ff-41e0-92ef-87dc1ad980a9',
  ],
  'species': [
    'https://ghibli-api.vercel.app/api/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2',
  ],
  'locations': [
    'https://ghibli-api.vercel.app/api/locations/',
  ],
  'vehicles': [
    'https://ghibli-api.vercel.app/api/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb',
  ],
  'url':
      'https://ghibli-api.vercel.app/api/films/2baf70d1-42bb-4437-b551-e5fed5a87abe',
};

const personUrl =
    'https://ghibli-api.vercel.app/api/people/598f7048-74ff-41e0-92ef-87dc1ad980a9';

const speciesUrl =
    'https://ghibli-api.vercel.app/api/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2';

const locationUrl =
    'https://ghibli-api.vercel.app/api/locations/6ba60a86-7c74-4ec4-a6f4-7112b5705a2f';

const vehicleUrl =
    'https://ghibli-api.vercel.app/api/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb';

const Map<String, Object?> personJson = {
  'id': '598f7048-74ff-41e0-92ef-87dc1ad980a9',
  'name': 'Lusheeta Toel Ul Laputa',
  'gender': 'Female',
  'age': '13',
  'eye_color': 'Black',
  'hair_color': 'Black',
  'films': [
    'https://ghibli-api.vercel.app/api/films/2baf70d1-42bb-4437-b551-e5fed5a87abe',
  ],
  'species': speciesUrl,
  'url': personUrl,
};

const Map<String, Object?> speciesJson = {
  'id': 'af3910a6-429f-4c74-9ad5-dfe1c4aa04f2',
  'name': 'Human',
  'classification': 'Mammal',
  'eye_colors': 'Black, Blue, Brown, Grey, Green, Hazel',
  'hair_colors': 'Black, Blonde, Brown, Grey, White',
  'people': [personUrl],
  'films': [
    'https://ghibli-api.vercel.app/api/films/2baf70d1-42bb-4437-b551-e5fed5a87abe',
  ],
  'url': speciesUrl,
};

const Map<String, Object?> locationJson = {
  'id': '6ba60a86-7c74-4ec4-a6f4-7112b5705a2f',
  'name': 'Gondoa',
  'climate': 'TODO',
  'terrain': 'Plain',
  'surface_water': '40',
  'residents': [personUrl],
  'films': [
    'https://ghibli-api.vercel.app/api/films/2baf70d1-42bb-4437-b551-e5fed5a87abe',
  ],
  'url': locationUrl,
};

const Map<String, Object?> vehicleJson = {
  'id': '4e09b023-f650-4747-9ab9-eacf14540cfb',
  'name': 'Air Destroyer Goliath',
  'description': 'A military airship.',
  'vehicle_class': 'Airship',
  'length': '1,000',
  'pilot': personUrl,
  'films': [
    'https://ghibli-api.vercel.app/api/films/2baf70d1-42bb-4437-b551-e5fed5a87abe',
  ],
  'url': vehicleUrl,
};
