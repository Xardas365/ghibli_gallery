class ApiClient {
  ApiClient({Uri? baseUri})
    : baseUri = baseUri ?? Uri.parse('https://ghibliapi.vercel.app');

  final Uri baseUri;

  Uri resolve(String path) => baseUri.resolve(path);

  Future<Object?> getJson(String pathOrUrl) {
    throw UnimplementedError(
      'HTTP client implementation belongs in the API step.',
    );
  }
}
