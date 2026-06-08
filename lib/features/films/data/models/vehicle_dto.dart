import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_dto.freezed.dart';
part 'vehicle_dto.g.dart';

@freezed
abstract class VehicleDto with _$VehicleDto {
  const factory VehicleDto({
    required String id,
    required String name,
    required String url,
    String? description,
    @JsonKey(name: 'vehicle_class') String? vehicleClass,
    String? length,
    String? pilot,
    @Default(<String>[]) List<String> films,
  }) = _VehicleDto;

  factory VehicleDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleDtoFromJson(json);
}
