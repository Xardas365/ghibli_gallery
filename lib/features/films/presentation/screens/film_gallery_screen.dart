import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_gallery/app/ghibli_scaffold.dart';
import 'package:ghibli_gallery/app/router.dart';
import 'package:ghibli_gallery/features/films/domain/film.dart';
import 'package:ghibli_gallery/features/films/presentation/providers/favorite_movie_providers.dart';
import 'package:ghibli_gallery/features/films/presentation/providers/film_providers.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/film_card.dart';
import 'package:ghibli_gallery/features/films/presentation/widgets/film_card_entrance.dart';

class FilmGalleryScreen extends ConsumerStatefulWidget {
  const FilmGalleryScreen({super.key});

  @override
  ConsumerState<FilmGalleryScreen> createState() => _FilmGalleryScreenState();
}

const _gridPadding = EdgeInsets.fromLTRB(16, 20, 16, 28);
const _gridMainAxisSpacing = 18.0;
const _gridCrossAxisSpacing = 16.0;
const _gridChildAspectRatio = 0.64;

class _FilmGalleryScreenState extends ConsumerState<FilmGalleryScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  var _isSearchVisible = false;
  var _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchController = TextEditingController()
      ..addListener(() {
        setState(() {
          _searchQuery = _searchController.text;
        });
      });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filmsState = ref.watch(filmsProvider);

    return GhibliScaffold(
      selectedSection: GhibliMainSection.gallery,
      title: 'Ghibli Gallery',
      titleWidget: Image.asset(
        'assets/images/gallery_title.png',
        height: 40,
        fit: BoxFit.contain,
        semanticLabel: 'Ghibli Gallery',
      ),
      actions: [
        IconButton(
          tooltip: 'Search films',
          onPressed: _showSearch,
          icon: const Icon(Icons.search),
        ),
      ],
      body: _GalleryBackground(
        child: _GalleryBody(
          filmsState: filmsState,
          isSearchVisible: _isSearchVisible,
          searchQuery: _searchQuery,
          searchController: _searchController,
          searchFocusNode: _searchFocusNode,
          onCloseSearch: _hideSearch,
        ),
      ),
    );
  }

  void _showSearch() {
    setState(() {
      _isSearchVisible = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  void _hideSearch() {
    _searchController.clear();
    _searchFocusNode.unfocus();
    setState(() {
      _isSearchVisible = false;
    });
  }
}

class _GalleryBackground extends StatelessWidget {
  const _GalleryBackground({required this.child});

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

class _GalleryBody extends ConsumerWidget {
  const _GalleryBody({
    required this.filmsState,
    required this.isSearchVisible,
    required this.searchQuery,
    required this.searchController,
    required this.searchFocusNode,
    required this.onCloseSearch,
  });

  final AsyncValue<List<Film>> filmsState;
  final bool isSearchVisible;
  final String searchQuery;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final VoidCallback onCloseSearch;

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

    final filteredFilms = _filterFilms(films, searchQuery);

    return Column(
      children: [
        if (isSearchVisible)
          _GallerySearchField(
            controller: searchController,
            focusNode: searchFocusNode,
            onClose: onCloseSearch,
          ),
        Expanded(
          child: filteredFilms.isEmpty
              ? _GalleryNoSearchResultsState(searchQuery: searchQuery)
              : _GalleryFilmList(films: filteredFilms),
        ),
      ],
    );
  }
}

class _GallerySearchField extends StatelessWidget {
  const _GallerySearchField({
    required this.controller,
    required this.focusNode,
    required this.onClose,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.72),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.24),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search by film title',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              tooltip: controller.text.isEmpty
                  ? 'Close search'
                  : 'Clear search',
              onPressed: controller.text.isEmpty ? onClose : controller.clear,
              icon: const Icon(Icons.close),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class _GalleryLoadingState extends StatelessWidget {
  const _GalleryLoadingState();

  @override
  Widget build(BuildContext context) {
    return const _GalleryStatePanel(
      icon: Icons.movie_creation_outlined,
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
    return _GalleryStatePanel(
      icon: Icons.error_outline,
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
    );
  }
}

class _GalleryEmptyState extends StatelessWidget {
  const _GalleryEmptyState();

  @override
  Widget build(BuildContext context) {
    return const _GalleryStatePanel(
      icon: Icons.movie_filter_outlined,
      child: Text(
        'No films are available right now. Please try again later.',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _GalleryNoSearchResultsState extends StatelessWidget {
  const _GalleryNoSearchResultsState({required this.searchQuery});

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return _GalleryStatePanel(
      icon: Icons.search_off,
      child: Text(
        'No films match "$searchQuery".',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _GalleryStatePanel extends StatelessWidget {
  const _GalleryStatePanel({
    required this.icon,
    required this.child,
  });

  final IconData icon;
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
                  Icon(
                    icon,
                    color: colorScheme.primary,
                    size: 30,
                  ),
                  const SizedBox(height: 14),
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
          padding: _gridPadding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: _gridMainAxisSpacing,
            crossAxisSpacing: _gridCrossAxisSpacing,
            childAspectRatio: _gridChildAspectRatio,
          ),
          itemBuilder: (context, index) {
            return FilmCardEntrance(
              index: index,
              child: _GalleryFilmCard(film: films[index]),
            );
          },
          itemCount: films.length,
        );
      },
    );
  }
}

List<Film> _filterFilms(List<Film> films, String searchQuery) {
  final normalizedQuery = searchQuery.trim().toLowerCase();
  if (normalizedQuery.isEmpty) {
    return films;
  }

  return films
      .where((film) => film.title.toLowerCase().contains(normalizedQuery))
      .toList(growable: false);
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
      onFavoriteToggle: () {
        unawaited(
          ref
              .read(favoriteMovieControllerProvider.notifier)
              .toggleFavorite(
                film.id,
              ),
        );
      },
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
