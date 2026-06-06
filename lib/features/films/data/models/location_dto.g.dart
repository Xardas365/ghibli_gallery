// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => _LocationDto(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
  climate: json['climate'] as String?,
  terrain: json['terrain'] as String?,
  surfaceWater: json['surface_water'] as String?,
  residents:
      (json['residents'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  films:
      (json['films'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$LocationDtoToJson(_LocationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'climate': instance.climate,
      'terrain': instance.terrain,
      'surface_water': instance.surfaceWater,
      'residents': instance.residents,
      'films': instance.films,
    };
