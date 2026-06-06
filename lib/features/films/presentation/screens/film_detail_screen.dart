import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_entry/features/films/domain/film_details.dart';
import 'package:ghibli_entry/features/films/presentation/providers/film_providers.dart';

class FilmDetailScreen extends ConsumerWidget {
  const FilmDetailScreen({required this.filmId, super.key});

  final String filmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(filmDetailsProvider(filmId));

    return Scaffold(
      appBar: AppBar(title: const Text('Film detail')),
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
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        _DetailHeroImage(
          bannerUrl: film.movieBanner,
          imageUrl: film.image,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                film.title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _OptionalText(value: details.originalTitle),
              _OptionalText(value: details.originalTitleRomanised),
              const SizedBox(height: 16),
              Text(film.description),
              const SizedBox(height: 24),
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
                    value: _formatScore(film.rtScore),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _RelatedSection(
                title: 'People',
                values: details.people,
              ),
              _RelatedSection(
                title: 'Species',
                values: details.species,
              ),
              _RelatedSection(
                title: 'Locations',
                values: details.locations,
              ),
              _RelatedSection(
                title: 'Vehicles',
                values: details.vehicles,
              ),
            ],
          ),
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
    final displayValues = values
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty && !_looksLikeUrl(value))
        .toList(growable: false);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          if (displayValues.isEmpty)
            Text(
              'No data available',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final value in displayValues)
                  Chip(
                    label: Text(value),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _DetailHeroImage extends StatelessWidget {
  const _DetailHeroImage({
    required this.bannerUrl,
    required this.imageUrl,
  });

  final String bannerUrl;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = bannerUrl.isNotEmpty ? bannerUrl : imageUrl;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: url.isEmpty
          ? const _MissingImage()
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const _MissingImage();
              },
            ),
    );
  }
}

class _MissingImage extends StatelessWidget {
  const _MissingImage();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(
        child: Icon(Icons.movie_creation_outlined, size: 48),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        for (final row in rows) _MetadataTile(row: row),
      ],
    );
  }
}

class _MetadataTile extends StatelessWidget {
  const _MetadataTile({required this.row});

  final _MetadataRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 132,
            child: Text(
              row.label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(row.value)),
        ],
      ),
    );
  }
}

class _MetadataRow {
  const _MetadataRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
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
