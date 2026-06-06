import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';

void main() {
  group('FavoriteMovie', () {
    test('valid rating 1-5 is accepted', () {
      for (var rating = 1; rating <= 5; rating += 1) {
        final movie = FavoriteMovie(
          filmId: 'film-id',
          isFavorite: true,
          rating: rating,
        );

        expect(movie.rating, rating);
      }
    });

    test('null rating is accepted', () {
      final movie = FavoriteMovie(
        filmId: 'film-id',
        isFavorite: true,
      );

      expect(movie.rating, isNull);
    });

    test('invalid rating below 1 fails clearly', () {
      expect(
        () => FavoriteMovie(
          filmId: 'film-id',
          isFavorite: true,
          rating: 0,
        ),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'Rating must be between 1 and 5.',
          ),
        ),
      );
    });

    test('invalid rating above 5 fails clearly', () {
      expect(
        () => FavoriteMovie(
          filmId: 'film-id',
          isFavorite: true,
          rating: 6,
        ),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'Rating must be between 1 and 5.',
          ),
        ),
      );
    });

    test('fromJson validates rating', () {
      expect(
        () => FavoriteMovie.fromJson(const {
          'filmId': 'film-id',
          'isFavorite': true,
          'rating': 6,
        }),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'Rating must be between 1 and 5.',
          ),
        ),
      );
    });

    test('copyWith validates rating', () {
      final movie = FavoriteMovie(
        filmId: 'film-id',
        isFavorite: true,
        rating: 3,
      );

      expect(
        () => movie.copyWith(rating: 0),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'Rating must be between 1 and 5.',
          ),
        ),
      );
    });

    test('copyWith accepts null rating', () {
      final movie = FavoriteMovie(
        filmId: 'film-id',
        isFavorite: true,
        rating: 3,
      );

      final unratedMovie = movie.copyWith(rating: null);

      expect(unratedMovie.rating, isNull);
    });

    test('favorite and rating can exist independently', () {
      final favoriteWithoutRating = FavoriteMovie(
        filmId: 'favorite-film-id',
        isFavorite: true,
      );
      final ratingWithoutFavorite = FavoriteMovie(
        filmId: 'rated-film-id',
        isFavorite: false,
        rating: 4,
      );

      expect(favoriteWithoutRating.isFavorite, isTrue);
      expect(favoriteWithoutRating.rating, isNull);
      expect(ratingWithoutFavorite.isFavorite, isFalse);
      expect(ratingWithoutFavorite.rating, 4);
    });

    test('removing favorite preserves rating on the model level', () {
      final movie = FavoriteMovie(
        filmId: 'film-id',
        isFavorite: true,
        rating: 5,
      );

      final unfavoritedMovie = movie.copyWith(isFavorite: false);

      expect(unfavoritedMovie.isFavorite, isFalse);
      expect(unfavoritedMovie.rating, 5);
    });
  });
}
