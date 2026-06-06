import 'package:freezed_annotation/freezed_annotation.dart';

part 'film.freezed.dart';

@freezed
abstract class Film with _$Film {
  const factory Film({
    required String id,
    required String title,
    required String description,
    required String director,
    required String producer,
    required int? releaseYear,
    required int? runningTimeMinutes,
    required int? rtScore,
    required String image,
    required String movieBanner,
  }) = _Film;
}
