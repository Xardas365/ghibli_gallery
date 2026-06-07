import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_gallery/features/films/data/film_infrastructure_providers.dart';
import 'package:ghibli_gallery/features/films/domain/film.dart';
import 'package:ghibli_gallery/features/films/domain/film_details.dart';
import 'package:ghibli_gallery/features/films/domain/film_repository.dart';
import 'package:ghibli_gallery/features/films/presentation/providers/film_providers.dart';

void main() {
  group('film providers', () {
    test('filmsProvider returns films from repository', () async {
      const repository = _FakeFilmRepository(films: [totoro]);
      final container = _createContainer(repository);

      final state = await _readResolvedFilmsState(container);

      expect(
        state,
        isA<AsyncData<List<Film>>>().having(
          (state) => state.value,
          'value',
          [totoro],
        ),
      );
    });

    test(
      'filmDetailsProvider returns details for id from repository',
      () async {
        final repository = _FakeFilmRepository(
          detailsByFilmId: {
            totoro.id: totoroDetails,
          },
        );
        final container = _createContainer(repository);

        final state = await _readResolvedFilmDetailsState(
          container,
          totoro.id,
        );

        expect(
          state,
          isA<AsyncData<FilmDetails>>().having(
            (state) => state.value,
            'value',
            totoroDetails,
          ),
        );
      },
    );

    test('repository fetchFilms error becomes provider error', () async {
      final exception = Exception('films failed');
      final repository = _FakeFilmRepository(fetchFilmsError: exception);
      final container = _createContainer(repository);

      final state = await _readResolvedFilmsState(container);

      expect(state.hasError, isTrue);
      expect(state.error, same(exception));
    });

    test('repository fetchFilmDetails error becomes provider error', () async {
      final exception = Exception('details failed');
      final repository = _FakeFilmRepository(fetchFilmDetailsError: exception);
      final container = _createContainer(repository);

      final state = await _readResolvedFilmDetailsState(container, totoro.id);

      expect(state.hasError, isTrue);
      expect(state.error, same(exception));
    });
  });
}

ProviderContainer _createContainer(FilmRepository repository) {
  final container = ProviderContainer(
    overrides: [
      filmRepositoryProvider.overrideWith((ref) => repository),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

Future<AsyncValue<List<Film>>> _readResolvedFilmsState(
  ProviderContainer container,
) {
  final completer = Completer<AsyncValue<List<Film>>>();
  late final ProviderSubscription<AsyncValue<List<Film>>> subscription;

  subscription = container.listen<AsyncValue<List<Film>>>(
    filmsProvider,
    (_, state) {
      if ((state.hasValue || state.hasError) && !completer.isCompleted) {
        completer.complete(state);
      }
    },
    fireImmediately: true,
  );
  addTearDown(subscription.close);

  return completer.future;
}

Future<AsyncValue<FilmDetails>> _readResolvedFilmDetailsState(
  ProviderContainer container,
  String filmId,
) {
  final completer = Completer<AsyncValue<FilmDetails>>();
  late final ProviderSubscription<AsyncValue<FilmDetails>> subscription;

  subscription = container.listen<AsyncValue<FilmDetails>>(
    filmDetailsProvider(filmId),
    (_, state) {
      if ((state.hasValue || state.hasError) && !completer.isCompleted) {
        completer.complete(state);
      }
    },
    fireImmediately: true,
  );
  addTearDown(subscription.close);

  return completer.future;
}

class _FakeFilmRepository implements FilmRepository {
  const _FakeFilmRepository({
    this.films = const [],
    this.detailsByFilmId = const {},
    this.fetchFilmsError,
    this.fetchFilmDetailsError,
  });

  final List<Film> films;
  final Map<String, FilmDetails> detailsByFilmId;
  final Exception? fetchFilmsError;
  final Exception? fetchFilmDetailsError;

  @override
  Future<List<Film>> fetchFilms() async {
    final error = fetchFilmsError;
    if (error != null) {
      throw error;
    }

    return films;
  }

  @override
  Future<FilmDetails> fetchFilmDetails(String filmId) async {
    final error = fetchFilmDetailsError;
    if (error != null) {
      throw error;
    }

    return detailsByFilmId[filmId]!;
  }
}

const totoro = Film(
  id: 'totoro-id',
  title: 'My Neighbor Totoro',
  description: 'Two sisters move to the countryside.',
  director: 'Hayao Miyazaki',
  producer: 'Toru Hara',
  releaseYear: 1988,
  runningTimeMinutes: 86,
  rtScore: 93,
  image: 'https://example.com/totoro.jpg',
  movieBanner: 'https://example.com/totoro-banner.jpg',
);

const totoroDetails = FilmDetails(
  film: totoro,
  originalTitle: 'となりのトトロ',
  originalTitleRomanised: 'Tonari no Totoro',
  people: ['Satsuki', 'Mei'],
  species: ['Totoro'],
  locations: ['Forest'],
  vehicles: ['Catbus'],
);
