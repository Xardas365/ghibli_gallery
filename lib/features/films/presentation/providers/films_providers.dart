import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_gallery/features/films/domain/film.dart';
import 'package:ghibli_gallery/features/films/domain/film_repository.dart';

final filmRepositoryProvider = Provider<FilmRepository>((ref) {
  throw UnimplementedError('Wire FilmRepository after API and storage exist.');
});

final filmsProvider = FutureProvider<List<Film>>((ref) {
  return ref.watch(filmRepositoryProvider).fetchFilms();
});
