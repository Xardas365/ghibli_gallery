import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/app/ghibli_app.dart';

void main() {
  testWidgets('shows the gallery shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: GhibliApp()));

    expect(find.text('Ghibli Gallery'), findsOneWidget);
    expect(find.text('Films'), findsOneWidget);
  });
}
