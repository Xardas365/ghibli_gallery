import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/core/network/api_client.dart';
import 'package:ghibli_entry/core/network/api_exception.dart';
import 'package:ghibli_entry/core/network/dio_provider.dart';

void main() {
  group('ApiException', () {
    test('maps timeout errors', () {
      final exception = ApiException.fromDioException(
        DioException(
          requestOptions: RequestOptions(path: '/films'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(exception.message, 'Connection timed out.');
      expect(exception.statusCode, isNull);
    });

    test('preserves statusCode for badResponse', () {
      final exception = ApiException.fromDioException(
        DioException(
          requestOptions: RequestOptions(path: '/films'),
          response: Response<void>(
            requestOptions: RequestOptions(path: '/films'),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(exception.message, 'Unexpected API response.');
      expect(exception.statusCode, 500);
    });
  });

  group('ApiClient', () {
    test('can parse successful JSON response through parser', () async {
      final dio = createTestDio(
        adapter: JsonResponseAdapter({'title': 'Castle in the Sky'}),
      );
      final client = ApiClient(dio: dio);

      final title = await client.get<String>(
        '/films',
        parser: (json) {
          final map = json! as Map<String, dynamic>;
          return map['title']! as String;
        },
      );

      expect(title, 'Castle in the Sky');
    });

    test('supports absolute URLs', () async {
      final adapter = JsonResponseAdapter({'ok': true});
      final dio = createTestDio(adapter: adapter);
      final client = ApiClient(dio: dio);

      await client.get<bool>(
        'https://ghibli-api.vercel.app/api/films',
        parser: (json) => (json! as Map<String, dynamic>)['ok']! as bool,
      );

      expect(
        adapter.lastRequestedUri,
        'https://ghibli-api.vercel.app/api/films',
      );
    });

    test('wraps DioException into ApiException', () async {
      final dio = createTestDio(
        adapter: ThrowingAdapter(
          DioException(
            requestOptions: RequestOptions(path: '/films'),
            type: DioExceptionType.receiveTimeout,
          ),
        ),
      );
      final client = ApiClient(dio: dio);

      await expectLater(
        client.get<void>('/films', parser: (_) {}),
        throwsA(
          isA<ApiException>()
              .having(
                (exception) => exception.message,
                'message',
                'Response receive timed out.',
              )
              .having(
                (exception) => exception.statusCode,
                'statusCode',
                isNull,
              ),
        ),
      );
    });
  });
}

Dio createTestDio({required HttpClientAdapter adapter}) {
  final dio = createDio(enableLogging: false)..httpClientAdapter = adapter;
  return dio;
}

class JsonResponseAdapter implements HttpClientAdapter {
  JsonResponseAdapter(this.json);

  final Object json;
  String? lastRequestedUri;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequestedUri = options.uri.toString();

    return ResponseBody.fromString(
      jsonEncode(json),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

class ThrowingAdapter implements HttpClientAdapter {
  const ThrowingAdapter(this.exception);

  final DioException exception;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw exception;
  }
}
