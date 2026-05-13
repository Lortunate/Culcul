import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CsrfInterceptor extends Interceptor {
  static final String _passportHost = Uri.parse(ApiConstants.passportBaseUrl).host;
  static const String _logoutPath = '/login/exit/v2';

  final Ref _ref;

  /// Cached CSRF token — avoids cookie jar lookups on every request.
  /// Invalidated when a -101 auth error is detected (handled by TokenInterceptor).
  String? _cachedCsrf;

  CsrfInterceptor(this._ref);

  /// Called by TokenInterceptor after cookie refresh to invalidate stale cache.
  void invalidateCsrfCache() {
    _cachedCsrf = null;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.headers.containsKey('x-bili-csrf')) {
      handler.next(options);
      return;
    }

    options.headers.remove('x-bili-csrf');

    try {
      final csrf = await _resolveCsrf(options);
      _injectCsrf(options, csrf);
      handler.next(options);
    } on AuthAppError catch (error) {
      handler.reject(DioException(requestOptions: options, error: error));
    }
  }

  Future<String> _resolveCsrf(RequestOptions options) async {
    // Fast path: use cached token
    if (_cachedCsrf != null) {
      return _cachedCsrf!;
    }

    // Try from request cookie header first (no async needed)
    final fromHeader = _extractCsrfFromCookieHeader(
      options.headers['cookie'] ?? options.headers['Cookie'],
    );
    if (fromHeader != null) {
      _cachedCsrf = fromHeader;
      return fromHeader;
    }

    // Fallback: query cookie jar
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
      if (!trimmed.startsWith('bili_jct=')) {
        continue;
      }
      final value = trimmed.substring('bili_jct='.length);
      if (value.isNotEmpty) {
        return value;
      }
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
    if (_isPassportLogoutRequest(uri)) {
      fields.add(MapEntry('biliCSRF', csrf));
    }
    return fields;
  }

  bool _isPassportLogoutRequest(Uri uri) {
    return uri.host == _passportHost && uri.path == _logoutPath;
  }
}
