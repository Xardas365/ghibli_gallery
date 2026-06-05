import 'package:flutter/material.dart';

class FilmMetadataSection extends StatelessWidget {
  const FilmMetadataSection({
    required this.title,
    required this.values,
    super.key,
  });

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final value in values)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(value),
            ),
        ],
      ),
    );
  }
}
