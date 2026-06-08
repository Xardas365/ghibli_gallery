import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_gallery/features/films/data/api/film_api.dart';
import 'package:ghibli_gallery/features/films/data/film_repository_impl.dart';
import 'package:ghibli_gallery/features/films/data/models/film_dto.dart';
import 'package:ghibli_gallery/features/films/data/models/location_dto.dart';
import 'package:ghibli_gallery/features/films/data/models/person_dto.dart';
import 'package:ghibli_gallery/features/films/data/models/species_dto.dart';
import 'package:ghibli_gallery/features/films/data/models/vehicle_dto.dart';
import 'package:ghibli_gallery/features/films/domain/film.dart';
import 'package:ghibli_gallery/features/films/domain/film_details.dart';
import 'package:ghibli_gallery/features/films/domain/film_repository_exception.dart';
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

    test('fetchFilmDetails returns base FilmDetails', () async {
      final api = _MockFilmApi();
      _stubFilmDetails(api);
      final repository = FilmRepositoryImpl(api: api);

      final details = await repository.fetchFilmDetails(castleInTheSkyDto.id);

      expect(details, isA<FilmDetails>());
      expect(details.film.id, castleInTheSkyDto.id);
      expect(details.film.title, castleInTheSkyDto.title);
      expect(details.originalTitle, castleInTheSkyDto.originalTitle);
      expect(
        details.originalTitleRomanised,
        castleInTheSkyDto.originalTitleRomanised,
      );
      expect(details.people, [pazuDto.name]);
      expect(details.species, [humanDto.name]);
      expect(details.locations, [gondoaDto.name]);
      expect(details.vehicles, [airDestroyerGoliathDto.name]);
    });

    test('fetchFilmDetails fetches concrete resource URLs', () async {
      final api = _MockFilmApi();
      _stubFilmDetails(api);
      final repository = FilmRepositoryImpl(api: api);

      await repository.fetchFilmDetails(castleInTheSkyDto.id);

      verify(() => api.fetchPersonByUrl(pazuUrl)).called(1);
      verify(() => api.fetchSpeciesByUrl(humanUrl)).called(1);
      verify(() => api.fetchLocationByUrl(gondoaUrl)).called(1);
      verify(() => api.fetchVehicleByUrl(airDestroyerGoliathUrl)).called(1);
    });

    test('fetchFilmDetails skips collection-like resource URLs', () async {
      final api = _MockFilmApi();
      _stubFilmDetails(api);
      final repository = FilmRepositoryImpl(api: api);

      await repository.fetchFilmDetails(castleInTheSkyDto.id);

      verifyNever(() => api.fetchPersonByUrl(peopleCollectionUrl));
      verifyNever(() => api.fetchSpeciesByUrl(speciesCollectionUrl));
      verifyNever(() => api.fetchLocationByUrl(locationsCollectionUrl));
      verifyNever(() => api.fetchVehicleByUrl(vehiclesCollectionUrl));
    });

    test(
      'fetchFilmDetails throws clear exception for unknown filmId',
      () async {
        final api = _MockFilmApi();
        when(api.fetchFilms).thenAnswer((_) async => [castleInTheSkyDto]);
        final repository = FilmRepositoryImpl(api: api);

        final call = repository.fetchFilmDetails('unknown-film-id');

        expect(call, throwsA(isA<FilmRepositoryException>()));
      },
    );

    test('skipped resources result in empty related lists', () async {
      final api = _MockFilmApi();
      final filmWithCollectionUrls = castleInTheSkyDto.copyWith(
        people: const [peopleCollectionUrl],
        species: const [speciesCollectionUrl],
        locations: const [locationsCollectionUrl],
        vehicles: const [vehiclesCollectionUrl],
      );
      when(api.fetchFilms).thenAnswer((_) async => [filmWithCollectionUrls]);
      final repository = FilmRepositoryImpl(api: api);

      final details = await repository.fetchFilmDetails(castleInTheSkyDto.id);

      expect(details.people, isEmpty);
      expect(details.species, isEmpty);
      expect(details.locations, isEmpty);
      expect(details.vehicles, isEmpty);
    });

    test('people failure does not fail whole FilmDetails', () async {
      final api = _MockFilmApi();
      _stubFilmDetails(api, failPeople: true);
      final repository = FilmRepositoryImpl(api: api);

      final details = await repository.fetchFilmDetails(castleInTheSkyDto.id);

      expect(details.film.id, castleInTheSkyDto.id);
      expect(details.people, isEmpty);
      expect(details.species, [humanDto.name]);
      expect(details.locations, [gondoaDto.name]);
      expect(details.vehicles, [airDestroyerGoliathDto.name]);
    });

    test('species failure does not fail whole FilmDetails', () async {
      final api = _MockFilmApi();
      _stubFilmDetails(api, failSpecies: true);
      final repository = FilmRepositoryImpl(api: api);

      final details = await repository.fetchFilmDetails(castleInTheSkyDto.id);

      expect(details.film.id, castleInTheSkyDto.id);
      expect(details.people, [pazuDto.name]);
      expect(details.species, isEmpty);
      expect(details.locations, [gondoaDto.name]);
      expect(details.vehicles, [airDestroyerGoliathDto.name]);
    });

    test('locations failure does not fail whole FilmDetails', () async {
      final api = _MockFilmApi();
      _stubFilmDetails(api, failLocations: true);
      final repository = FilmRepositoryImpl(api: api);

      final details = await repository.fetchFilmDetails(castleInTheSkyDto.id);

      expect(details.film.id, castleInTheSkyDto.id);
      expect(details.people, [pazuDto.name]);
      expect(details.species, [humanDto.name]);
      expect(details.locations, isEmpty);
      expect(details.vehicles, [airDestroyerGoliathDto.name]);
    });

    test('vehicles failure does not fail whole FilmDetails', () async {
      final api = _MockFilmApi();
      _stubFilmDetails(api, failVehicles: true);
      final repository = FilmRepositoryImpl(api: api);

      final details = await repository.fetchFilmDetails(castleInTheSkyDto.id);

      expect(details.film.id, castleInTheSkyDto.id);
      expect(details.people, [pazuDto.name]);
      expect(details.species, [humanDto.name]);
      expect(details.locations, [gondoaDto.name]);
      expect(details.vehicles, isEmpty);
    });

    test('multiple related failures still return base FilmDetails', () async {
      final api = _MockFilmApi();
      _stubFilmDetails(
        api,
        failPeople: true,
        failSpecies: true,
        failVehicles: true,
      );
      final repository = FilmRepositoryImpl(api: api);

      final details = await repository.fetchFilmDetails(castleInTheSkyDto.id);

      expect(details.film.id, castleInTheSkyDto.id);
      expect(details.film.title, castleInTheSkyDto.title);
      expect(details.people, isEmpty);
      expect(details.species, isEmpty);
      expect(details.locations, [gondoaDto.name]);
      expect(details.vehicles, isEmpty);
    });

    test('fetchFilms failure still throws', () async {
      final api = _MockFilmApi();
      final exception = Exception('films failed');
      when(api.fetchFilms).thenThrow(exception);
      final repository = FilmRepositoryImpl(api: api);

      final call = repository.fetchFilmDetails(castleInTheSkyDto.id);

      expect(call, throwsA(same(exception)));
    });
  });

  group('isConcreteResourceUrl', () {
    test('returns true for URLs with resource IDs', () {
      expect(isConcreteResourceUrl(pazuUrl), isTrue);
      expect(isConcreteResourceUrl(humanUrl), isTrue);
      expect(isConcreteResourceUrl(gondoaUrl), isTrue);
      expect(isConcreteResourceUrl(airDestroyerGoliathUrl), isTrue);
    });

    test('returns false for collection-like URLs', () {
      expect(isConcreteResourceUrl(peopleCollectionUrl), isFalse);
      expect(isConcreteResourceUrl(speciesCollectionUrl), isFalse);
      expect(isConcreteResourceUrl(locationsCollectionUrl), isFalse);
      expect(isConcreteResourceUrl(vehiclesCollectionUrl), isFalse);
    });
  });
}

class _MockFilmApi extends Mock implements FilmApi {}

void _stubFilmDetails(
  _MockFilmApi api, {
  bool failPeople = false,
  bool failSpecies = false,
  bool failLocations = false,
  bool failVehicles = false,
}) {
  when(api.fetchFilms).thenAnswer((_) async => [castleInTheSkyDto]);

  if (failPeople) {
    when(() => api.fetchPersonByUrl(pazuUrl)).thenThrow(Exception('people'));
  } else {
    when(() => api.fetchPersonByUrl(pazuUrl)).thenAnswer((_) async => pazuDto);
  }

  if (failSpecies) {
    when(() => api.fetchSpeciesByUrl(humanUrl)).thenThrow(Exception('species'));
  } else {
    when(() => api.fetchSpeciesByUrl(humanUrl)).thenAnswer((_) async {
      return humanDto;
    });
  }

  if (failLocations) {
    when(() => api.fetchLocationByUrl(gondoaUrl)).thenThrow(
      Exception('locations'),
    );
  } else {
    when(() => api.fetchLocationByUrl(gondoaUrl)).thenAnswer((_) async {
      return gondoaDto;
    });
  }

  if (failVehicles) {
    when(() => api.fetchVehicleByUrl(airDestroyerGoliathUrl)).thenThrow(
      Exception('vehicles'),
    );
  } else {
    when(() => api.fetchVehicleByUrl(airDestroyerGoliathUrl)).thenAnswer((
      _,
    ) async {
      return airDestroyerGoliathDto;
    });
  }
}

const peopleCollectionUrl = 'https://ghibli-api.vercel.app/api/people/';
const speciesCollectionUrl = 'https://ghibli-api.vercel.app/api/species/';
const locationsCollectionUrl = 'https://ghibli-api.vercel.app/api/locations/';
const vehiclesCollectionUrl = 'https://ghibli-api.vercel.app/api/vehicles/';

const pazuUrl =
    'https://ghibli-api.vercel.app/api/people/598f7048-74ff-41e0-92ef-87dc1ad980a9';
const humanUrl =
    'https://ghibli-api.vercel.app/api/species/603428ba-8a86-4b0b-a9f1-65df6abef3d3';
const gondoaUrl =
    'https://ghibli-api.vercel.app/api/locations/2baf70d1-42bb-4437-b551-e5fed5a87abe';
const airDestroyerGoliathUrl =
    'https://ghibli-api.vercel.app/api/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb';

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
  people: [pazuUrl, peopleCollectionUrl],
  species: [humanUrl, speciesCollectionUrl],
  locations: [gondoaUrl, locationsCollectionUrl],
  vehicles: [airDestroyerGoliathUrl, vehiclesCollectionUrl],
  url:
      'https://ghibli-api.vercel.app/api/films/2baf70d1-42bb-4437-b551-e5fed5a87abe',
);

const pazuDto = PersonDto(
  id: '598f7048-74ff-41e0-92ef-87dc1ad980a9',
  name: 'Pazu',
  url: pazuUrl,
);

const humanDto = SpeciesDto(
  id: '603428ba-8a86-4b0b-a9f1-65df6abef3d3',
  name: 'Human',
  url: humanUrl,
);

const gondoaDto = LocationDto(
  id: '2baf70d1-42bb-4437-b551-e5fed5a87abe',
  name: 'Gondoa',
  url: gondoaUrl,
);

const airDestroyerGoliathDto = VehicleDto(
  id: '4e09b023-f650-4747-9ab9-eacf14540cfb',
  name: 'Air Destroyer Goliath',
  url: airDestroyerGoliathUrl,
);
