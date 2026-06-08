import 'package:flutter/material.dart';
import 'package:ghibli_gallery/features/films/presentation/film_ui_constants.dart';

class GhibliLoadingState extends StatelessWidget {
  const GhibliLoadingState({
    required this.primaryText,
    super.key,
    this.secondaryText,
    this.enableAnimation = true,
  });

  final String primaryText;
  final String? secondaryText;
  final bool enableAnimation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final cardWidth = (screenWidth * 0.75).clamp(230.0, 360.0);
    final gifWidth = cardWidth - 28;
    final naturalGifHeight = gifWidth * 9 / 16;
    final gifHeight = naturalGifHeight > 150
        ? 150.0
        : naturalGifHeight.clamp(110.0, screenHeight * 0.28);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: cardWidth,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.72),
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: gifWidth,
                    height: gifHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Semantics(
                        label: 'Loading animation',
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              FilmAssets.loading,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.low,
                              excludeFromSemantics: true,
                              gaplessPlayback: enableAnimation,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.45),
                                    Colors.black.withValues(alpha: 0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    primaryText,
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
                  ),
                  if (secondaryText != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      secondaryText!,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  const SizedBox(
                    width: 72,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _LoadingDot(),
                        _LoadingDot(),
                        _LoadingDot(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingDot extends StatelessWidget {
  const _LoadingDot();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 10,
      height: 10,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: Colors.white70,
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
