import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:culcul/core/session/session_cookie_refresher.dart';
import 'package:culcul/shared/network/dio_client.dart';
import 'package:culcul/shared/network/interceptors/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _tokenInterceptorProvider = Provider<TokenInterceptor>((ref) {
  return TokenInterceptor(ref);
});

class _ExposedResponseInterceptorHandler extends ResponseInterceptorHandler {
  Future<dynamic> get completion => future;
}

class _FakeSessionCookieRefresher implements SessionCookieRefresher {
  _FakeSessionCookieRefresher({Completer<void>? completer}) : _completer = completer;

  final Completer<void>? _completer;
  int refreshCallCount = 0;

  @override
  Future<void> refreshCookies() async {
    refreshCallCount += 1;
    await _completer?.future;
  }
}

class _RecordingHttpClientAdapter implements HttpClientAdapter {
  _RecordingHttpClientAdapter(this._bodies);

  final List<ResponseBody> _bodies;
  final List<RequestOptions> requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return _bodies.removeAt(0);
  }

  @override
  void close({bool force = false}) {}
}

Response<dynamic> _expiredResponse(String path) {
  return Response<dynamic>(
    requestOptions: RequestOptions(path: path),
    data: <String, dynamic>{'code': -101},
  );
}

ResponseBody _jsonBody(Map<String, dynamic> json) {
  return ResponseBody.fromString(
    jsonEncode(json),
    200,
    headers: <String, List<String>>{
      Headers.contentTypeHeader: <String>[Headers.jsonContentType],
    },
  );
}

void main() {
  test('shared session contract is overridable for token refresh', () async {
    final refresher = _FakeSessionCookieRefresher();
    final container = ProviderContainer(
      overrides: [sessionCookieRefresherProvider.overrideWithValue(refresher)],
    );
    addTearDown(container.dispose);

    await container.read(sessionCookieRefresherProvider).refreshCookies();

    expect(refresher.refreshCallCount, 1);
  });

  test(
    'refreshes session via shared contract and retries the original request',
    () async {
      final refresher = _FakeSessionCookieRefresher();
      final adapter = _RecordingHttpClientAdapter(<ResponseBody>[
        _jsonBody(<String, dynamic>{'code': 0, 'data': 'ok'}),
      ]);
      final dio = Dio()..httpClientAdapter = adapter;

      final container = ProviderContainer(
        overrides: [
          dioClientProvider.overrideWithValue(dio),
          sessionCookieRefresherProvider.overrideWith((ref) => refresher),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(() => dio.close(force: true));

      final interceptor = container.read(_tokenInterceptorProvider);
      final handler = _ExposedResponseInterceptorHandler();

      await interceptor.onResponse(_expiredResponse('/x/web-interface/nav'), handler);
      final completion = await handler.completion;

      expect(refresher.refreshCallCount, 1);
      expect(adapter.requests, hasLength(1));
      expect(adapter.requests.single.extra['token_refreshed'], isTrue);
      expect((completion.data as Response<dynamic>).data, <String, dynamic>{
        'code': 0,
        'data': 'ok',
      });
    },
  );

  test('reuses the same in-flight refresh for concurrent expired responses', () async {
    final refreshCompleter = Completer<void>();
    final refresher = _FakeSessionCookieRefresher(completer: refreshCompleter);
    final adapter = _RecordingHttpClientAdapter(<ResponseBody>[
      _jsonBody(<String, dynamic>{'code': 0, 'data': 'first'}),
      _jsonBody(<String, dynamic>{'code': 0, 'data': 'second'}),
    ]);
    final dio = Dio()..httpClientAdapter = adapter;

    final container = ProviderContainer(
      overrides: [
        dioClientProvider.overrideWithValue(dio),
        sessionCookieRefresherProvider.overrideWith((ref) => refresher),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(() => dio.close(force: true));

    final interceptor = container.read(_tokenInterceptorProvider);
    final firstHandler = _ExposedResponseInterceptorHandler();
    final secondHandler = _ExposedResponseInterceptorHandler();

    final firstCall = interceptor.onResponse(
      _expiredResponse('/x/web-interface/nav'),
      firstHandler,
    );
    final secondCall = interceptor.onResponse(
      _expiredResponse('/x/web-interface/nav'),
      secondHandler,
    );

    await Future<void>.delayed(Duration.zero);
    expect(refresher.refreshCallCount, 1);

    refreshCompleter.complete();

    await Future.wait<void>(<Future<void>>[firstCall, secondCall]);
    await Future.wait<dynamic>(<Future<dynamic>>[
      firstHandler.completion,
      secondHandler.completion,
    ]);

    expect(adapter.requests, hasLength(2));
  });
}
