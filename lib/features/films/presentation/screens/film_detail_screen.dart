import 'package:flutter/material.dart';
import 'package:ghibli_entry/features/films/presentation/widgets/favorite_button.dart';
import 'package:ghibli_entry/features/films/presentation/widgets/film_metadata_section.dart';
import 'package:ghibli_entry/features/films/presentation/widgets/rating_stars.dart';

class FilmDetailScreen extends StatelessWidget {
  const FilmDetailScreen({required this.filmId, super.key});

  final String filmId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Film detail')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Film ID: $filmId')),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FavoriteButton(isFavorite: false, onPressed: () {}),
              const SizedBox(width: 12),
              RatingStars(rating: null, onChanged: (_) {}),
            ],
          ),
          const SizedBox(height: 24),
          const FilmMetadataSection(
            title: 'Details',
            values: ['All film parameters will be rendered here.'],
          ),
          const FilmMetadataSection(
            title: 'Related data',
            values: [
              'People, species, locations, and vehicles will be mapped here.',
            ],
          ),
        ],
      ),
    );
  }
}
