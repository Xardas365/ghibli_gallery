// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteMovie _$FavoriteMovieFromJson(Map<String, dynamic> json) =>
    _FavoriteMovie(
      filmId: json['filmId'] as String,
      isFavorite: json['isFavorite'] as bool,
      rating: (json['rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FavoriteMovieToJson(_FavoriteMovie instance) =>
    <String, dynamic>{
      'filmId': instance.filmId,
      'isFavorite': instance.isFavorite,
      'rating': instance.rating,
    };
