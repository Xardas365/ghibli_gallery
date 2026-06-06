import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_entry/core/network/api_client.dart';
import 'package:ghibli_entry/core/network/dio_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  return createDio();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(dio: ref.watch(dioProvider));
});
