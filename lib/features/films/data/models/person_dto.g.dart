// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonDto _$PersonDtoFromJson(Map<String, dynamic> json) => _PersonDto(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
  gender: json['gender'] as String?,
  age: json['age'] as String?,
  eyeColor: json['eye_color'] as String?,
  hairColor: json['hair_color'] as String?,
  films:
      (json['films'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  species: json['species'] as String?,
);

Map<String, dynamic> _$PersonDtoToJson(_PersonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'gender': instance.gender,
      'age': instance.age,
      'eye_color': instance.eyeColor,
      'hair_color': instance.hairColor,
      'films': instance.films,
      'species': instance.species,
    };
