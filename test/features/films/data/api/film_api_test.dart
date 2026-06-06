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

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequestedPath = options.path;

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
