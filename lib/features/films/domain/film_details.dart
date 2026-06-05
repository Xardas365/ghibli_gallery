import 'package:ghibli_entry/features/films/domain/film.dart';

class FilmDetails {
  const FilmDetails({
    required this.film,
    required this.originalTitle,
    required this.originalTitleRomanised,
    required this.people,
    required this.species,
    required this.locations,
    required this.vehicles,
  });

  final Film film;
  final String originalTitle;
  final String originalTitleRomanised;
  final List<String> people;
  final List<String> species;
  final List<String> locations;
  final List<String> vehicles;
}
