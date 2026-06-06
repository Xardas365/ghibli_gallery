import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_dto.freezed.dart';
part 'person_dto.g.dart';

@freezed
abstract class PersonDto with _$PersonDto {
  const factory PersonDto({
    required String id,
    required String name,
    required String url,
    String? gender,
    String? age,
    @JsonKey(name: 'eye_color') String? eyeColor,
    @JsonKey(name: 'hair_color') String? hairColor,
    @Default(<String>[]) List<String> films,
    String? species,
  }) = _PersonDto;

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);
}
