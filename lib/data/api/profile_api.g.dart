// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _ProfileApi implements ProfileApi {
  _ProfileApi(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://api.bilibili.com';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiResponse<dynamic>> getAccountInfo(int mid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'mid': mid};
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/space/wbi/acc/info',
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
  Future<ApiResponse<UserSpaceVideoListResponse>> getSpaceVideos({
    required int mid,
    int page = 1,
    int pageSize = 30,
    String order = 'pubdate',
    String? keyword,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'mid': mid,
      r'pn': page,
      r'ps': pageSize,
      r'order': order,
      r'keyword': keyword,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<UserSpaceVideoListResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/space/wbi/arc/search',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<UserSpaceVideoListResponse> _value;
    try {
      _value = ApiResponse<UserSpaceVideoListResponse>.fromJson(
        _result.data!,
        (json) =>
            UserSpaceVideoListResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<UserSpaceVideoModel>> getStickyVideo(int vmid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'vmid': vmid};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<UserSpaceVideoModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/space/top/arc',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<UserSpaceVideoModel> _value;
    try {
      _value = ApiResponse<UserSpaceVideoModel>.fromJson(
        _result.data!,
        (json) => UserSpaceVideoModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<List<UserSpaceVideoModel>>> getMasterpiece(
    int vmid,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'vmid': vmid};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<List<UserSpaceVideoModel>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/space/masterpiece',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<List<UserSpaceVideoModel>> _value;
    try {
      _value = ApiResponse<List<UserSpaceVideoModel>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<UserSpaceVideoModel>(
                    (i) =>
                        UserSpaceVideoModel.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<dynamic>> getRelationStat(int vmid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'vmid': vmid};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/relation/stat',
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
  Future<ApiResponse<dynamic>> getUpStat(int mid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'mid': mid};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/space/upstat',
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
  Future<ApiResponse<dynamic>> getNavNum(int mid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'mid': mid};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/space/navnum',
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
  Future<ApiResponse<dynamic>> getCard(int mid, {bool photo = true}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'mid': mid, r'photo': photo};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/web-interface/card',
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
  Future<ApiResponse<dynamic>> getNav() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/web-interface/nav',
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
  Future<ApiResponse<dynamic>> modifyRelation(
    int fid,
    int act,
    int reSrc,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-bili-csrf': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'fid': fid, 'act': act, 're_src': reSrc};
    final _options = _setStreamType<ApiResponse<dynamic>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/relation/modify',
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
