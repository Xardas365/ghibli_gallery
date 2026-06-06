import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';

part 'film_with_user_data.freezed.dart';

@freezed
abstract class FilmWithUserData with _$FilmWithUserData {
  const factory FilmWithUserData({
    required Film film,
    FavoriteMovie? userData,
  }) = _FilmWithUserData;
}
