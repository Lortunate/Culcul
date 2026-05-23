import 'dart:typed_data';

import 'package:culcul/features/favorites/data/fav_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavApi', () {
    test('loads created folders with video favorite state query parameters', () async {
      final adapter = _CapturingAdapter(
        response: '{"code":0,"message":"0","ttl":1,"data":{"count":0,"list":[]}}',
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://api.bilibili.com'))
        ..httpClientAdapter = adapter;

      await FavApi(dio).getCreatedFolders(42, rid: 100, type: 2);

      expect(adapter.lastOptions?.path, '/x/v3/fav/folder/created/list-all');
      expect(adapter.lastOptions?.queryParameters, containsPair('up_mid', 42));
      expect(adapter.lastOptions?.queryParameters, containsPair('rid', 100));
      expect(adapter.lastOptions?.queryParameters, containsPair('type', 2));
    });

    test('marks resource deal requests for csrf and form encoded deltas', () async {
      final adapter = _CapturingAdapter(
        response: '{"code":0,"message":"0","ttl":1,"data":null}',
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://api.bilibili.com'))
        ..httpClientAdapter = adapter;

      await FavApi(dio).dealResource(100, 2, addMediaIds: '1,2', delMediaIds: '3');

      expect(adapter.lastOptions?.method, 'POST');
      expect(adapter.lastOptions?.path, '/x/v3/fav/resource/deal');
      expect(adapter.lastOptions?.headers, containsPair('x-bili-csrf', 'true'));
      expect(adapter.lastOptions?.contentType, Headers.formUrlEncodedContentType);
      final data = adapter.lastOptions?.data as Map<String, dynamic>;
      expect(data, containsPair('rid', 100));
      expect(data, containsPair('type', 2));
      expect(data, containsPair('add_media_ids', '1,2'));
      expect(data, containsPair('del_media_ids', '3'));
      expect(data, containsPair('platform', 'web'));
    });
  });
}

final class _CapturingAdapter implements HttpClientAdapter {
  _CapturingAdapter({required this.response});

  final String response;
  RequestOptions? lastOptions;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastOptions = options;
    return ResponseBody.fromString(
      response,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
