import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghibli_gallery/features/films/presentation/film_ui_constants.dart';

const Duration _placeholderFadeDuration = Duration(milliseconds: 260);
const Curve _placeholderFadeCurve = Curves.easeOut;

enum GhibliPlaceholderSet {
  gallery,
  wide,
}

const ValueKey<String> ghibliImageFallbackKey = ValueKey(
  'ghibli-image-fallback',
);

class GhibliCachedImage extends StatelessWidget {
  const GhibliCachedImage({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.showFallbackKey = true,
    this.iconSize = 44,
    this.placeholderSet,
    this.placeholderKey,
    super.key,
  });

  final String imageUrl;
  final BoxFit fit;
  final Alignment alignment;
  final bool showFallbackKey;
  final double iconSize;
  final GhibliPlaceholderSet? placeholderSet;
  final String? placeholderKey;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl.trim();
    if (url.isEmpty) {
      return GhibliImageFallback(
        iconSize: iconSize,
        showKey: showFallbackKey,
      );
    }
    final placeholderAssetPath = _placeholderAssetPath();

    return Stack(
      fit: StackFit.expand,
      children: [
        _buildLoadingPlaceholder(
          placeholderAssetPath,
          fit: fit,
          alignment: alignment,
        ),
        CachedNetworkImage(
          imageUrl: url,
          fit: fit,
          alignment: alignment,
          fadeInDuration: Duration.zero,
          fadeOutDuration: Duration.zero,
          placeholder: (context, url) {
            return const SizedBox.shrink();
          },
          imageBuilder: (context, imageProvider) {
            return Image(
              image: imageProvider,
              fit: fit,
              alignment: alignment,
              gaplessPlayback: true,
              frameBuilder: (context, child, frame, _) {
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: _placeholderFadeDuration,
                  curve: _placeholderFadeCurve,
                  child: child,
                );
              },
            );
          },
          errorWidget: (context, url, error) {
            return GhibliImageFallback(
              iconSize: iconSize,
              showKey: showFallbackKey,
            );
          },
        ),
      ],
    );
  }

  String? _placeholderAssetPath() {
    final set = placeholderSet;
    if (set == null) {
      return null;
    }

    final key = (placeholderKey ?? imageUrl).trim();
    if (key.isEmpty) {
      return null;
    }

    final placeholders = switch (set) {
      GhibliPlaceholderSet.gallery => FilmAssets.galleryPlaceholders,
      GhibliPlaceholderSet.wide => FilmAssets.widePlaceholders,
    };
    if (placeholders.isEmpty) {
      return null;
    }

    return placeholders[_stableStringHash(key) % placeholders.length];
  }
}

Widget _buildLoadingPlaceholder(
  String? placeholderAssetPath, {
  required BoxFit fit,
  required Alignment alignment,
}) {
  if (placeholderAssetPath == null) {
    return const GhibliImageLoadingPlaceholder();
  }

  return Image.asset(
    placeholderAssetPath,
    fit: fit,
    alignment: alignment,
    errorBuilder: (context, error, stackTrace) {
      return const GhibliImageLoadingPlaceholder();
    },
  );
}

int _stableStringHash(String value) {
  var hash = 0;
  for (final unit in value.codeUnits) {
    hash = (hash * 31 + unit) % 2147483647;
  }
  return hash;
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
    this.showKey = true,
    super.key,
  });

  final double iconSize;
  final bool showKey;

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
            FilmAssets.fallback,
            key: showKey ? ghibliImageFallbackKey : null,
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
