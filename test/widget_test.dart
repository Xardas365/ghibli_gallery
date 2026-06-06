import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/app/ghibli_app.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/presentation/providers/film_providers.dart';

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

  testWidgets('gallery shows film data', (tester) async {
    await _pumpApp(tester, films: (ref) async => [totoro]);
    await tester.pump();

    expect(find.text('Ghibli Gallery'), findsOneWidget);
    expect(find.text('My Neighbor Totoro'), findsOneWidget);
    expect(find.text('Hayao Miyazaki'), findsOneWidget);
  });

  testWidgets('tapping a film opens detail route', (tester) async {
    await _pumpApp(tester, films: (ref) async => [totoro]);
    await tester.pump();

    await tester.tap(find.text('My Neighbor Totoro'));
    await tester.pumpAndSettle();

    expect(find.text('Film detail'), findsOneWidget);
    expect(find.text('Film ID: totoro-id'), findsOneWidget);
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
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        filmsProvider.overrideWith(films),
      ],
      child: const GhibliApp(),
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
