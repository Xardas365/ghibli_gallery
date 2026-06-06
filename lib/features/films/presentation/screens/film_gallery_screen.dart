import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_entry/app/router.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/presentation/providers/favorite_movie_providers.dart';
import 'package:ghibli_entry/features/films/presentation/providers/film_providers.dart';
import 'package:ghibli_entry/features/films/presentation/widgets/film_card.dart';

class FilmGalleryScreen extends ConsumerWidget {
  const FilmGalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filmsState = ref.watch(filmsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghibli Gallery'),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            onPressed: () {
              unawaited(Navigator.of(context).pushNamed(AppRoutes.favorites));
            },
            icon: const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: _GalleryBody(filmsState: filmsState),
    );
  }
}

class _GalleryBody extends ConsumerWidget {
  const _GalleryBody({required this.filmsState});

  final AsyncValue<List<Film>> filmsState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (filmsState.hasError) {
      return _GalleryErrorState(
        onRetry: () {
          ref.invalidate(filmsProvider);
        },
      );
    }

    final films = filmsState.value;
    if (films == null) {
      return const _GalleryLoadingState();
    }

    if (films.isEmpty) {
      return const _GalleryEmptyState();
    }

    return _GalleryFilmList(films: films);
  }
}

class _GalleryLoadingState extends StatelessWidget {
  const _GalleryLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading the Ghibli collection...'),
        ],
      ),
    );
  }
}

class _GalleryErrorState extends StatelessWidget {
  const _GalleryErrorState({required this.onRetry});

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
              'The film gallery could not be loaded right now.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryEmptyState extends StatelessWidget {
  const _GalleryEmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'No films are available right now. Please try again later.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _GalleryFilmList extends StatelessWidget {
  const _GalleryFilmList({required this.films});

  final List<Film> films;

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
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 18,
            crossAxisSpacing: 16,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            return _GalleryFilmCard(film: films[index]);
          },
          itemCount: films.length,
        );
      },
    );
  }
}

class _GalleryFilmCard extends ConsumerWidget {
  const _GalleryFilmCard({required this.film});

  final Film film;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataState = ref.watch(favoriteMovieByFilmIdProvider(film.id));

    return FilmCard(
      film: film,
      userData: userDataState.value,
      onTap: () {
        unawaited(
          Navigator.of(context).pushNamed(
            AppRoutes.filmDetailPath(film.id),
          ),
        );
      },
    );
  }
}
