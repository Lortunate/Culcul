// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _FavApi implements FavApi {
  _FavApi(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://api.bilibili.com';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiResponse<Object>> getCreatedFolders(
    int upMid, {
    int? rid,
    int? type,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'up_mid': upMid,
      r'rid': rid,
      r'type': type,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<Object>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/v3/fav/folder/created/list-all',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<Object> _value;
    try {
      _value = ApiResponse<Object>.fromJson(
        _result.data!,
        (json) => json as Object,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<Object>> getCollectedFolders(
    int upMid,
    int pn,
    int ps,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'up_mid': upMid,
      r'pn': pn,
      r'ps': ps,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<Object>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/v3/fav/folder/collected/list',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<Object> _value;
    try {
      _value = ApiResponse<Object>.fromJson(
        _result.data!,
        (json) => json as Object,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<Object>> getFolderResources(
    int mediaId,
    int pn,
    int ps, {
    String? keyword,
    String? order,
    int? type,
    int? tid,
    String platform = 'web',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'media_id': mediaId,
      r'pn': pn,
      r'ps': ps,
      r'keyword': keyword,
      r'order': order,
      r'type': type,
      r'tid': tid,
      r'platform': platform,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<Object>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/v3/fav/resource/list',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<Object> _value;
    try {
      _value = ApiResponse<Object>.fromJson(
        _result.data!,
        (json) => json as Object,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<FavoriteFolder>> addFolder(
    String title, {
    String? intro,
    int? privacy,
    String? cover,
    String? csrf,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'title': title,
      'intro': intro,
      'privacy': privacy,
      'cover': cover,
      'csrf': csrf,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiResponse<FavoriteFolder>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v3/fav/folder/add',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<FavoriteFolder> _value;
    try {
      _value = ApiResponse<FavoriteFolder>.fromJson(
        _result.data!,
        (json) => FavoriteFolder.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<FavoriteFolder>> editFolder(
    int mediaId,
    String title, {
    String? intro,
    int? privacy,
    String? cover,
    String? csrf,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'media_id': mediaId,
      'title': title,
      'intro': intro,
      'privacy': privacy,
      'cover': cover,
      'csrf': csrf,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiResponse<FavoriteFolder>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v3/fav/folder/edit',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<FavoriteFolder> _value;
    try {
      _value = ApiResponse<FavoriteFolder>.fromJson(
        _result.data!,
        (json) => FavoriteFolder.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<dynamic>> delFolder(
    String mediaIds, {
    String? csrf,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'media_ids': mediaIds, 'csrf': csrf};
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v3/fav/folder/del',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<dynamic> _value;
    try {
      _value = ApiResponse<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<dynamic>> dealResource(
    int rid,
    int type, {
    String? addMediaIds,
    String? delMediaIds,
    String platform = 'web',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-csrf': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'rid': rid,
      'type': type,
      'add_media_ids': addMediaIds,
      'del_media_ids': delMediaIds,
      'platform': platform,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v3/fav/resource/deal',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<dynamic> _value;
    try {
      _value = ApiResponse<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<dynamic>> batchDelResource(
    String resources,
    int mediaId, {
    String platform = 'web',
    String? csrf,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'resources': resources,
      'media_id': mediaId,
      'platform': platform,
      'csrf': csrf,
    };
    _data.removeWhere((k, v) => v == null);
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v3/fav/resource/batch-del',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<dynamic> _value;
    try {
      _value = ApiResponse<dynamic>.fromJson(
        _result.data!,
        (json) => json as dynamic,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
