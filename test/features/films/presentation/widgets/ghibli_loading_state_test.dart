import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/ghibli_loading_state.dart';

void main() {
  testWidgets('GhibliLoadingState handles very short screens', (tester) async {
    tester.view.physicalSize = const Size(320, 300);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GhibliLoadingState(
            primaryText: 'Catbus is on the way...',
            secondaryText: 'Loading the Ghibli collection...',
          ),
        ),
      ),
    );

    expect(find.byType(GhibliLoadingState), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
