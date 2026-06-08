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
import 'package:ghibli_gallery/features/films/presentation/widgets/ghibli_loading_state.dart';

const _fallbackConfusedNonAsset = 'assets/images/fallback.gif';
const _gridPadding = EdgeInsets.fromLTRB(16, 12, 16, 28);
const _gridMainAxisSpacing = 18.0;
const _gridCrossAxisSpacing = 16.0;
const _gridChildAspectRatio = 0.64;

class FavoriteFilmsScreen extends ConsumerWidget {
  const FavoriteFilmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filmsState = ref.watch(filmsProvider);
    final favoritesState = ref.watch(filteredFavoriteMoviesProvider);
    final allFavoritesState = ref.watch(favoriteMoviesProvider);
    final selectedRating = ref.watch(ratingFilterProvider);
    final films = filmsState.value;
    final favorites = favoritesState.value;
    final allFavorites = allFavoritesState.value;
    final shownFavoritesCount = films != null && favorites != null
        ? _favoriteFilms(films, favorites).length
        : null;
    final totalFavoritesCount = films != null && allFavorites != null
        ? _favoriteFilms(films, allFavorites).length
        : null;
    final ratingCounts = films != null && allFavorites != null
        ? _ratingCounts(films, allFavorites)
        : null;

    return GhibliScaffold(
      selectedSection: GhibliMainSection.favorites,
      title: 'Favorites',
      body: _FavoritesBackground(
        child: Column(
          children: [
            _RatingFilterBar(
              selectedRating: selectedRating,
              shownFavoritesCount: shownFavoritesCount,
              totalFavoritesCount: totalFavoritesCount,
              ratingCounts: ratingCounts,
            ),
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
      ),
    );
  }
}

class _FavoritesBackground extends StatelessWidget {
  const _FavoritesBackground({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.surfaceContainerLow,
            colorScheme.surfaceContainerLowest,
          ],
        ),
      ),
      child: child,
    );
  }
}

class _RatingFilterBar extends ConsumerWidget {
  const _RatingFilterBar({
    required this.selectedRating,
    required this.shownFavoritesCount,
    required this.totalFavoritesCount,
    required this.ratingCounts,
  });

  final int? selectedRating;
  final int? shownFavoritesCount;
  final int? totalFavoritesCount;
  final Map<int, int>? ratingCounts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final countLabel = _countLabel();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.72),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Rating filter',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  for (var rating = 5; rating >= 1; rating -= 1) ...[
                    Expanded(
                      child: _RatingFilterChip(
                        rating: rating,
                        count: ratingCounts?[rating],
                        selected: selectedRating == rating,
                        onSelected: (isSelected) {
                          final notifier = ref.read(
                            ratingFilterProvider.notifier,
                          );
                          if (isSelected) {
                            notifier.setRating(rating);
                          } else {
                            notifier.clear();
                          }
                        },
                      ),
                    ),
                    if (rating > 1) const SizedBox(width: 6),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                countLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _countLabel() {
    final shown = shownFavoritesCount;
    final total = totalFavoritesCount;
    if (shown == null || total == null) {
      return 'Loading favorite count...';
    }

    if (selectedRating == null) {
      return 'Showing all ${_favoriteCountLabel(total)}.';
    }

    final starLabel = selectedRating == 1 ? 'star' : 'stars';
    return 'Showing $shown of ${_favoriteCountLabel(total)} rated '
        '$selectedRating $starLabel.';
  }
}

class _RatingFilterChip extends StatelessWidget {
  const _RatingFilterChip({
    required this.rating,
    required this.count,
    required this.selected,
    required this.onSelected,
  });

  final int rating;
  final int? count;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isEmpty = count == 0;
    final foregroundColor = selected
        ? colorScheme.onPrimaryContainer
        : isEmpty
        ? colorScheme.onSurfaceVariant.withValues(alpha: 0.62)
        : colorScheme.onSurface;
    final backgroundColor = selected
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerLow;
    final borderColor = selected
        ? colorScheme.primary.withValues(alpha: 0.7)
        : colorScheme.outlineVariant.withValues(alpha: 0.72);

    return Opacity(
      opacity: isEmpty && !selected ? 0.72 : 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: ValueKey('rating-filter-$rating'),
          onTap: () => onSelected(!selected),
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            height: 52,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$rating',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: foregroundColor,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: foregroundColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${count ?? '-'}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _favoriteCountLabel(int count) {
  final noun = count == 1 ? 'favorite' : 'favorites';
  return '$count $noun';
}

class _FavoritesStatePanel extends StatelessWidget {
  const _FavoritesStatePanel({
    required this.child,
    this.icon,
  });

  final IconData? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.72),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: colorScheme.primary,
                      size: 30,
                    ),
                    const SizedBox(height: 14),
                  ],
                  child,
                ],
              ),
            ),
          ),
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
    return const GhibliLoadingState(
      primaryText: 'Loading favorite films...',
    );
  }
}

class _FavoritesErrorState extends StatelessWidget {
  const _FavoritesErrorState();

  @override
  Widget build(BuildContext context) {
    return const _FavoritesStatePanel(
      icon: Icons.error_outline,
      child: Text(
        'Your favorite films could not be loaded right now.',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _FavoritesEmptyState extends StatelessWidget {
  const _FavoritesEmptyState({this.selectedRating});

  final int? selectedRating;

  @override
  Widget build(BuildContext context) {
    final rating = selectedRating;
    final message = rating == null
        ? 'No favorite films yet. Mark films as favorites from their detail pages.'
        : 'The forest spirits checked every path, but no favorite lives in '
              'your $rating-star grove yet.';
    final isFilteredEmpty = selectedRating != null;

    return _FavoritesStatePanel(
      icon: selectedRating == null ? Icons.favorite_border : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isFilteredEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                _fallbackConfusedNonAsset,
                height: 112,
                fit: BoxFit.contain,
                semanticLabel: 'No favorites match this rating',
              ),
            ),
            const SizedBox(height: 14),
          ],
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _FavoriteFilmGrid extends ConsumerWidget {
  const _FavoriteFilmGrid({required this.favoriteFilms});

  final List<_FavoriteFilm> favoriteFilms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = switch (constraints.maxWidth) {
          >= 900 => 5,
          >= 680 => 4,
          >= 460 => 3,
          _ => 2,
        };

        return GridView.builder(
          padding: _gridPadding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: _gridMainAxisSpacing,
            crossAxisSpacing: _gridCrossAxisSpacing,
            childAspectRatio: _gridChildAspectRatio,
          ),
          itemBuilder: (context, index) {
            final favoriteFilm = favoriteFilms[index];
            return FilmCardEntrance(
              index: index,
              child: FilmCard(
                film: favoriteFilm.film,
                userData: favoriteFilm.userData,
                onFavoriteToggle: () {
                  unawaited(
                    ref
                        .read(favoriteMovieControllerProvider.notifier)
                        .toggleFavorite(favoriteFilm.film.id),
                  );
                },
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

Map<int, int> _ratingCounts(
  List<Film> films,
  List<FavoriteMovie> favorites,
) {
  final counts = {
    for (var rating = 1; rating <= 5; rating += 1) rating: 0,
  };

  for (final favoriteFilm in _favoriteFilms(films, favorites)) {
    final rating = favoriteFilm.userData.rating;
    if (rating != null && counts.containsKey(rating)) {
      counts[rating] = counts[rating]! + 1;
    }
  }

  return counts;
}
