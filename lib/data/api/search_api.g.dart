// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _SearchApi implements SearchApi {
  _SearchApi(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://s.search.bilibili.com';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<String> fetchSearchSuggestions(
    String term, {
    String mainVer = 'v1',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'term': term,
      r'main_ver': mainVer,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<String>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/main/suggest',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<String>(_options);
    late String _value;
    try {
      _value = _result.data!;
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<DefaultSearchData>> fetchDefaultSearch() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<DefaultSearchData>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.bilibili.com/x/web-interface/wbi/search/default',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<DefaultSearchData> _value;
    try {
      _value = ApiResponse<DefaultSearchData>.fromJson(
        _result.data!,
        (json) => DefaultSearchData.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<TrendingRankingResponse> fetchTrendingRanking() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<TrendingRankingResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://app.bilibili.com/x/v2/search/trending/ranking',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late TrendingRankingResponse _value;
    try {
      _value = TrendingRankingResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<SearchResultResponse> fetchSearchAll({
    required String keyword,
    int page = 1,
    int pageSize = 20,
    String searchType = 'all',
    String order = 'totalrank',
    int duration = 0,
    int? tids,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keyword': keyword,
      r'page': page,
      r'page_size': pageSize,
      r'search_type': searchType,
      r'order': order,
      r'duration': duration,
      r'tids': tids,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<SearchResultResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.bilibili.com/x/web-interface/wbi/search/all/v2',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late SearchResultResponse _value;
    try {
      _value = SearchResultResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<SearchResultResponse> fetchSearchByType({
    required String keyword,
    int page = 1,
    int pageSize = 20,
    String searchType = 'video',
    String order = 'totalrank',
    int duration = 0,
    int? tids,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keyword': keyword,
      r'page': page,
      r'page_size': pageSize,
      r'search_type': searchType,
      r'order': order,
      r'duration': duration,
      r'tids': tids,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<SearchResultResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.bilibili.com/x/web-interface/wbi/search/type',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late SearchResultResponse _value;
    try {
      _value = SearchResultResponse.fromJson(_result.data!);
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
