import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_dto.freezed.dart';
part 'location_dto.g.dart';

@freezed
abstract class LocationDto with _$LocationDto {
  const factory LocationDto({
    required String id,
    required String name,
    required String url,
    String? climate,
    String? terrain,
    @JsonKey(name: 'surface_water') String? surfaceWater,
    @Default(<String>[]) List<String> residents,
    @Default(<String>[]) List<String> films,
  }) = _LocationDto;

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}
