import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_gallery/core/network/network_providers.dart';
import 'package:ghibli_gallery/features/films/data/api/film_api.dart';
import 'package:ghibli_gallery/features/films/data/film_repository_impl.dart';
import 'package:ghibli_gallery/features/films/data/shared_preferences_favorite_movie_storage.dart';
import 'package:ghibli_gallery/features/films/domain/favorite_movie_storage.dart';
import 'package:ghibli_gallery/features/films/domain/film_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final filmApiProvider = Provider<FilmApi>((ref) {
  return FilmApi(ref.watch(apiClientProvider));
});

final filmRepositoryProvider = Provider<FilmRepository>((ref) {
  return FilmRepositoryImpl(api: ref.watch(filmApiProvider));
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final favoriteMovieStorageProvider = FutureProvider<FavoriteMovieStorage>((
  ref,
) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  return SharedPreferencesFavoriteMovieStorage(preferences: preferences);
});
