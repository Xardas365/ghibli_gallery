import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_movie.freezed.dart';
part 'favorite_movie.g.dart';

@freezed
abstract class FavoriteMovie with _$FavoriteMovie {
  @Assert(
    'rating == null || (rating >= 1 && rating <= 5)',
    'Rating must be between 1 and 5.',
  )
  const factory FavoriteMovie({
    required String filmId,
    required bool isFavorite,
    int? rating,
  }) = _FavoriteMovie;

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMovieFromJson(json);
}
