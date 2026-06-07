import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FilmCardEntrance extends StatelessWidget {
  const FilmCardEntrance({
    required this.index,
    required this.child,
    super.key,
  });

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final duration = (160 + (index % 3) * 20).ms;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 8),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
