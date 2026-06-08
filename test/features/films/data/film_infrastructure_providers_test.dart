import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_gallery/features/films/data/film_infrastructure_providers.dart';
import 'package:ghibli_gallery/features/films/data/film_repository_impl.dart';
import 'package:ghibli_gallery/features/films/data/shared_preferences_favorite_movie_storage.dart';
import 'package:ghibli_gallery/features/films/domain/favorite_movie_storage.dart';
import 'package:ghibli_gallery/features/films/domain/film_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('film infrastructure providers', () {
    test('provides FilmRepository implementation', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final repository = container.read(filmRepositoryProvider);

      expect(repository, isA<FilmRepository>());
      expect(repository, isA<FilmRepositoryImpl>());
    });

    test('provides SharedPreferences FavoriteMovieStorage', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final storage = await container.read(favoriteMovieStorageProvider.future);

      expect(storage, isA<FavoriteMovieStorage>());
      expect(storage, isA<SharedPreferencesFavoriteMovieStorage>());
    });
  });
}
