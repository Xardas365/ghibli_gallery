import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_gallery/features/films/data/film_infrastructure_providers.dart';
import 'package:ghibli_gallery/features/films/domain/favorite_movie.dart';
import 'package:ghibli_gallery/features/films/presentation/film_ui_constants.dart';

final favoriteMovieControllerProvider =
    AsyncNotifierProvider<FavoriteMovieController, List<FavoriteMovie>>(
      FavoriteMovieController.new,
    );

// Riverpod 3 does not export the concrete family type used by this provider.
// ignore: specify_nonobvious_property_types
final favoriteMovieByFilmIdProvider =
    Provider.family<AsyncValue<FavoriteMovie?>, String>((ref, filmId) {
      return ref.watch(favoriteMovieControllerProvider).whenData((movies) {
        for (final movie in movies) {
          if (movie.filmId == filmId) {
            return movie;
          }
        }
        return null;
      });
    });

final NotifierProvider<RatingFilter, int?> ratingFilterProvider =
    NotifierProvider<RatingFilter, int?>(RatingFilter.new);

final favoriteMoviesProvider = Provider<AsyncValue<List<FavoriteMovie>>>((ref) {
  return ref.watch(favoriteMovieControllerProvider).whenData((movies) {
    return movies.where((movie) => movie.isFavorite).toList(growable: false);
  });
});

final filteredFavoriteMoviesProvider =
    Provider<AsyncValue<List<FavoriteMovie>>>((ref) {
      final ratingFilter = ref.watch(ratingFilterProvider);

      return ref.watch(favoriteMoviesProvider).whenData((movies) {
        if (ratingFilter == null) {
          return movies;
        }

        return movies
            .where((movie) => movie.rating == ratingFilter)
            .toList(growable: false);
      });
    });

class FavoriteMovieController extends AsyncNotifier<List<FavoriteMovie>> {
  @override
  Future<List<FavoriteMovie>> build() async {
    final storage = await ref.watch(favoriteMovieStorageProvider.future);
    return storage.getAll();
  }

  Future<void> toggleFavorite(String filmId) async {
    try {
      final storage = await ref.read(favoriteMovieStorageProvider.future);
      final currentMovie = await storage.getByFilmId(filmId);
      await storage.setFavorite(
        filmId,
        isFavorite: !(currentMovie?.isFavorite ?? false),
      );
      state = AsyncData(await storage.getAll());
    } on Object catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> setRating(String filmId, int? rating) async {
    try {
      final storage = await ref.read(favoriteMovieStorageProvider.future);
      await storage.setRating(filmId, rating);
      state = AsyncData(await storage.getAll());
    } on Object catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}

class RatingFilter extends Notifier<int?> {
  @override
  int? build() {
    return null;
  }

  void setRating(int? rating) {
    if (rating != null &&
        (rating < FilmRatingBounds.min || rating > FilmRatingBounds.max)) {
      throw ArgumentError.value(
        rating,
        'rating',
        'Rating filter must be between 1 and 5 or null.',
      );
    }

    state = rating;
  }

  void clear() {
    state = null;
  }
}
