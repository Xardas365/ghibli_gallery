import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_gallery/app/ghibli_scaffold.dart';
import 'package:ghibli_gallery/app/router.dart';
import 'package:ghibli_gallery/features/films/domain/favorite_movie.dart';
import 'package:ghibli_gallery/features/films/domain/film.dart';
import 'package:ghibli_gallery/features/films/presentation/providers/favorite_movie_providers.dart';
import 'package:ghibli_gallery/features/films/presentation/providers/film_providers.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/film_card.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/film_card_entrance.dart';

class FavoriteFilmsScreen extends ConsumerWidget {
  const FavoriteFilmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filmsState = ref.watch(filmsProvider);
    final favoritesState = ref.watch(filteredFavoriteMoviesProvider);
    final allFavoritesState = ref.watch(favoriteMoviesProvider);
    final selectedRating = ref.watch(ratingFilterProvider);

    return GhibliScaffold(
      selectedSection: GhibliMainSection.favorites,
      title: 'Favorites',
      body: Column(
        children: [
          _RatingFilterBar(selectedRating: selectedRating),
          Expanded(
            child: _FavoriteFilmsBody(
              filmsState: filmsState,
              favoritesState: favoritesState,
              allFavoritesState: allFavoritesState,
              selectedRating: selectedRating,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingFilterBar extends ConsumerWidget {
  const _RatingFilterBar({required this.selectedRating});

  final int? selectedRating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Rating filter',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            ChoiceChip(
              label: const Text('All'),
              selected: selectedRating == null,
              onSelected: (_) {
                ref.read(ratingFilterProvider.notifier).clear();
              },
            ),
            for (var rating = 5; rating >= 1; rating -= 1)
              ChoiceChip(
                label: Text('$rating'),
                selected: selectedRating == rating,
                avatar: const Icon(Icons.star, size: 16),
                onSelected: (_) {
                  ref.read(ratingFilterProvider.notifier).setRating(rating);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteFilmsBody extends StatelessWidget {
  const _FavoriteFilmsBody({
    required this.filmsState,
    required this.favoritesState,
    required this.allFavoritesState,
    required this.selectedRating,
  });

  final AsyncValue<List<Film>> filmsState;
  final AsyncValue<List<FavoriteMovie>> favoritesState;
  final AsyncValue<List<FavoriteMovie>> allFavoritesState;
  final int? selectedRating;

  @override
  Widget build(BuildContext context) {
    if (filmsState.hasError ||
        favoritesState.hasError ||
        allFavoritesState.hasError) {
      return const _FavoritesErrorState();
    }

    final films = filmsState.value;
    final favorites = favoritesState.value;
    final allFavorites = allFavoritesState.value;
    if (films == null || favorites == null || allFavorites == null) {
      return const _FavoritesLoadingState();
    }

    if (allFavorites.isEmpty) {
      return const _FavoritesEmptyState();
    }

    final favoriteFilms = _favoriteFilms(films, favorites);
    if (favoriteFilms.isEmpty) {
      return _FavoritesEmptyState(selectedRating: selectedRating);
    }

    return _FavoriteFilmGrid(favoriteFilms: favoriteFilms);
  }
}

class _FavoritesLoadingState extends StatelessWidget {
  const _FavoritesLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading favorite films...'),
        ],
      ),
    );
  }
}

class _FavoritesErrorState extends StatelessWidget {
  const _FavoritesErrorState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Your favorite films could not be loaded right now.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _FavoritesEmptyState extends StatelessWidget {
  const _FavoritesEmptyState({this.selectedRating});

  final int? selectedRating;

  @override
  Widget build(BuildContext context) {
    final message = selectedRating == null
        ? 'No favorite films yet. Mark films as favorites from their detail pages.'
        : 'No favorites match this rating yet.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}

class _FavoriteFilmGrid extends StatelessWidget {
  const _FavoriteFilmGrid({required this.favoriteFilms});

  final List<_FavoriteFilm> favoriteFilms;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = switch (constraints.maxWidth) {
          >= 900 => 5,
          >= 680 => 4,
          >= 460 => 3,
          _ => 2,
        };

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 18,
            crossAxisSpacing: 16,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final favoriteFilm = favoriteFilms[index];
            return FilmCardEntrance(
              index: index,
              child: FilmCard(
                film: favoriteFilm.film,
                userData: favoriteFilm.userData,
                onTap: () {
                  unawaited(
                    Navigator.of(context).pushNamed(
                      AppRoutes.filmDetailPath(favoriteFilm.film.id),
                    ),
                  );
                },
              ),
            );
          },
          itemCount: favoriteFilms.length,
        );
      },
    );
  }
}

class _FavoriteFilm {
  const _FavoriteFilm({
    required this.film,
    required this.userData,
  });

  final Film film;
  final FavoriteMovie userData;
}

List<_FavoriteFilm> _favoriteFilms(
  List<Film> films,
  List<FavoriteMovie> favorites,
) {
  final filmsById = {
    for (final film in films) film.id: film,
  };

  return [
    for (final favorite in favorites)
      if (filmsById[favorite.filmId] case final Film film)
        _FavoriteFilm(film: film, userData: favorite),
  ];
}
