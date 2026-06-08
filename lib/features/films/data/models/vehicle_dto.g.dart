// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleDto _$VehicleDtoFromJson(Map<String, dynamic> json) => _VehicleDto(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
  description: json['description'] as String?,
  vehicleClass: json['vehicle_class'] as String?,
  length: json['length'] as String?,
  pilot: json['pilot'] as String?,
  films:
      (json['films'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$VehicleDtoToJson(_VehicleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'description': instance.description,
      'vehicle_class': instance.vehicleClass,
      'length': instance.length,
      'pilot': instance.pilot,
      'films': instance.films,
    };
