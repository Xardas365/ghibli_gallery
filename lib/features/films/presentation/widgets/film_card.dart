import 'package:flutter/material.dart';
import 'package:ghibli_gallery/app/theme.dart';
import 'package:ghibli_gallery/features/films/domain/favorite_movie.dart';
import 'package:ghibli_gallery/features/films/domain/film.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/ghibli_cached_image.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({
    required this.film,
    required this.onTap,
    this.userData,
    this.onFavoriteToggle,
    super.key,
  });

  final Film film;
  final FavoriteMovie? userData;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GhibliCachedImage(imageUrl: film.image),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.16),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.34),
                        ],
                        stops: const [0, 0.48, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _FavoriteButton(
                      isFavorite: userData?.isFavorite ?? false,
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                  if (userData?.rating case final int rating)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: _RatingIndicator(rating: rating),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 86,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        film.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.12,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _metadataLabel(film),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _metadataLabel(Film film) {
  final year = film.releaseYear;
  if (year == null) {
    return film.director;
  }

  return '$year • ${film.director}';
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({
    required this.isFavorite,
    required this.onPressed,
  });

  final bool isFavorite;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tooltip = isFavorite ? 'Remove from favorites' : 'Add to favorites';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.62),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.7),
        ),
        shape: BoxShape.circle,
      ),
      child: Semantics(
        button: true,
        label: tooltip,
        child: IconButton(
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints.tightFor(
            width: 32,
            height: 32,
          ),
          tooltip: tooltip,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: colorScheme.primary,
            size: 18,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _RatingIndicator extends StatelessWidget {
  const _RatingIndicator({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.72),
        border: Border.all(
          color: ghibliStarGold.withValues(alpha: 0.42),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: ghibliStarGold, size: 14),
            const SizedBox(width: 4),
            Text(
              '$rating',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
