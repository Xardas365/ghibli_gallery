import 'package:flutter/material.dart';
import 'package:ghibli_entry/features/films/presentation/screens/favorite_films_screen.dart';
import 'package:ghibli_entry/features/films/presentation/screens/film_detail_screen.dart';
import 'package:ghibli_entry/features/films/presentation/screens/film_gallery_screen.dart';

abstract final class AppRoutes {
  static const gallery = '/';
  static const filmDetail = '/film';
  static const favorites = '/favorites';
}

abstract final class AppRouter {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case AppRoutes.gallery:
            return const FilmGalleryScreen();
          case AppRoutes.filmDetail:
            final filmId = settings.arguments as String?;
            return FilmDetailScreen(filmId: filmId ?? '');
          case AppRoutes.favorites:
            return const FavoriteFilmsScreen();
          default:
            return const FilmGalleryScreen();
        }
      },
    );
  }
}
