import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghibli_gallery/app/theme.dart';
import 'package:ghibli_gallery/features/films/domain/favorite_movie.dart';
import 'package:ghibli_gallery/features/films/domain/film.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/ghibli_cached_image.dart';

const _tomatoScoreAsset = 'assets/images/tomato_score.svg';
const Alignment _defaultPosterAlignment = Alignment.topCenter;

const Map<String, Alignment> _posterAlignmentByFilmId = {};

const Map<String, Alignment> _posterAlignmentByFilmTitle = {
  'Ponyo': Alignment(-0.15, -0.75),
};

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
    const imageToTextFadeHeight = 64.0;
    final posterAlignment = _posterAlignmentForFilm(film);
    const blurSigma = 10.0;
    const blurredPosterOpacity = 0.7;

    return Card(
      elevation: 12,
      shadowColor: Colors.black.withValues(alpha: 0.24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.32),
        ),
      ),
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
                  GhibliCachedImage(
                    imageUrl: film.image,
                    alignment: posterAlignment,
                    placeholderSet: GhibliPlaceholderSet.gallery,
                    placeholderKey: film.id,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.28),
                    ),
                  ),
                  Opacity(
                    opacity: blurredPosterOpacity,
                    child: ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (bounds) {
                        return const RadialGradient(
                          radius: 1.08,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.white,
                          ],
                          stops: [0, 0.68, 1],
                        ).createShader(bounds);
                      },
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: blurSigma,
                          sigmaY: blurSigma,
                        ),
                        child: GhibliCachedImage(
                          imageUrl: film.image,
                          alignment: posterAlignment,
                          showFallbackKey: false,
                          placeholderSet: GhibliPlaceholderSet.gallery,
                          placeholderKey: film.id,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: SizedBox(
                        height: imageToTextFadeHeight,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                colorScheme.surfaceContainer,
                              ],
                              stops: const [0.32, 1],
                            ),
                          ),
                        ),
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
                      child: _RatingIndicator(
                        key: const ValueKey('film-card-user-rating'),
                        rating: rating,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 104,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
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
                      const SizedBox(height: 6),
                      if (film.rtScore case final int rtScore) ...[
                        _RottenTomatoesRatingRow(rtScore: rtScore),
                        const SizedBox(height: 6),
                      ] else
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

class _RottenTomatoesRatingRow extends StatelessWidget {
  const _RottenTomatoesRatingRow({required this.rtScore});

  final int rtScore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final starRating = _rtScoreToStarRating(rtScore);

    return Semantics(
      label: 'Rotten Tomatoes $rtScore%, $starRating out of 5 stars',
      child: Row(
        key: const ValueKey('film-card-rt-row'),
        children: [
          SvgPicture.asset(
            _tomatoScoreAsset,
            key: const ValueKey('film-card-rt-icon'),
            height: 14,
            width: 14,
            semanticsLabel: 'Rotten Tomatoes score',
          ),
          const SizedBox(width: 5),
          _RottenTomatoesStars(rating: starRating),
          const SizedBox(width: 5),
          Text(
            '$rtScore%',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _RottenTomatoesStars extends StatelessWidget {
  const _RottenTomatoesStars({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 1; index <= 5; index += 1)
            Icon(
              _starIcon(index, rating),
              size: 11,
              color: ghibliStarGold,
            ),
        ],
      ),
    );
  }
}

IconData _starIcon(int position, double rating) {
  if (rating >= position) {
    return Icons.star;
  }

  if (rating >= position - 0.5) {
    return Icons.star_half;
  }

  return Icons.star_border;
}

double _rtScoreToStarRating(int rtScore) {
  final normalizedScore = rtScore.clamp(0, 100);
  return (normalizedScore / 10).round() / 2;
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
    const blurSigma = 8.0;
    const unselectedFillOpacity = 0.22;
    const selectedFillOpacity = 0.34;
    final iconColor = isFavorite
        ? colorScheme.primary
        : colorScheme.onSurface.withValues(alpha: 0.86);
    final backgroundColor = isFavorite
        ? Colors.black.withValues(alpha: selectedFillOpacity)
        : Colors.black.withValues(alpha: unselectedFillOpacity);

    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
        ),
        child: Material(
          color: backgroundColor,
          shape: const CircleBorder(),
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
                color: iconColor,
                size: 18,
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}

class _RatingIndicator extends StatelessWidget {
  const _RatingIndicator({required this.rating, super.key});

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

Alignment _posterAlignmentForFilm(Film film) {
  return _posterAlignmentByFilmId[film.id] ??
      _posterAlignmentByFilmTitle[film.title] ??
      _defaultPosterAlignment;
}
