import 'package:ghibli_entry/features/films/data/api/film_api.dart';
import 'package:ghibli_entry/features/films/data/mappers/film_mappers.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/domain/film_details.dart';
import 'package:ghibli_entry/features/films/domain/film_repository.dart';
import 'package:ghibli_entry/features/films/domain/film_repository_exception.dart';

class FilmRepositoryImpl implements FilmRepository {
  const FilmRepositoryImpl({required this.api});

  final FilmApi api;

  @override
  Future<List<Film>> fetchFilms() async {
    final films = await api.fetchFilms();
    return films.map((film) => film.toDomain()).toList();
  }

  @override
  Future<FilmDetails> fetchFilmDetails(String filmId) async {
    final films = await api.fetchFilms();
    final matchingFilms = films.where((film) => film.id == filmId);
    final film = matchingFilms.isEmpty ? null : matchingFilms.first;

    if (film == null) {
      throw FilmRepositoryException('Film with id "$filmId" was not found.');
    }

    final people = await _fetchConcreteResources(
      film.people,
      api.fetchPersonByUrl,
    );
    final species = await _fetchConcreteResources(
      film.species,
      api.fetchSpeciesByUrl,
    );
    final locations = await _fetchConcreteResources(
      film.locations,
      api.fetchLocationByUrl,
    );
    final vehicles = await _fetchConcreteResources(
      film.vehicles,
      api.fetchVehicleByUrl,
    );

    return film.toDetailsDomain(
      people: people,
      species: species,
      locations: locations,
      vehicles: vehicles,
    );
  }
}

bool isConcreteResourceUrl(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasScheme) {
    return false;
  }

  final segments = uri.pathSegments
      .where((segment) => segment.isNotEmpty)
      .toList(growable: false);
  if (segments.length < 3) {
    return false;
  }

  const resourceNames = {'people', 'species', 'locations', 'vehicles'};
  final resourceName = segments[segments.length - 2];
  return resourceNames.contains(resourceName);
}

Future<List<T>> _fetchConcreteResources<T>(
  List<String> urls,
  Future<T> Function(String url) fetch,
) async {
  final resources = <T>[];

  try {
    for (final url in urls.where(isConcreteResourceUrl)) {
      resources.add(await fetch(url));
    }
  } on Object {
    return <T>[];
  }

  return resources;
}
