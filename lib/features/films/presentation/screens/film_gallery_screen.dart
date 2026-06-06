import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_entry/app/router.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/presentation/providers/film_providers.dart';

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
          Text('Loading films...'),
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
              'We could not load the film gallery.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Retry'),
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
          'No films are available right now.',
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
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final film = films[index];

        return ListTile(
          title: Text(film.title),
          subtitle: Text(film.director),
          onTap: () {
            unawaited(
              Navigator.of(context).pushNamed(
                AppRoutes.filmDetailPath(film.id),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: films.length,
    );
  }
}
