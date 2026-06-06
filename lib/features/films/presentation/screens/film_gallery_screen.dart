import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ghibli_entry/app/router.dart';
import 'package:ghibli_entry/features/films/presentation/widgets/film_card.dart';

class FilmGalleryScreen extends StatelessWidget {
  const FilmGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
        children: [
          FilmCard(
            title: 'Films',
            subtitle: 'API gallery skeleton',
            onTap: () {
              unawaited(
                Navigator.of(context).pushNamed(
                  AppRoutes.filmDetailPath('placeholder-film-id'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
