import 'package:dio/dio.dart';

const apiBaseUrl = 'https://ghibli-api.vercel.app/api';

Dio createDio() {
  return Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // Keep this explicit because the API client contract requires JSON.
      // ignore: avoid_redundant_argument_values
      responseType: ResponseType.json,
    ),
  );
}
