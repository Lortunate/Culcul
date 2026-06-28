import 'dart:async';
import 'dart:io';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/providers/wbi_helper_provider.dart';
import 'package:culcul/core/data/network/resource_api.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Unified auth interceptor handling CSRF, WBI signing, and token refresh.
///
/// Replaces the separate CsrfInterceptor, TokenInterceptor, and WbiInterceptor
/// to reduce interceptor chain overhead and simplify auth flow.
class AuthInterceptor extends QueuedInterceptor {
  static final String _passportHost = Uri.parse(ApiConstants.passportBaseUrl).host;
  static const String _logoutPath = '/login/exit/v2';
  static const String _tokenRefreshedExtra = 'token_refreshed';
  static const String _disableTokenRefreshExtra = 'disable_token_refresh';

  final Ref _ref;
  String? _cachedCsrf;
  Future<void>? _refreshCookieFuture;
  WbiHelper? _wbiHelper;

  AuthInterceptor(this._ref);

  // ── CSRF ──

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Step 1: WBI signing if needed
      await _signWbiIfNeeded(options);

      // Step 2: CSRF injection if needed
      if (options.headers.containsKey('x-bili-csrf')) {
        options.headers.remove('x-bili-csrf');
        final csrf = await _resolveCsrf(options);
        _injectCsrf(options, csrf);
      }

      handler.next(options);
    } on AuthAppError catch (error) {
      handler.reject(DioException(requestOptions: options, error: error));
    } catch (e, stack) {
      DevLogger.log('network', 'auth.interceptor_error', <String, Object?>{
        'error': e,
        'stack': stack,
      });
      handler.next(options);
    }
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final code = data['code'];

      if (code == -101) {
        if (response.requestOptions.extra[_tokenRefreshedExtra] == true ||
            response.requestOptions.extra[_disableTokenRefreshExtra] == true) {
          handler.next(response);
          return;
        }

        final path = response.requestOptions.path;
        if (path.contains('/passport-login/web/cookie/')) {
          handler.next(response);
          return;
        }

        try {
          await _ensureCookieRefreshed();

          final retryExtra = Map<String, dynamic>.from(response.requestOptions.extra)
            ..[_tokenRefreshedExtra] = true;

          final dio = _ref.read(dioClientProvider);
          final retryOptions = response.requestOptions.copyWith(extra: retryExtra);

          final newResponse = await dio.fetch<dynamic>(retryOptions);
          handler.resolve(newResponse);
          return;
        } catch (e) {
          DevLogger.log('network', 'auth.cookie_refresh_failed', <String, Object?>{
            'error': e,
          });
        }
      }
    }
    handler.next(response);
  }

  // ── WBI Signing ──

  Future<void> _signWbiIfNeeded(RequestOptions options) async {
    final hasWbiHeader = options.headers.keys.any((k) => k.toLowerCase() == 'x-bili-wbi');
    final isWbiPath = options.uri.path.contains('/wbi/');
    final markedAsWbi = options.extra['requires_wbi'] == true;
    final requiresWbi = hasWbiHeader || isWbiPath || markedAsWbi;

    if (!requiresWbi) return;

    options.extra['requires_wbi'] = true;
    options.headers.removeWhere((key, value) => key.toLowerCase() == 'x-bili-wbi');

    _ensureCookieCount(options);

    final wbiHelper = _wbiHelper ??= WbiHelper(_ref.read(basicResourceApiProvider));
    if (!wbiHelper.areKeysFresh) {
      await wbiHelper.updateKeys();
    }

    options.queryParameters = wbiHelper.sign(options.queryParameters);
  }

  void _ensureCookieCount(RequestOptions options) {
    final cookieHeader = options.headers[HttpHeaders.cookieHeader];
    if (cookieHeader is! String) return;

    var count = 0;
    for (var i = 0; i < cookieHeader.length; i++) {
      if (cookieHeader[i] == ';') count++;
    }
    count++;

    if (count < 3) {
      final sb = StringBuffer(cookieHeader);
      for (var i = 0; i < 3 - count; i++) {
        sb.write('; dummy$i=0');
      }
      options.headers[HttpHeaders.cookieHeader] = sb.toString();
    }
  }

  // ── CSRF Resolution ──

  Future<String> _resolveCsrf(RequestOptions options) async {
    if (_cachedCsrf != null) {
      return _cachedCsrf!;
    }

    final fromHeader = _extractCsrfFromCookieHeader(
      options.headers['cookie'] ?? options.headers['Cookie'],
    );
    if (fromHeader != null) {
      _cachedCsrf = fromHeader;
      return fromHeader;
    }

    final cookieJar = _ref.read(cookieJarProvider);
    for (final uri in _csrfLookupUris(options.uri)) {
      final cookies = await cookieJar.loadForRequest(uri);
      final fromCookies = _extractCsrfFromCookies(cookies);
      if (fromCookies != null) {
        _cachedCsrf = fromCookies;
        return fromCookies;
      }
    }

    throw const AppError.auth('CSRF token not found');
  }

  String? _extractCsrfFromCookieHeader(Object? rawCookieHeader) {
    if (rawCookieHeader is! String || rawCookieHeader.isEmpty) {
      return null;
    }

    for (final segment in rawCookieHeader.split(';')) {
      final trimmed = segment.trim();
      if (!trimmed.startsWith('bili_jct=')) continue;
      final value = trimmed.substring('bili_jct='.length);
      if (value.isNotEmpty) return value;
    }

    return null;
  }

  String? _extractCsrfFromCookies(List<Cookie> cookies) {
    for (final cookie in cookies) {
      if (cookie.name == 'bili_jct' && cookie.value.isNotEmpty) {
        return cookie.value;
      }
    }
    return null;
  }

  List<Uri> _csrfLookupUris(Uri requestUri) {
    final uris = <Uri>[
      requestUri,
      Uri.parse('https://bilibili.com'),
      Uri.parse(ApiConstants.passportBaseUrl),
      Uri.parse(ApiConstants.baseUrl),
    ];

    final seen = <String>{};
    return uris.where((uri) {
      final key = '${uri.scheme}://${uri.host}:${uri.hasPort ? uri.port : ''}';
      return seen.add(key);
    }).toList();
  }

  void _injectCsrf(RequestOptions options, String csrf) {
    if (options.method.toUpperCase() != 'POST') {
      options.queryParameters['csrf'] = csrf;
      return;
    }

    final fields = _csrfFields(options.uri, csrf);
    options.data ??= <String, dynamic>{};

    if (options.data is Map) {
      final body = Map<String, dynamic>.from(options.data as Map);
      for (final field in fields) {
        body[field.key] = field.value;
      }
      options.data = body;
      return;
    }

    if (options.data is FormData) {
      final formData = options.data as FormData;
      final keys = fields.map((field) => field.key).toSet();
      formData.fields.removeWhere((entry) => keys.contains(entry.key));
      formData.fields.addAll(fields);
    }
  }

  List<MapEntry<String, String>> _csrfFields(Uri uri, String csrf) {
    final fields = <MapEntry<String, String>>[
      MapEntry('csrf', csrf),
      MapEntry('csrf_token', csrf),
    ];
    if (uri.host == _passportHost && uri.path == _logoutPath) {
      fields.add(MapEntry('biliCSRF', csrf));
    }
    return fields;
  }

  // ── Token Refresh ──

  Future<void> _ensureCookieRefreshed() async {
    await (_refreshCookieFuture ??= _ref
        .read(sessionCookieRefresherProvider)
        .refreshCookies()
        .whenComplete(() {
          _refreshCookieFuture = null;
          _cachedCsrf = null;
        }));
  }
}
