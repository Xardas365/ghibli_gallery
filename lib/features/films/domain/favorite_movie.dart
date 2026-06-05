class FavoriteMovie {
  const FavoriteMovie({
    required this.filmId,
    required this.isFavorite,
    this.rating,
  }) : assert(
         rating == null || (rating >= 1 && rating <= 5),
         'Rating must be between 1 and 5.',
       );

  final String filmId;
  final bool isFavorite;
  final int? rating;
}
