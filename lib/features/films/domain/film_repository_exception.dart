class FilmRepositoryException implements Exception {
  const FilmRepositoryException(this.message);

  final String message;

  @override
  String toString() => 'FilmRepositoryException: $message';
}
