import 'package:ghibli_entry/features/films/data/models/film_dto.dart';
import 'package:ghibli_entry/features/films/data/models/location_dto.dart';
import 'package:ghibli_entry/features/films/data/models/person_dto.dart';
import 'package:ghibli_entry/features/films/data/models/species_dto.dart';
import 'package:ghibli_entry/features/films/data/models/vehicle_dto.dart';
import 'package:ghibli_entry/features/films/domain/favorite_movie.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/domain/film_details.dart';
import 'package:ghibli_entry/features/films/domain/film_with_user_data.dart';

extension FilmDtoMapper on FilmDto {
  Film toDomain() {
    return Film(
      id: id,
      title: title,
      description: description,
      director: director,
      producer: producer,
      releaseYear: _parseInt(releaseDate),
      runningTimeMinutes: _parseInt(runningTime),
      rtScore: _parseInt(rtScore),
      image: image,
      movieBanner: movieBanner,
    );
  }

  FilmDetails toDetailsDomain({
    List<PersonDto> people = const <PersonDto>[],
    List<SpeciesDto> species = const <SpeciesDto>[],
    List<LocationDto> locations = const <LocationDto>[],
    List<VehicleDto> vehicles = const <VehicleDto>[],
  }) {
    return FilmDetails(
      film: toDomain(),
      originalTitle: originalTitle,
      originalTitleRomanised: originalTitleRomanised,
      people: people.map((person) => person.name).toList(),
      species: species.map((item) => item.name).toList(),
      locations: locations.map((location) => location.name).toList(),
      vehicles: vehicles.map((vehicle) => vehicle.name).toList(),
    );
  }
}

extension FilmUserDataMapper on Film {
  FilmWithUserData withUserData(FavoriteMovie? userData) {
    return FilmWithUserData(film: this, userData: userData);
  }
}

int? _parseInt(String? value) {
  if (value == null) {
    return null;
  }
  return int.tryParse(value);
}
