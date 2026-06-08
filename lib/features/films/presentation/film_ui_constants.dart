import 'package:flutter/widgets.dart';

abstract final class FilmAssets {
  static const galleryTitle = 'assets/images/gallery_title.png';
  static const fallback = 'assets/images/fallback.gif';
  static const loading = 'assets/images/loading.gif';
  static const noMovies = 'assets/images/no_movies.png';
  static const tomatoScore = 'assets/images/tomato_score.svg';

  static const galleryPlaceholders = [
    'assets/images/placeholder/1.png',
    'assets/images/placeholder/2.png',
    'assets/images/placeholder/3.png',
  ];

  static const widePlaceholders = [
    'assets/images/placeholder/wide_1.png',
    'assets/images/placeholder/wide_2.png',
    'assets/images/placeholder/wide_3.png',
    'assets/images/placeholder/wide_4.png',
    'assets/images/placeholder/wide_5.png',
    'assets/images/placeholder/wide_6.png',
  ];
}

abstract final class FilmGridLayout {
  static const favoritesPadding = EdgeInsets.fromLTRB(16, 12, 16, 28);
  static const mainAxisSpacing = 18.0;
  static const crossAxisSpacing = 16.0;
  static const childAspectRatio = 0.64;

  static const largeWidth = 900.0;
  static const mediumWidth = 680.0;
  static const compactWidth = 460.0;

  static const largeColumnCount = 5;
  static const mediumColumnCount = 4;
  static const compactColumnCount = 3;
  static const narrowColumnCount = 2;
}

abstract final class FilmRatingBounds {
  static const min = 1;
  static const max = 5;
}
