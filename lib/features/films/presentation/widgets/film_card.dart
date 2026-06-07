import 'package:flutter/material.dart';
import 'package:ghibli_entry/app/theme.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/presentation/widgets/ghibli_cached_image.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({
    required this.film,
    required this.onTap,
    this.userData,
    super.key,
  });

  final Film film;
  final FavoriteMovie? userData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
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
                  if (userData?.isFavorite ?? false)
                    const Positioned(
                      top: 8,
                      right: 8,
                      child: _FavoriteIndicator(),
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
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _metadataLabel(film),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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

class _FavoriteIndicator extends StatelessWidget {
  const _FavoriteIndicator();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          Icons.favorite,
          color: colorScheme.onPrimaryContainer,
          size: 16,
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
