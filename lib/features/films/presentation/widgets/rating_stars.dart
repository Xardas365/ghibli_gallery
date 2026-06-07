import 'package:flutter/material.dart';
import 'package:ghibli_gallery/app/theme.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({required this.rating, required this.onChanged, super.key});

  final int? rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var value = 1; value <= 5; value += 1)
          IconButton(
            tooltip: '$value star rating',
            onPressed: () => onChanged(value),
            icon: Icon(
              value <= (rating ?? 0) ? Icons.star : Icons.star_border,
              color: value <= (rating ?? 0)
                  ? ghibliStarGold
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}
