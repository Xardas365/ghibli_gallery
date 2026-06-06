import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/features/films/data/api/film_api.dart';
import 'package:ghibli_entry/features/films/data/film_repository_impl.dart';
import 'package:ghibli_entry/features/films/data/models/film_dto.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('FilmRepositoryImpl', () {
    test('calls FilmApi.fetchFilms', () async {
      final api = _MockFilmApi();
      when(api.fetchFilms).thenAnswer((_) async => [castleInTheSkyDto]);
      final repository = FilmRepositoryImpl(api: api);

      await repository.fetchFilms();

      verify(api.fetchFilms).called(1);
    });

    test('returns List<Film>', () async {
      final api = _MockFilmApi();
      when(api.fetchFilms).thenAnswer((_) async => [castleInTheSkyDto]);
      final repository = FilmRepositoryImpl(api: api);

      final films = await repository.fetchFilms();

      expect(films, hasLength(1));
      expect(films.first, isA<Film>());
    });

    test('maps basic fields correctly', () async {
      final api = _MockFilmApi();
      when(api.fetchFilms).thenAnswer((_) async => [castleInTheSkyDto]);
      final repository = FilmRepositoryImpl(api: api);

      final film = (await repository.fetchFilms()).single;

      expect(film.id, castleInTheSkyDto.id);
      expect(film.title, castleInTheSkyDto.title);
      expect(film.image, castleInTheSkyDto.image);
      expect(film.movieBanner, castleInTheSkyDto.movieBanner);
      expect(film.director, castleInTheSkyDto.director);
      expect(film.producer, castleInTheSkyDto.producer);
      expect(film.releaseYear, 1986);
    });

    test('returns empty domain list when API list is empty', () async {
      final api = _MockFilmApi();
      when(api.fetchFilms).thenAnswer((_) async => const []);
      final repository = FilmRepositoryImpl(api: api);

      final films = await repository.fetchFilms();

      expect(films, isEmpty);
    });
  });
}

class _MockFilmApi extends Mock implements FilmApi {}

const castleInTheSkyDto = FilmDto(
  id: '2baf70d1-42bb-4437-b551-e5fed5a87abe',
  title: 'Castle in the Sky',
  originalTitle: '天空の城ラピュタ',
  originalTitleRomanised: 'Tenkū no shiro Rapyuta',
  image:
      'https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg',
  movieBanner:
      'https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg',
  description: 'The orphan Sheeta inherited a mysterious crystal.',
  director: 'Hayao Miyazaki',
  producer: 'Isao Takahata',
  releaseDate: '1986',
  runningTime: '124',
  rtScore: '95',
  url:
      'https://ghibli-api.vercel.app/api/films/2baf70d1-42bb-4437-b551-e5fed5a87abe',
);
