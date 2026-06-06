import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_dto.freezed.dart';
part 'film_dto.g.dart';

@freezed
abstract class FilmDto with _$FilmDto {
  const factory FilmDto({
    required String id,
    required String title,
    @JsonKey(name: 'original_title') required String originalTitle,
    @JsonKey(name: 'original_title_romanised')
    required String originalTitleRomanised,
    required String image,
    @JsonKey(name: 'movie_banner') required String movieBanner,
    required String description,
    required String director,
    required String producer,
    required String url,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'running_time') String? runningTime,
    @JsonKey(name: 'rt_score') String? rtScore,
    @Default(<String>[]) List<String> people,
    @Default(<String>[]) List<String> species,
    @Default(<String>[]) List<String> locations,
    @Default(<String>[]) List<String> vehicles,
  }) = _FilmDto;

  factory FilmDto.fromJson(Map<String, dynamic> json) =>
      _$FilmDtoFromJson(json);
}
