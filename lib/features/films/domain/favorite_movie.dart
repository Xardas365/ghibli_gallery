import 'package:flutter/foundation.dart';

@immutable
class FavoriteMovie {
  factory FavoriteMovie({
    required String filmId,
    required bool isFavorite,
    int? rating,
  }) {
    _validateRating(rating);

    return FavoriteMovie._(
      filmId: filmId,
      isFavorite: isFavorite,
      rating: rating,
    );
  }

  const FavoriteMovie._({
    required this.filmId,
    required this.isFavorite,
    required this.rating,
  });

  factory FavoriteMovie.fromJson(Map<String, Object?> json) {
    return FavoriteMovie(
      filmId: json['filmId']! as String,
      isFavorite: json['isFavorite']! as bool,
      rating: json['rating'] as int?,
    );
  }

  final String filmId;
  final bool isFavorite;
  final int? rating;

  FavoriteMovie copyWith({
    String? filmId,
    bool? isFavorite,
    Object? rating = _missingRating,
  }) {
    final nextRating = identical(rating, _missingRating)
        ? this.rating
        : _ratingFromCopyWith(rating);

    return FavoriteMovie(
      filmId: filmId ?? this.filmId,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: nextRating,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'filmId': filmId,
      'isFavorite': isFavorite,
      'rating': rating,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FavoriteMovie &&
            runtimeType == other.runtimeType &&
            filmId == other.filmId &&
            isFavorite == other.isFavorite &&
            rating == other.rating;
  }

  @override
  int get hashCode => Object.hash(filmId, isFavorite, rating);

  @override
  String toString() {
    return 'FavoriteMovie('
        'filmId: $filmId, '
        'isFavorite: $isFavorite, '
        'rating: $rating'
        ')';
  }
}

void _validateRating(int? rating) {
  if (rating == null || (rating >= 1 && rating <= 5)) {
    return;
  }

  throw ArgumentError.value(
    rating,
    'rating',
    'Rating must be between 1 and 5.',
  );
}

int? _ratingFromCopyWith(Object? rating) {
  if (rating == null || rating is int) {
    return rating as int?;
  }

  throw ArgumentError.value(
    rating,
    'rating',
    'Rating must be an int from 1 to 5 or null.',
  );
}

const _missingRating = Object();
