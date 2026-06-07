import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_gallery/features/films/data/mappers/film_mappers.dart';
import 'package:ghibli_gallery/features/films/data/models/film_dto.dart';

void main() {
  late Map<String, Object?> castleInTheSkyJson;

  setUpAll(() async {
    castleInTheSkyJson = await loadJsonFixture(
      'test/fixtures/films/castle_in_the_sky.json',
    );
  });

  group('FilmDto', () {
    test('parses the verified API film shape', () {
      final dto = FilmDto.fromJson(castleInTheSkyJson);

      expect(dto.id, '2baf70d1-42bb-4437-b551-e5fed5a87abe');
      expect(dto.title, 'Castle in the Sky');
      expect(
        dto.image,
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg',
      );
      expect(
        dto.movieBanner,
        'https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg',
      );
      expect(dto.people, hasLength(7));
      expect(
        dto.url,
        'https://ghibli-api.vercel.app/api/films/2baf70d1-42bb-4437-b551-e5fed5a87abe',
      );
    });

    test('keeps the collection-like location reference from the snapshot', () {
      final dto = FilmDto.fromJson(castleInTheSkyJson);

      expect(dto.people, hasLength(7));
      expect(dto.species, hasLength(1));
      expect(dto.vehicles, hasLength(1));
      expect(dto.locations, ['https://ghibli-api.vercel.app/api/locations/']);
    });

    test('maps snake_case fields correctly', () {
      final dto = FilmDto.fromJson(castleInTheSkyJson);

      expect(dto.originalTitle, '天空の城ラピュタ');
      expect(dto.originalTitleRomanised, 'Tenkū no shiro Rapyuta');
      expect(dto.movieBanner, contains('3cyjYtLWCBE1uvWINHFsFnE8LUK'));
    });

    test('keeps API numeric values as strings in DTO', () {
      final dto = FilmDto.fromJson(castleInTheSkyJson);

      expect(dto.releaseDate, '1986');
      expect(dto.runningTime, '124');
      expect(dto.rtScore, '95');
    });

    test('maps DTO numeric strings to nullable domain ints', () {
      final film = FilmDto.fromJson(castleInTheSkyJson).toDomain();

      expect(film.releaseYear, 1986);
      expect(film.runningTimeMinutes, 124);
      expect(film.rtScore, 95);
    });

    test('maps invalid DTO numeric strings to null domain values', () {
      final film = FilmDto.fromJson({
        ...castleInTheSkyJson,
        'release_date': 'unknown',
        'running_time': null,
        'rt_score': '',
      }).toDomain();

      expect(film.releaseYear, isNull);
      expect(film.runningTimeMinutes, isNull);
      expect(film.rtScore, isNull);
    });

    test('maps empty DTO numeric strings to null domain values', () {
      final film = FilmDto.fromJson({
        ...castleInTheSkyJson,
        'release_date': '',
        'running_time': '',
        'rt_score': '',
      }).toDomain();

      expect(film.releaseYear, isNull);
      expect(film.runningTimeMinutes, isNull);
      expect(film.rtScore, isNull);
    });

    test('maps imperfect API numeric data without throwing', () {
      expect(
        () => FilmDto.fromJson({
          ...castleInTheSkyJson,
          'release_date': null,
          'running_time': 'not available',
          'rt_score': '',
        }).toDomain(),
        returnsNormally,
      );
    });
  });
}

Future<Map<String, Object?>> loadJsonFixture(String path) async {
  final content = await File(path).readAsString();
  final decoded = jsonDecode(content) as Map<String, dynamic>;

  return decoded.cast<String, Object?>();
}
