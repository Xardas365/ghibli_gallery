import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_gallery/features/films/presentation/film_ui_constants.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/ghibli_cached_image.dart';

void main() {
  group('GhibliCachedImage', () {
    testWidgets('shows fallback for empty image URL', (tester) async {
      await _pumpCachedImage(
        tester,
        const GhibliCachedImage(imageUrl: ' '),
      );

      expect(find.byKey(ghibliImageFallbackKey), findsOneWidget);
    });

    testWidgets('uses deterministic gallery placeholder for stable key', (
      tester,
    ) async {
      const image = GhibliCachedImage(
        imageUrl: 'https://example.com/gallery-placeholder-source.png',
        placeholderSet: GhibliPlaceholderSet.gallery,
        placeholderKey: 'film-1',
      );

      await _pumpCachedImage(tester, image);
      final firstPath = _singleAssetPathIn(
        tester,
        FilmAssets.galleryPlaceholders,
      );

      await _pumpCachedImage(tester, image);
      final secondPath = _singleAssetPathIn(
        tester,
        FilmAssets.galleryPlaceholders,
      );

      expect(FilmAssets.galleryPlaceholders, contains(firstPath));
      expect(secondPath, firstPath);
    });

    testWidgets('uses deterministic wide placeholder for stable key', (
      tester,
    ) async {
      const image = GhibliCachedImage(
        imageUrl: 'https://example.com/wide-placeholder-source.png',
        placeholderSet: GhibliPlaceholderSet.wide,
        placeholderKey: 'film-1',
      );

      await _pumpCachedImage(tester, image);
      final firstPath = _singleAssetPathIn(
        tester,
        FilmAssets.widePlaceholders,
      );

      await _pumpCachedImage(tester, image);
      final secondPath = _singleAssetPathIn(
        tester,
        FilmAssets.widePlaceholders,
      );

      expect(FilmAssets.widePlaceholders, contains(firstPath));
      expect(secondPath, firstPath);
    });

    testWidgets('shows deterministic placeholder while image is loading', (
      tester,
    ) async {
      await _pumpCachedImage(
        tester,
        const GhibliCachedImage(
          imageUrl: 'https://example.com/slow-ghibli-poster.png',
          placeholderSet: GhibliPlaceholderSet.gallery,
          placeholderKey: 'loading-film',
        ),
      );

      final placeholderPath = _singleAssetPathIn(
        tester,
        FilmAssets.galleryPlaceholders,
      );

      expect(FilmAssets.galleryPlaceholders, contains(placeholderPath));
      expect(find.byKey(ghibliImageFallbackKey), findsNothing);
    });
  });
}

Future<void> _pumpCachedImage(
  WidgetTester tester,
  GhibliCachedImage image,
) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 180,
            height: 120,
            child: image,
          ),
        ),
      ),
    ),
  );
}

String _singleAssetPathIn(
  WidgetTester tester,
  List<String> allowedPaths,
) {
  final paths = _assetImagePaths(
    tester,
  ).where(allowedPaths.contains).toList(growable: false);

  expect(paths, hasLength(1));
  return paths.single;
}

List<String> _assetImagePaths(WidgetTester tester) {
  final paths = <String>[];

  for (final widget in tester.widgetList<Image>(find.byType(Image))) {
    final imageProvider = widget.image;
    if (imageProvider is AssetImage) {
      paths.add(imageProvider.assetName);
    }
  }

  return paths;
}
