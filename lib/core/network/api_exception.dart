class ApiException implements Exception {
  const ApiException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() {
    if (cause == null) {
      return 'ApiException: $message';
    }
    return 'ApiException: $message ($cause)';
  }
}
