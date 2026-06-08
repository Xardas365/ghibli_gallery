import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const _fallbackImageAsset = 'assets/images/fallback.gif';
const ValueKey<String> ghibliImageFallbackKey = ValueKey(
  'ghibli-image-fallback',
);

class GhibliCachedImage extends StatelessWidget {
  const GhibliCachedImage({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.iconSize = 44,
    super.key,
  });

  final String imageUrl;
  final BoxFit fit;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl.trim();
    if (url.isEmpty) {
      return GhibliImageFallback(iconSize: iconSize);
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholder: (context, url) => const GhibliImageLoadingPlaceholder(),
      errorWidget: (context, url, error) {
        return GhibliImageFallback(iconSize: iconSize);
      },
    );
  }
}

class GhibliImageLoadingPlaceholder extends StatelessWidget {
  const GhibliImageLoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 32,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.72),
        ),
      ),
    );
  }
}

class GhibliImageFallback extends StatelessWidget {
  const GhibliImageFallback({
    this.iconSize = 44,
    super.key,
  });

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            _fallbackImageAsset,
            key: ghibliImageFallbackKey,
            fit: BoxFit.contain,
            semanticLabel: 'Confused fallback image',
            errorBuilder: (context, error, stackTrace) {
              return _FallbackIcon(iconSize: iconSize);
            },
          ),
        ),
      ),
    );
  }
}

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon({required this.iconSize});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.64),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Icon(
          Icons.movie_creation_outlined,
          size: iconSize,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
