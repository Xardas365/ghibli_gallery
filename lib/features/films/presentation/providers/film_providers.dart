import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_entry/features/films/data/film_infrastructure_providers.dart';
import 'package:ghibli_entry/features/films/domain/film.dart';
import 'package:ghibli_entry/features/films/domain/film_details.dart';

final FutureProvider<List<Film>> filmsProvider = FutureProvider<List<Film>>((
  ref,
) {
  return ref.watch(filmRepositoryProvider).fetchFilms();
});

// Riverpod 3 does not export the concrete family type used by this provider.
// ignore: specify_nonobvious_property_types
final filmDetailsProvider = FutureProvider.family<FilmDetails, String>((
  ref,
  filmId,
) {
  return ref.watch(filmRepositoryProvider).fetchFilmDetails(filmId);
});
