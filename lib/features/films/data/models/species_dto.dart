import 'package:freezed_annotation/freezed_annotation.dart';

part 'species_dto.freezed.dart';
part 'species_dto.g.dart';

@freezed
abstract class SpeciesDto with _$SpeciesDto {
  const factory SpeciesDto({
    required String id,
    required String name,
    required String url,
    String? classification,
    @JsonKey(name: 'eye_colors') String? eyeColors,
    @JsonKey(name: 'hair_colors') String? hairColors,
    @Default(<String>[]) List<String> people,
    @Default(<String>[]) List<String> films,
  }) = _SpeciesDto;

  factory SpeciesDto.fromJson(Map<String, dynamic> json) =>
      _$SpeciesDtoFromJson(json);
}
