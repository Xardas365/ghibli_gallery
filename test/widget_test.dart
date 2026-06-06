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
import 'package:ghibli_entry/features/films/presentation/screens/favorite_films_screen.dart';
import 'package:ghibli_entry/features/films/presentation/screens/film_detail_screen.dart';

void main() {
  testWidgets('gallery shows loading state', (tester) async {
    final completer = Completer<List<Film>>();

    await _pumpApp(
      tester,
      films: (ref) => completer.future,
    );

    expect(find.text('Ghibli Gallery'), findsOneWidget);
    expect(find.text('Loading the Ghibli collection...'), findsOneWidget);
  });

  testWidgets('gallery shows empty state', (tester) async {
    await _pumpApp(tester, films: (ref) async => const []);
    await tester.pump();

    expect(
      find.text('No films are available right now. Please try again later.'),
      findsOneWidget,
    );
  });

  testWidgets('gallery shows error state with retry button', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => throw Exception('films failed'),
    );
    await tester.pump();

    expect(
      find.text('The film gallery could not be loaded right now.'),
      findsOneWidget,
    );
    expect(find.text('Try again'), findsOneWidget);
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

    expect(
      find.descendant(
        of: find.byType(Card),
        matching: find.byIcon(Icons.star),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(Card),
        matching: find.text('5'),
      ),
      findsOneWidget,
    );
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

  testWidgets('detail shows favorite button', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Favorite'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
  });

  testWidgets('tapping favorite button marks film as favorite', (
    tester,
  ) async {
    final storage = _FakeFavoriteMovieStorage();

    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
      storage: storage,
    );
    await tester.pump();
    await tester.pump();

    await tester.ensureVisible(find.text('Favorite'));
    await tester.pump();
    await tester.tap(find.text('Favorite'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Favorited'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(
      await storage.getByFilmId(totoro.id),
      FavoriteMovie(filmId: totoro.id, isFavorite: true),
    );
  });

  testWidgets('tapping favorite button again removes favorite', (
    tester,
  ) async {
    final storage = _FakeFavoriteMovieStorage(
      movies: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true),
      ],
    );

    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
      storage: storage,
    );
    await tester.pump();
    await tester.pump();

    await tester.ensureVisible(find.text('Favorited'));
    await tester.pump();
    await tester.tap(find.text('Favorited'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Favorite'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
    expect(
      await storage.getByFilmId(totoro.id),
      FavoriteMovie(filmId: totoro.id, isFavorite: false),
    );
  });

  testWidgets('removing favorite preserves rating on detail', (tester) async {
    final storage = _FakeFavoriteMovieStorage(
      movies: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 4),
      ],
    );

    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
      storage: storage,
    );
    await tester.pump();
    await tester.pump();

    await tester.ensureVisible(find.text('Favorited'));
    await tester.pump();
    await tester.tap(find.text('Favorited'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Favorite'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(4));
    expect(
      await storage.getByFilmId(totoro.id),
      FavoriteMovie(filmId: totoro.id, isFavorite: false, rating: 4),
    );
  });

  testWidgets('detail shows rating stars', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();
    await tester.pump();

    expect(find.byTooltip('Rate 1 star'), findsOneWidget);
    expect(find.byTooltip('Rate 2 stars'), findsOneWidget);
    expect(find.byTooltip('Rate 3 stars'), findsOneWidget);
    expect(find.byTooltip('Rate 4 stars'), findsOneWidget);
    expect(find.byTooltip('Rate 5 stars'), findsOneWidget);
    expect(find.byIcon(Icons.star_border), findsNWidgets(5));
  });

  testWidgets('tapping a rating star updates rating', (tester) async {
    final storage = _FakeFavoriteMovieStorage();

    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
      storage: storage,
    );
    await tester.pump();
    await tester.pump();

    await tester.ensureVisible(find.byTooltip('Rate 3 stars'));
    await tester.pump();
    await tester.tap(find.byTooltip('Rate 3 stars'));
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.star), findsNWidgets(3));
    expect(
      await storage.getByFilmId(totoro.id),
      FavoriteMovie(filmId: totoro.id, isFavorite: false, rating: 3),
    );
  });

  testWidgets('selected rating is visible', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
      storage: _FakeFavoriteMovieStorage(
        movies: [
          FavoriteMovie(filmId: totoro.id, isFavorite: false, rating: 5),
        ],
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.star), findsNWidgets(5));
    expect(find.text('Clear rating'), findsOneWidget);
  });

  testWidgets('invalid rating is not possible from detail UI', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();
    await tester.pump();

    expect(find.byTooltip('Rate 0 stars'), findsNothing);
    expect(find.byTooltip('Rate 6 stars'), findsNothing);
  });

  testWidgets('provider storage error does not crash detail screen', (
    tester,
  ) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
      storage: _FakeFavoriteMovieStorage(throwOnSetFavorite: true),
    );
    await tester.pump();
    await tester.pump();

    await tester.ensureVisible(find.text('Favorite'));
    await tester.pump();
    await tester.tap(find.text('Favorite'));
    await tester.pump();
    await tester.pump();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(
      find.text('Could not save your favorite or rating.'),
      findsWidgets,
    );
  });

  testWidgets('detail people section renders mapped people', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();

    expect(find.text('People'), findsOneWidget);
    expect(find.text('Satsuki'), findsOneWidget);
    expect(find.text('Mei'), findsOneWidget);
  });

  testWidgets('detail species section renders mapped species', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();

    expect(find.text('Species'), findsOneWidget);
    expect(find.text('Totoro'), findsOneWidget);
  });

  testWidgets('detail locations section renders mapped locations', (
    tester,
  ) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();

    expect(find.text('Locations'), findsOneWidget);
    expect(find.text('Forest'), findsOneWidget);
  });

  testWidgets('detail vehicles section renders mapped vehicles', (
    tester,
  ) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetails,
    );
    await tester.pump();

    expect(find.text('Vehicles'), findsOneWidget);
    expect(find.text('Catbus'), findsOneWidget);
  });

  testWidgets('detail empty related sections show empty-state copy', (
    tester,
  ) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetailsWithoutRelatedData,
    );
    await tester.pump();

    expect(find.text('People'), findsOneWidget);
    expect(find.text('Species'), findsOneWidget);
    expect(find.text('Locations'), findsOneWidget);
    expect(find.text('Vehicles'), findsOneWidget);
    expect(find.text('No data available'), findsNWidgets(4));
  });

  testWidgets('detail does not show raw related resource URLs', (tester) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetailsWithRawUrls,
    );
    await tester.pump();

    expect(find.text('Satsuki'), findsOneWidget);
    expect(find.text('Catbus'), findsOneWidget);
    expect(
      find.text('https://ghibli-api.vercel.app/api/people/'),
      findsNothing,
    );
    expect(
      find.text('https://ghibli-api.vercel.app/api/species/species-id'),
      findsNothing,
    );
    expect(
      find.text('https://ghibli-api.vercel.app/api/locations/location-id'),
      findsNothing,
    );
    expect(
      find.text('https://ghibli-api.vercel.app/api/vehicles/vehicle-id'),
      findsNothing,
    );
  });

  testWidgets('detail still renders when all related lists are empty', (
    tester,
  ) async {
    await _pumpDetailScreen(
      tester,
      details: (ref, filmId) async => totoroDetailsWithoutRelatedData,
    );
    await tester.pump();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text('No data available'), findsNWidgets(4));
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

  testWidgets('favorites screen shows empty state when no favorites exist', (
    tester,
  ) async {
    await _pumpApp(tester, films: (ref) async => [totoro]);
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('Favorites'), findsOneWidget);
    expect(
      find.text(
        'No favorite films yet. Mark films as favorites from their detail pages.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('favorites screen shows favorited films', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro, kiki],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });

  testWidgets('rating filter UI is visible', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 5),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('Rating filter'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'All'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, '5'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, '3'), findsOneWidget);
  });

  testWidgets('favorites screen does not show non-favorited films', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro, kiki],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true),
        FavoriteMovie(filmId: kiki.id, isFavorite: false, rating: 5),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text("Kiki's Delivery Service"), findsNothing);
  });

  testWidgets('selecting rating 5 shows only 5-star favorites', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro, kiki],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 5),
        FavoriteMovie(filmId: kiki.id, isFavorite: true, rating: 3),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '5'));
    await tester.pumpAndSettle();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text("Kiki's Delivery Service"), findsNothing);
  });

  testWidgets('selecting rating 3 shows only 3-star favorites', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro, kiki],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 5),
        FavoriteMovie(filmId: kiki.id, isFavorite: true, rating: 3),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '3'));
    await tester.pumpAndSettle();

    expect(find.text("Kiki's Delivery Service"), findsOneWidget);
    expect(find.text('My Neighbor Totoro'), findsNothing);
  });

  testWidgets('rating filter hides non-matching favorites', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro, kiki],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 5),
        FavoriteMovie(filmId: kiki.id, isFavorite: true, rating: 3),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '5'));
    await tester.pumpAndSettle();

    expect(find.text("Kiki's Delivery Service"), findsNothing);
  });

  testWidgets('clearing rating filter restores all favorites', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro, kiki],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 5),
        FavoriteMovie(filmId: kiki.id, isFavorite: true, rating: 3),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '5'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'All'));
    await tester.pumpAndSettle();

    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text("Kiki's Delivery Service"), findsOneWidget);
  });

  testWidgets('empty filtered state is shown when no favorite matches', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro, kiki],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 5),
        FavoriteMovie(filmId: kiki.id, isFavorite: true, rating: 3),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '1'));
    await tester.pumpAndSettle();

    expect(find.text('No favorites match this rating yet.'), findsOneWidget);
    expect(find.text('My Neighbor Totoro'), findsNothing);
    expect(find.text("Kiki's Delivery Service"), findsNothing);
  });

  testWidgets('favorite rating is visible on favorites screen', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro],
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 5),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(Card),
        matching: find.byIcon(Icons.star),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(Card),
        matching: find.text('5'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('tapping a favorite film opens detail', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro],
      details: (ref, filmId) async => totoroDetails,
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Neighbor Totoro'));
    await tester.pumpAndSettle();

    expect(find.text('Film detail'), findsOneWidget);
    expect(find.text('となりのトトロ'), findsOneWidget);
  });

  testWidgets('tapping filtered favorite still opens detail', (tester) async {
    await _pumpApp(
      tester,
      films: (ref) async => [totoro, kiki],
      details: (ref, filmId) async => totoroDetails,
      userData: [
        FavoriteMovie(filmId: totoro.id, isFavorite: true, rating: 5),
        FavoriteMovie(filmId: kiki.id, isFavorite: true, rating: 3),
      ],
    );
    await tester.pump();
    await tester.pump();

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '5'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Neighbor Totoro'));
    await tester.pumpAndSettle();

    expect(find.text('Film detail'), findsOneWidget);
    expect(find.text('となりのトトロ'), findsOneWidget);
  });

  testWidgets('favorites screen loading state does not crash', (tester) async {
    final filmsCompleter = Completer<List<Film>>();

    await _pumpFavoritesScreen(
      tester,
      films: (ref) => filmsCompleter.future,
    );

    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Loading favorite films...'), findsOneWidget);
  });

  testWidgets('favorites screen error state does not crash', (tester) async {
    await _pumpFavoritesScreen(
      tester,
      films: (ref) async => throw Exception('films failed'),
    );
    await tester.pump();

    expect(find.text('Favorites'), findsOneWidget);
    expect(
      find.text('Your favorite films could not be loaded right now.'),
      findsOneWidget,
    );
  });

  testWidgets('favorites screen user data error state does not crash', (
    tester,
  ) async {
    await _pumpFavoritesScreen(
      tester,
      films: (ref) async => [totoro],
      storage: _FakeFavoriteMovieStorage(throwOnGetAll: true),
    );
    await tester.pump();

    expect(find.text('Favorites'), findsOneWidget);
    expect(
      find.text('Your favorite films could not be loaded right now.'),
      findsOneWidget,
    );
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
          return _FakeFavoriteMovieStorage(movies: userData);
        }),
      ],
      child: const GhibliApp(),
    ),
  );
}

Future<void> _pumpDetailScreen(
  WidgetTester tester, {
  required FutureOr<FilmDetails> Function(dynamic ref, String filmId) details,
  _FakeFavoriteMovieStorage? storage,
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        filmDetailsProvider.overrideWith(details),
        favoriteMovieStorageProvider.overrideWith((ref) async {
          return storage ?? _FakeFavoriteMovieStorage();
        }),
      ],
      child: const MaterialApp(
        home: FilmDetailScreen(filmId: 'totoro-id'),
      ),
    ),
  );
}

Future<void> _pumpFavoritesScreen(
  WidgetTester tester, {
  required FutureOr<List<Film>> Function(dynamic ref) films,
  _FakeFavoriteMovieStorage? storage,
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        filmsProvider.overrideWith(films),
        favoriteMovieStorageProvider.overrideWith((ref) async {
          return storage ?? _FakeFavoriteMovieStorage();
        }),
      ],
      child: const MaterialApp(
        home: FavoriteFilmsScreen(),
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

const kiki = Film(
  id: 'kiki-id',
  title: "Kiki's Delivery Service",
  description: 'A young witch starts a delivery business.',
  director: 'Hayao Miyazaki',
  producer: 'Hayao Miyazaki',
  releaseYear: 1989,
  runningTimeMinutes: 103,
  rtScore: 98,
  image: 'https://example.com/kiki.jpg',
  movieBanner: 'https://example.com/kiki-banner.jpg',
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

const totoroDetailsWithoutRelatedData = FilmDetails(
  film: totoro,
  originalTitle: 'となりのトトロ',
  originalTitleRomanised: 'Tonari no Totoro',
  people: [],
  species: [],
  locations: [],
  vehicles: [],
);

const totoroDetailsWithRawUrls = FilmDetails(
  film: totoro,
  originalTitle: 'となりのトトロ',
  originalTitleRomanised: 'Tonari no Totoro',
  people: [
    'Satsuki',
    'https://ghibli-api.vercel.app/api/people/',
  ],
  species: [
    'https://ghibli-api.vercel.app/api/species/species-id',
  ],
  locations: [
    'https://ghibli-api.vercel.app/api/locations/location-id',
  ],
  vehicles: [
    'Catbus',
    'https://ghibli-api.vercel.app/api/vehicles/vehicle-id',
  ],
);

class _FakeFavoriteMovieStorage implements FavoriteMovieStorage {
  _FakeFavoriteMovieStorage({
    List<FavoriteMovie> movies = const [],
    this.throwOnGetAll = false,
    this.throwOnSetFavorite = false,
  }) {
    for (final movie in movies) {
      _moviesByFilmId[movie.filmId] = movie;
    }
  }

  final _moviesByFilmId = <String, FavoriteMovie>{};
  final bool throwOnGetAll;
  final bool throwOnSetFavorite;

  @override
  Future<List<FavoriteMovie>> getAll() async {
    if (throwOnGetAll) {
      throw StateError('favorites failed');
    }

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
    if (throwOnSetFavorite) {
      throw StateError('favorite failed');
    }

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
