import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/features/films/data/film_infrastructure_providers.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie_storage.dart';
import 'package:ghibli_entry/features/films/presentation/providers/favorite_movie_providers.dart';

void main() {
  group('favorite movie providers', () {
    test('initial state loads persisted favorite movies', () async {
      final storage = _FakeFavoriteMovieStorage([
        FavoriteMovie(filmId: 'film-id', isFavorite: true, rating: 4),
      ]);
      final container = _createContainer(storage);

      final state = await _readResolvedFavoriteMovieState(container);

      expect(
        state,
        isA<AsyncData<List<FavoriteMovie>>>().having(
          (state) => state.value,
          'value',
          [FavoriteMovie(filmId: 'film-id', isFavorite: true, rating: 4)],
        ),
      );
    });

    test('toggle favorite updates provider state', () async {
      final storage = _FakeFavoriteMovieStorage();
      final container = _createContainer(storage);
      await _readResolvedFavoriteMovieState(container);

      await container
          .read(favoriteMovieControllerProvider.notifier)
          .toggleFavorite('film-id');

      final state = container.read(favoriteMovieControllerProvider);
      expect(state.value, [
        FavoriteMovie(filmId: 'film-id', isFavorite: true),
      ]);
    });

    test('toggle favorite persists to storage', () async {
      final storage = _FakeFavoriteMovieStorage();
      final container = _createContainer(storage);
      await _readResolvedFavoriteMovieState(container);

      await container
          .read(favoriteMovieControllerProvider.notifier)
          .toggleFavorite('film-id');

      expect(
        await storage.getByFilmId('film-id'),
        FavoriteMovie(filmId: 'film-id', isFavorite: true),
      );
    });

    test('setting rating updates provider state', () async {
      final storage = _FakeFavoriteMovieStorage();
      final container = _createContainer(storage);
      await _readResolvedFavoriteMovieState(container);

      await container
          .read(favoriteMovieControllerProvider.notifier)
          .setRating('film-id', 5);

      final state = container.read(favoriteMovieControllerProvider);
      expect(state.value, [
        FavoriteMovie(filmId: 'film-id', isFavorite: false, rating: 5),
      ]);
    });

    test('setting rating persists to storage', () async {
      final storage = _FakeFavoriteMovieStorage();
      final container = _createContainer(storage);
      await _readResolvedFavoriteMovieState(container);

      await container
          .read(favoriteMovieControllerProvider.notifier)
          .setRating('film-id', 3);

      expect(
        await storage.getByFilmId('film-id'),
        FavoriteMovie(filmId: 'film-id', isFavorite: false, rating: 3),
      );
    });

    test(
      'invalid rating throws clearly and updates provider error state',
      () async {
        final storage = _FakeFavoriteMovieStorage();
        final container = _createContainer(storage);
        await _readResolvedFavoriteMovieState(container);

        await expectLater(
          container
              .read(favoriteMovieControllerProvider.notifier)
              .setRating('film-id', 6),
          throwsA(isA<ArgumentError>()),
        );

        final state = container.read(favoriteMovieControllerProvider);
        expect(state.hasError, isTrue);
        expect(state.error, isA<ArgumentError>());
      },
    );

    test('removing favorite preserves rating', () async {
      final storage = _FakeFavoriteMovieStorage([
        FavoriteMovie(filmId: 'film-id', isFavorite: true, rating: 4),
      ]);
      final container = _createContainer(storage);
      await _readResolvedFavoriteMovieState(container);

      await container
          .read(favoriteMovieControllerProvider.notifier)
          .toggleFavorite('film-id');

      final expected = FavoriteMovie(
        filmId: 'film-id',
        isFavorite: false,
        rating: 4,
      );
      expect(container.read(favoriteMovieControllerProvider).value, [expected]);
      expect(await storage.getByFilmId('film-id'), expected);
    });

    test('favoriteMovieByFilmIdProvider returns correct user data', () async {
      final movie = FavoriteMovie(
        filmId: 'film-id',
        isFavorite: true,
        rating: 2,
      );
      final storage = _FakeFavoriteMovieStorage([movie]);
      final container = _createContainer(storage);

      final state = await _readResolvedFavoriteMovieByFilmIdState(
        container,
        'film-id',
      );

      expect(state.value, movie);
    });

    test('ratingFilterProvider filters favorites correctly', () async {
      final matchingMovie = FavoriteMovie(
        filmId: 'matching-film-id',
        isFavorite: true,
        rating: 5,
      );
      final storage = _FakeFavoriteMovieStorage([
        matchingMovie,
        FavoriteMovie(filmId: 'other-film-id', isFavorite: true, rating: 3),
        FavoriteMovie(filmId: 'rated-film-id', isFavorite: false, rating: 5),
      ]);
      final container = _createContainer(storage);
      await _readResolvedFavoriteMovieState(container);

      container.read(ratingFilterProvider.notifier).setRating(5);

      expect(container.read(filteredFavoriteMoviesProvider).value, [
        matchingMovie,
      ]);
    });

    test('clearing rating filter restores all favorites', () async {
      final movies = [
        FavoriteMovie(filmId: 'first-film-id', isFavorite: true, rating: 5),
        FavoriteMovie(filmId: 'second-film-id', isFavorite: true, rating: 3),
      ];
      final storage = _FakeFavoriteMovieStorage(movies);
      final container = _createContainer(storage);
      await _readResolvedFavoriteMovieState(container);

      container.read(ratingFilterProvider.notifier).setRating(5);
      container.read(ratingFilterProvider.notifier).clear();

      expect(container.read(filteredFavoriteMoviesProvider).value, movies);
    });

    test('async storage initialization is handled correctly', () async {
      final storage = _FakeFavoriteMovieStorage([
        FavoriteMovie(filmId: 'film-id', isFavorite: true),
      ]);
      final storageCompleter = Completer<FavoriteMovieStorage>();
      final container = _createContainer(storageCompleter.future);

      final loadingState = container.read(favoriteMovieControllerProvider);
      expect(loadingState.isLoading, isTrue);

      storageCompleter.complete(storage);
      final state = await _readResolvedFavoriteMovieState(container);

      expect(state.value, [FavoriteMovie(filmId: 'film-id', isFavorite: true)]);
    });
  });
}

ProviderContainer _createContainer(Object storage) {
  final storageFuture = storage is Future<FavoriteMovieStorage>
      ? storage
      : Future<FavoriteMovieStorage>.value(storage as FavoriteMovieStorage);
  final container = ProviderContainer(
    overrides: [
      favoriteMovieStorageProvider.overrideWith((ref) => storageFuture),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

Future<AsyncValue<List<FavoriteMovie>>> _readResolvedFavoriteMovieState(
  ProviderContainer container,
) {
  final completer = Completer<AsyncValue<List<FavoriteMovie>>>();
  late final ProviderSubscription<AsyncValue<List<FavoriteMovie>>> subscription;

  subscription = container.listen<AsyncValue<List<FavoriteMovie>>>(
    favoriteMovieControllerProvider,
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

Future<AsyncValue<FavoriteMovie?>> _readResolvedFavoriteMovieByFilmIdState(
  ProviderContainer container,
  String filmId,
) {
  final completer = Completer<AsyncValue<FavoriteMovie?>>();
  late final ProviderSubscription<AsyncValue<FavoriteMovie?>> subscription;

  subscription = container.listen<AsyncValue<FavoriteMovie?>>(
    favoriteMovieByFilmIdProvider(filmId),
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

class _FakeFavoriteMovieStorage implements FavoriteMovieStorage {
  _FakeFavoriteMovieStorage([List<FavoriteMovie> movies = const []]) {
    for (final movie in movies) {
      _moviesByFilmId[movie.filmId] = movie;
    }
  }

  final _moviesByFilmId = <String, FavoriteMovie>{};

  @override
  Future<List<FavoriteMovie>> getAll() async {
    return _moviesByFilmId.values.toList(growable: false);
  }

  @override
  Future<FavoriteMovie?> getByFilmId(String filmId) async {
    return _moviesByFilmId[filmId];
  }

  @override
  Future<void> save(FavoriteMovie movie) async {
    _moviesByFilmId[movie.filmId] = movie;
  }

  @override
  Future<FavoriteMovie> setFavorite(
    String filmId, {
    required bool isFavorite,
  }) async {
    final movie =
        _moviesByFilmId[filmId]?.copyWith(
          isFavorite: isFavorite,
        ) ??
        FavoriteMovie(filmId: filmId, isFavorite: isFavorite);
    _moviesByFilmId[filmId] = movie;
    return movie;
  }

  @override
  Future<FavoriteMovie> setRating(String filmId, int? rating) async {
    final movie =
        _moviesByFilmId[filmId]?.copyWith(
          rating: rating,
        ) ??
        FavoriteMovie(filmId: filmId, isFavorite: false, rating: rating);
    _moviesByFilmId[filmId] = movie;
    return movie;
  }
}
