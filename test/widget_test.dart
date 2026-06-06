import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/app/ghibli_app.dart';

void main() {
  testWidgets('shows the gallery shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: GhibliApp()));

    expect(find.text('Ghibli Gallery'), findsOneWidget);
    expect(find.text('Films'), findsOneWidget);
  });

  testWidgets('opens film detail with a filmId', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: GhibliApp()));

    await tester.tap(find.text('Films'));
    await tester.pumpAndSettle();

    expect(find.text('Film detail'), findsOneWidget);
    expect(find.text('Film ID: placeholder-film-id'), findsOneWidget);
  });

  testWidgets('opens favorites and returns to gallery', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: GhibliApp()));

    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('Favorites'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Ghibli Gallery'), findsOneWidget);
  });
}
