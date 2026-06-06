// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpeciesDto _$SpeciesDtoFromJson(Map<String, dynamic> json) => _SpeciesDto(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
  classification: json['classification'] as String?,
  eyeColors: json['eye_colors'] as String?,
  hairColors: json['hair_colors'] as String?,
  people:
      (json['people'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  films:
      (json['films'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$SpeciesDtoToJson(_SpeciesDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'classification': instance.classification,
      'eye_colors': instance.eyeColors,
      'hair_colors': instance.hairColors,
      'people': instance.people,
      'films': instance.films,
    };
