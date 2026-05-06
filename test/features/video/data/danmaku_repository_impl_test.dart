import 'dart:typed_data';

import 'package:culcul/features/video/data/danmaku_repository_impl.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/result/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'danmaku repository fetches segments through basic Dio instead of cached Dio',
    () async {
      final cachedDio = Dio()..httpClientAdapter = _StaticAdapter(_cachedResponse);
      final basicDio = Dio()..httpClientAdapter = _StaticAdapter(_basicResponse);

      final container = ProviderContainer(
        overrides: [
          dioClientProvider.overrideWith((ref) => cachedDio),
          basicDioProvider.overrideWith((ref) => basicDio),
        ],
      );
      addTearDown(() {
        container.dispose();
        cachedDio.close(force: true);
        basicDio.close(force: true);
      });

      final result = await container
          .read(danmakuRepositoryProvider)
          .fetchDanmakuSegment(oid: 1, pid: 2, segmentIndex: 1);

      expect(result, isA<Success<DmSegMobileReply, AppError>>());
      expect(result.dataOrNull, isNotNull);
      expect(result.dataOrNull!.elems, isEmpty);
    },
  );
}

ResponseBody _cachedResponse(RequestOptions options) {
  return ResponseBody.fromBytes(
    Uint8List(0),
    304,
    statusMessage: 'Not Modified',
    headers: const <String, List<String>>{
      Headers.contentTypeHeader: <String>['application/octet-stream'],
    },
  );
}

ResponseBody _basicResponse(RequestOptions options) {
  return ResponseBody.fromBytes(
    DmSegMobileReply().writeToBuffer(),
    200,
    statusMessage: 'OK',
    headers: const <String, List<String>>{
      Headers.contentTypeHeader: <String>['application/octet-stream'],
    },
  );
}

final class _StaticAdapter implements HttpClientAdapter {
  _StaticAdapter(this._handler);

  final ResponseBody Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}
