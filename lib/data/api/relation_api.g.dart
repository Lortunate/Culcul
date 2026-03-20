// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _RelationApi implements RelationApi {
  _RelationApi(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiResponse<RelationResponseData>> getFollowings(
    int vmid, {
    int pn = 1,
    int ps = 50,
    String? orderType,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'vmid': vmid,
      r'pn': pn,
      r'ps': ps,
      r'order_type': orderType,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<RelationResponseData>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/relation/followings',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<RelationResponseData> _value;
    try {
      _value = ApiResponse<RelationResponseData>.fromJson(
        _result.data!,
        (json) => RelationResponseData.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<RelationResponseData>> getFollowers(
    int vmid, {
    int pn = 1,
    int ps = 50,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'vmid': vmid,
      r'pn': pn,
      r'ps': ps,
    };
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<RelationResponseData>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/relation/followers',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<RelationResponseData> _value;
    try {
      _value = ApiResponse<RelationResponseData>.fromJson(
        _result.data!,
        (json) => RelationResponseData.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<void>> modifyRelation(
    int fid,
    int act, {
    int reSrc = 11,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': 'application/x-www-form-urlencoded',
      r'x-bili-csrf': 'true',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'fid': fid, 'act': act, 're_src': reSrc};
    final _options = _setStreamType<ApiResponse<void>>(
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
    late ApiResponse<void> _value;
    try {
      _value = ApiResponse<void>.fromJson(_result.data!, (json) => () {}());
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
