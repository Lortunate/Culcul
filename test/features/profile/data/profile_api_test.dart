import 'dart:typed_data';

import 'package:culcul/features/profile/data/profile_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileApi', () {
    test('marks getCard requests for WBI signing', () async {
      final adapter = _CapturingAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://api.bilibili.com'))
        ..httpClientAdapter = adapter;

      await ProfileApi(dio).getCard(168672377);

      expect(adapter.lastOptions?.path, '/x/web-interface/card');
      expect(adapter.lastOptions?.headers, containsPair('x-bili-wbi', 'true'));
    });
  });
}

final class _CapturingAdapter implements HttpClientAdapter {
  RequestOptions? lastOptions;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastOptions = options;
    return ResponseBody.fromString(
      '{"code":0,"message":"0","ttl":1,"data":{"card":{},"following":false}}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
