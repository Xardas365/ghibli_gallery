import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghibli_entry/core/network/dio_provider.dart';
import 'package:ghibli_entry/core/network/logging_interceptor.dart';

void main() {
  group('DebugLoggingInterceptor', () {
    test('can be instantiated', () {
      expect(DebugLoggingInterceptor(), isA<Interceptor>());
    });

    test('does not change request or response behavior', () async {
      final logs = <String>[];
      final dio = createDio(enableLogging: false)
        ..httpClientAdapter = JsonResponseAdapter({'ok': true})
        ..interceptors.add(DebugLoggingInterceptor(logger: logs.add));

      final response = await dio.get<Map<String, dynamic>>('/films');

      expect(response.data, {'ok': true});
      expect(logs, hasLength(2));
      expect(logs.first, contains('HTTP GET'));
      expect(logs.first, contains('/films'));
      expect(logs.last, contains('HTTP 200'));
      expect(logs.last, contains('duration='));
      expect(logs.join('\n'), isNot(contains('ok')));
    });

    test('logs DioException type and status without response body', () async {
      final logs = <String>[];
      final dio = createDio(enableLogging: false)
        ..httpClientAdapter = ErrorResponseAdapter()
        ..interceptors.add(DebugLoggingInterceptor(logger: logs.add));

      await expectLater(
        dio.get<void>('/films'),
        throwsA(isA<DioException>()),
      );

      expect(logs.first, contains('HTTP GET'));
      expect(logs.last, contains('HTTP error'));
      expect(logs.last, contains('type=badResponse'));
      expect(logs.last, contains('status=500'));
      expect(logs.join('\n'), isNot(contains('server-secret')));
    });

    test('strips query parameters from request log', () async {
      final logs = <String>[];
      final dio = createDio(enableLogging: false)
        ..httpClientAdapter = JsonResponseAdapter({'ok': true})
        ..interceptors.add(DebugLoggingInterceptor(logger: logs.add));

      await dio.get<void>('/films?token=server-secret');

      expect(logs.first, contains('/films'));
      expect(logs.first, isNot(contains('server-secret')));
      expect(logs.first, isNot(contains('token=')));
    });
  });

  group('createDio', () {
    test('adds logging interceptor by default in debug mode', () {
      final dio = createDio();

      final matcher = kDebugMode ? hasLength(1) : isEmpty;
      expect(dio.interceptors.whereType<DebugLoggingInterceptor>(), matcher);
    });

    test('does not add logging interceptor when disabled', () {
      final dio = createDio(enableLogging: false);

      expect(dio.interceptors.whereType<DebugLoggingInterceptor>(), isEmpty);
    });
  });
}

class JsonResponseAdapter implements HttpClientAdapter {
  JsonResponseAdapter(this.json);

  final Object json;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(json),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

class ErrorResponseAdapter implements HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      '{"message":"server-secret"}',
      500,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}
