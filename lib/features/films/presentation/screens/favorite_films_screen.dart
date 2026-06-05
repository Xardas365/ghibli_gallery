import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_entry/features/films/presentation/providers/favorites_providers.dart';

class FavoriteFilmsScreen extends ConsumerWidget {
  const FavoriteFilmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRating = ref.watch(ratingFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SegmentedButton<int?>(
              segments: const [
                ButtonSegment(value: null, label: Text('All')),
                ButtonSegment(value: 5, label: Text('5')),
                ButtonSegment(value: 4, label: Text('4')),
                ButtonSegment(value: 3, label: Text('3')),
              ],
              selected: {selectedRating},
              onSelectionChanged: (selection) {
                ref.read(ratingFilterProvider.notifier).rating =
                    selection.first;
              },
            ),
            const SizedBox(height: 24),
            const Text('Favorite film list will be connected here.'),
          ],
        ),
      ),
    );
  }
}
