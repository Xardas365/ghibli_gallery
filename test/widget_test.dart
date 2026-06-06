import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/app/ghibli_app.dart';
import 'package:ghibli_entry/features/films/data/film_infrastructure_providers.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie_storage.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/domain/film_details.dart';
import 'package:ghibli_entry/features/films/presentation/providers/film_providers.dart';
import 'package:ghibli_entry/features/films/presentation/screens/film_detail_screen.dart';

void main() {
  testWidgets('gallery shows loading state', (tester) async {
    final completer = Completer<List<Film>>();

    await _pumpApp(
      tester,
      films: (ref) => completer.future,
    );

    expect(find.text('Ghibli Gallery'), findsOneWidget);
    expect(find.text('Loading films...'), findsOneWidget);
  });

  testWidgets('gallery shows empty state', (tester) async {
    await _pumpApp(tester, films: (ref) async => const []);
    await tester.pump();

    expect(find.text('No films are available right now.'), findsOneWidget);
  });

  testWidgets('gallery shows error state with retry button', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => throw Exception('films failed'),
    );
    await tester.pump();

    expect(find.text('We could not load the film gallery.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('gallery renders cards for film data', (tester) async {
    await _pumpApp(tester, films: (ref) async => [totoro]);
    await tester.pump();

    expect(find.text('Ghibli Gallery'), findsOneWidget);
    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text('1988 • Hayao Miyazaki'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
  });

  testWidgets('FilmCard shows title director and year', (tester) async {
    await _pumpApp(tester, films: (ref) async => [totoro]);
    await tester.pump();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text('1988 • Hayao Miyazaki'), findsOneWidget);
  });

  testWidgets('FilmCard shows favorite indicator', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true),
      ],
    );
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('FilmCard shows rating indicator', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: false, rating: 5),
      ],
    );
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('tapping a film opens detail route', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro],
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();

    await tester.tap(find.text('My Neighbor Totoro'));
    await tester.pumpAndSettle();

    expect(find.text('Film detail'), findsOneWidget);
    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text('となりのトトロ'), findsOneWidget);
  });

  testWidgets('detail shows loading state', (tester) async {
    final completer = Completer<FilmDetails>();

    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) => completer.future,
    );

    expect(find.text('Film detail'), findsOneWidget);
    expect(find.text('Loading film details...'), findsOneWidget);
  });

  testWidgets('detail shows error state with retry', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => throw Exception('details failed'),
    );
    await tester.pump();

    expect(find.text('We could not load this film right now.'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('detail shows base film fields', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text('となりのトトロ'), findsOneWidget);
    expect(find.text('Tonari no Totoro'), findsOneWidget);
    expect(find.text('Two sisters move to the countryside.'), findsOneWidget);
    expect(find.text('Director'), findsOneWidget);
    expect(find.text('Hayao Miyazaki'), findsOneWidget);
    expect(find.text('Producer'), findsOneWidget);
    expect(find.text('Toru Hara'), findsOneWidget);
    expect(find.text('Release date'), findsOneWidget);
    expect(find.text('1988'), findsOneWidget);
    expect(find.text('Running time'), findsOneWidget);
    expect(find.text('86 minutes'), findsOneWidget);
    expect(find.text('Rotten Tomatoes'), findsOneWidget);
    expect(find.text('93%'), findsOneWidget);
  });

  testWidgets('retry refetches detail provider', (tester) async {
    var calls = 0;

    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async {
        calls += 1;
        throw Exception('details failed');
      },
    );
    await tester.pump();

    expect(calls, 1);

    await tester.tap(find.text('Retry'));
    await tester.pump();

    expect(calls, 2);
  });

  testWidgets('detail missing image and banner URL does not crash', (
    tester,
  ) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetailsWithoutImage,
    );
    await tester.pump();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.byIcon(Icons.movie_creation_outlined), findsOneWidget);
  });

  testWidgets('detail back action returns to gallery', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro],
      details: (ref, filmId) async => throw Exception('details failed'),
    );
    await tester.pump();

    await tester.tap(find.text('My Neighbor Totoro'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Ghibli Gallery'), findsOneWidget);
  });

  testWidgets('missing image URL does not crash', (tester) async {
    await _pumpApp(tester, films: (ref) async => [totoroWithoutImage]);
    await tester.pump();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.byIcon(Icons.movie_creation_outlined), findsOneWidget);
  });

  testWidgets('opens favorites and returns to gallery', (tester) async {
    await _pumpApp(tester, films: (ref) async => [totoro]);
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('Favorites'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Ghibli Gallery'), findsOneWidget);
  });
}

Future<void> _pumpApp(
  WidgetTester tester, {
  required FutureOr<List<Film>> Function(dynamic ref) films,
  FutureOr<FilmDetails> Function(dynamic ref, String filmId)? details,
  List<FavoriteMovie> userData = const [],
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        filmsProvider.overrideWith(films),
        if (details != null) filmDetailsProvider.overrideWith(details),
        favoriteMovieStorageProvider.overrideWith((ref) async {
          return _FakeFavoriteMovieStorage(userData);
        }),
      ],
      child: const GhibliApp(),
    ),
  );
}

Future<void> _pumpDetailScreen(
  WidgetTester tester, {
  required FutureOr<FilmDetails> Function(dynamic ref, String filmId) details,
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        filmDetailsProvider.overrideWith(details),
      ],
      child: const MaterialApp(
        home: FilmDetailScreen(filmId: 'totoro-id'),
      ),
    ),
  );
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

const totoroWithoutImage = Film(
  id: 'totoro-id',
  title: 'My Neighbor Totoro',
  description: 'Two sisters move to the countryside.',
  director: 'Hayao Miyazaki',
  producer: 'Toru Hara',
  releaseYear: 1988,
  runningTimeMinutes: 86,
  rtScore: 93,
  image: '',
  movieBanner: '',
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

const totoroDetailsWithoutImage = FilmDetails(
  film: totoroWithoutImage,
  originalTitle: 'となりのトトロ',
  originalTitleRomanised: 'Tonari no Totoro',
  people: ['Satsuki', 'Mei'],
  species: ['Totoro'],
  locations: ['Forest'],
  vehicles: ['Catbus'],
);

class _FakeFavoriteMovieStorage implements FavoriteMovieStorage {
  _FakeFavoriteMovieStorage(List<FavoriteMovie> movies) {
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
