import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghibli_gallery/app/theme.dart';
import 'package:ghibli_gallery/features/films/domain/film_details.dart';
import 'package:ghibli_gallery/features/films/presentation/providers/favorite_movie_providers.dart';
import 'package:ghibli_gallery/features/films/presentation/providers/film_providers.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/ghibli_cached_image.dart';

const _rottenTomatoesAsset = 'assets/images/Rotten_Tomatoes.svg';
const _metadataRowMinHeight = 52.0;

class FilmDetailScreen extends ConsumerWidget {
  const FilmDetailScreen({required this.filmId, super.key});

  final String filmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(filmDetailsProvider(filmId));

    return Scaffold(
      appBar: detailState.hasValue
          ? null
          : AppBar(title: const Text('Film detail')),
      body: _FilmDetailBody(
        filmId: filmId,
        detailState: detailState,
      ),
    );
  }
}

class _FilmDetailBody extends ConsumerWidget {
  const _FilmDetailBody({
    required this.filmId,
    required this.detailState,
  });

  final String filmId;
  final AsyncValue<FilmDetails> detailState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (detailState.hasError) {
      return _DetailErrorState(
        onBack: () {
          unawaited(Navigator.of(context).maybePop());
        },
        onRetry: () {
          ref.invalidate(filmDetailsProvider(filmId));
        },
      );
    }

    final details = detailState.value;
    if (details == null) {
      return const _DetailLoadingState();
    }

    return _DetailContent(details: details);
  }
}

class _DetailLoadingState extends StatelessWidget {
  const _DetailLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading film details...'),
        ],
      ),
    );
  }
}

class _DetailErrorState extends StatelessWidget {
  const _DetailErrorState({
    required this.onBack,
    required this.onRetry,
  });

  final VoidCallback onBack;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'We could not load this film right now.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: onBack,
                  child: const Text('Back'),
                ),
                FilledButton(
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.details});

  final FilmDetails details;

  @override
  Widget build(BuildContext context) {
    final film = details.film;

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        _DetailHeroHeader(details: details),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OptionalText(value: details.originalTitle),
              _OptionalText(value: details.originalTitleRomanised),
              const SizedBox(height: 16),
              _FilmUserRating(filmId: film.id),
              const _DetailSectionDivider(),
              _DescriptionSection(description: film.description),
              const _DetailSectionDivider(),
              _DetailMetadata(
                rows: [
                  _MetadataRow(label: 'Director', value: film.director),
                  _MetadataRow(label: 'Producer', value: film.producer),
                  _MetadataRow(
                    label: 'Release date',
                    value: _formatNullableInt(film.releaseYear),
                  ),
                  _MetadataRow(
                    label: 'Running time',
                    value: _formatRunningTime(film.runningTimeMinutes),
                  ),
                  _MetadataRow(
                    label: 'Rotten Tomatoes',
                    iconAsset: _rottenTomatoesAsset,
                    value: _formatScore(film.rtScore),
                  ),
                ],
              ),
              const _DetailSectionDivider(),
              _RelatedResources(details: details),
            ],
          ),
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Story',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.52,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.86),
          ),
        ),
      ],
    );
  }
}

class _DetailSectionDivider extends StatelessWidget {
  const _DetailSectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Divider(
        height: 1,
        color: Theme.of(context).colorScheme.outlineVariant.withValues(
          alpha: 0.72,
        ),
      ),
    );
  }
}

class _DetailHeroHeader extends StatelessWidget {
  const _DetailHeroHeader({required this.details});

  final FilmDetails details;

  @override
  Widget build(BuildContext context) {
    final film = details.film;
    final theme = Theme.of(context);
    final background = theme.scaffoldBackgroundColor;
    final heroHeight = (MediaQuery.sizeOf(context).height * 0.56).clamp(
      360.0,
      520.0,
    );
    final heroImageUrl = film.movieBanner.trim().isNotEmpty
        ? film.movieBanner
        : film.image;

    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GhibliCachedImage(
            imageUrl: heroImageUrl,
            iconSize: 52,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.56),
                  Colors.black.withValues(alpha: 0.08),
                  Colors.black.withValues(alpha: 0.52),
                  background,
                ],
                stops: const [0, 0.42, 0.72, 1],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _HeroCircleButton(
                      tooltip: 'Back',
                      icon: Icons.arrow_back,
                      onPressed: () {
                        unawaited(Navigator.of(context).maybePop());
                      },
                    ),
                    _HeroFavoriteButton(filmId: film.id),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  film.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.04,
                    shadows: const [
                      Shadow(
                        blurRadius: 16,
                        color: Colors.black87,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _HeroMetadata(
                  releaseYear: film.releaseYear,
                  runningTimeMinutes: film.runningTimeMinutes,
                  rtScore: film.rtScore,
                  director: film.director,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMetadata extends StatelessWidget {
  const _HeroMetadata({
    required this.releaseYear,
    required this.runningTimeMinutes,
    required this.rtScore,
    required this.director,
  });

  final int? releaseYear;
  final int? runningTimeMinutes;
  final int? rtScore;
  final String director;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Colors.white.withValues(alpha: 0.88),
      fontWeight: FontWeight.w600,
      height: 1.2,
      shadows: const [
        Shadow(
          blurRadius: 12,
          color: Colors.black87,
          offset: Offset(0, 1),
        ),
      ],
    );
    final items = <Widget>[
      if (releaseYear != null) Text(releaseYear.toString(), style: style),
      if (runningTimeMinutes != null)
        Text('$runningTimeMinutes min', style: style),
      if (rtScore != null)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              _rottenTomatoesAsset,
              height: 18,
              width: 18,
              semanticsLabel: 'Rotten Tomatoes score',
            ),
            const SizedBox(width: 5),
            Text('$rtScore%', style: style),
          ],
        )
      else if (director.trim().isNotEmpty)
        Text(
          director,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
    ];

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var index = 0; index < items.length; index += 1) ...[
          if (index > 0)
            Text(
              '•',
              style: style,
            ),
          items[index],
        ],
      ],
    );
  }
}

class _HeroFavoriteButton extends ConsumerWidget {
  const _HeroFavoriteButton({required this.filmId});

  final String filmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataState = ref.watch(favoriteMovieByFilmIdProvider(filmId));
    final userData = userDataState.value;
    final isFavorite = userData?.isFavorite ?? false;
    final isBusy = userDataState.isLoading;

    return _HeroCircleButton(
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
      icon: isFavorite ? Icons.favorite : Icons.favorite_outline,
      onPressed: isBusy
          ? null
          : () async {
              await _runUserDataAction(
                context,
                () => ref
                    .read(favoriteMovieControllerProvider.notifier)
                    .toggleFavorite(filmId),
              );
            },
    );
  }
}

class _HeroCircleButton extends StatelessWidget {
  const _HeroCircleButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.46),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        color: Colors.white,
        disabledColor: Colors.white.withValues(alpha: 0.48),
        icon: Icon(icon),
      ),
    );
  }
}

class _FilmUserRating extends ConsumerWidget {
  const _FilmUserRating({required this.filmId});

  final String filmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataState = ref.watch(favoriteMovieByFilmIdProvider(filmId));
    final userData = userDataState.value;
    final rating = userData?.rating;
    final isBusy = userDataState.isLoading;
    final hasError = userDataState.hasError;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.72),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: ghibliStarGold,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your rating',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              rating == null
                  ? 'Tap a star to rate this film.'
                  : 'You rated this film $rating out of 5.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            _RatingStars(
              rating: rating,
              isEnabled: !isBusy,
              onChanged: (rating) async {
                await _runUserDataAction(
                  context,
                  () => ref
                      .read(favoriteMovieControllerProvider.notifier)
                      .setRating(filmId, rating),
                );
              },
            ),
            if (hasError) ...[
              const SizedBox(height: 8),
              Text(
                'Could not save your favorite or rating.',
                style: TextStyle(color: colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  const _RatingStars({
    required this.rating,
    required this.isEnabled,
    required this.onChanged,
  });

  final int? rating;
  final bool isEnabled;
  final Future<void> Function(int? rating) onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var value = 1; value <= 5; value += 1)
          IconButton(
            tooltip: 'Rate $value star${value == 1 ? '' : 's'}',
            onPressed: isEnabled ? () => onChanged(value) : null,
            constraints: const BoxConstraints.tightFor(
              width: 48,
              height: 48,
            ),
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.7,
              ),
              foregroundColor: colorScheme.onSurfaceVariant,
              disabledForegroundColor: colorScheme.onSurfaceVariant.withValues(
                alpha: 0.48,
              ),
            ),
            icon: AnimatedSwitcher(
              duration: _detailActionAnimationDuration,
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: Icon(
                value <= (rating ?? 0) ? Icons.star : Icons.star_border,
                key: ValueKey('rating-$value-${value <= (rating ?? 0)}'),
                size: 31,
                color: value <= (rating ?? 0)
                    ? ghibliStarGold
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        if (rating != null)
          TextButton(
            onPressed: isEnabled ? () => onChanged(null) : null,
            child: const Text('Clear rating'),
          ),
      ],
    );
  }
}

const _detailActionAnimationDuration = Duration(milliseconds: 140);

Future<void> _runUserDataAction(
  BuildContext context,
  Future<void> Function() action,
) async {
  try {
    await action();
  } on Object {
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not save your favorite or rating.'),
      ),
    );
  }
}

class _RelatedResources extends StatelessWidget {
  const _RelatedResources({required this.details});

  final FilmDetails details;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        _RelatedSection(
          title: 'People',
          values: details.people,
        ),
        const SizedBox(height: 12),
        _RelatedSection(
          title: 'Species',
          values: details.species,
        ),
        const SizedBox(height: 12),
        _RelatedSection(
          title: 'Locations',
          values: details.locations,
        ),
        const SizedBox(height: 12),
        _RelatedSection(
          title: 'Vehicles',
          values: details.vehicles,
        ),
      ],
    );
  }
}

class _RelatedSection extends StatelessWidget {
  const _RelatedSection({
    required this.title,
    required this.values,
  });

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final displayValues = values
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty && !_looksLikeUrl(value))
        .toList(growable: false);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.72),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  displayValues.length.toString(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: colorScheme.outlineVariant.withValues(alpha: 0.64),
          ),
          if (displayValues.isEmpty)
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'No data available',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final value in displayValues) _RelatedChip(label: value),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _RelatedChip extends StatelessWidget {
  const _RelatedChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.72),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.7),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Text(label),
      ),
    );
  }
}

class _OptionalText extends StatelessWidget {
  const _OptionalText({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _DetailMetadata extends StatelessWidget {
  const _DetailMetadata({required this.rows});

  final List<_MetadataRow> rows;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Film details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.72),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (var index = 0; index < rows.length; index += 1)
                _MetadataTile(
                  row: rows[index],
                  showDivider: index < rows.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetadataTile extends StatelessWidget {
  const _MetadataTile({
    required this.row,
    required this.showDivider,
  });

  final _MetadataRow row;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.64),
                ),
              )
            : null,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _metadataRowMinHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: _MetadataLabel(row: row),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    row.value,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetadataRow {
  const _MetadataRow({
    required this.label,
    required this.value,
    this.iconAsset,
  });

  final String label;
  final String value;
  final String? iconAsset;
}

class _MetadataLabel extends StatelessWidget {
  const _MetadataLabel({required this.row});

  final _MetadataRow row;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
      height: 1.25,
    );

    final iconAsset = row.iconAsset;
    if (iconAsset == null) {
      return Text(
        row.label,
        style: textStyle,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            row.label,
            style: textStyle,
          ),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(
          iconAsset,
          height: 18,
          width: 18,
          semanticsLabel: row.label,
        ),
      ],
    );
  }
}

String _formatNullableInt(int? value) {
  return value?.toString() ?? 'Unknown';
}

String _formatRunningTime(int? minutes) {
  if (minutes == null) {
    return 'Unknown';
  }

  return '$minutes minutes';
}

String _formatScore(int? score) {
  if (score == null) {
    return 'Unknown';
  }

  return '$score%';
}

bool _looksLikeUrl(String value) {
  final uri = Uri.tryParse(value);
  return uri != null && uri.hasScheme && uri.host.isNotEmpty;
}
