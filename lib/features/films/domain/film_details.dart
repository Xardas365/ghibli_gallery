import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ghibli_gallery/features/films/domain/film.dart';

part 'film_details.freezed.dart';

@freezed
abstract class FilmDetails with _$FilmDetails {
  const factory FilmDetails({
    required Film film,
    required String originalTitle,
    required String originalTitleRomanised,
    required List<String> people,
    required List<String> species,
    required List<String> locations,
    required List<String> vehicles,
  }) = _FilmDetails;
}
