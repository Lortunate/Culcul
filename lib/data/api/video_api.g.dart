// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _VideoApi implements VideoApi {
  _VideoApi(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://api.bilibili.com';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiResponse<FeedResponse>> fetchRecommend({
    int freshType = 4,
    int ps = 20,
    int freshIdx = 1,
    int freshIdx1h = 1,
    bool? forceRefresh,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'fresh_type': freshType,
      r'ps': ps,
      r'fresh_idx': freshIdx,
      r'fresh_idx_1h': freshIdx1h,
      r'force_refresh': forceRefresh,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<FeedResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/web-interface/wbi/index/top/feed/rcmd',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<FeedResponse> _value;
    try {
      _value = ApiResponse<FeedResponse>.fromJson(
        _result.data!,
        (json) => FeedResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<PopularResponse>> fetchPopular({
    int pn = 1,
    int ps = 20,
    bool? forceRefresh,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pn': pn,
      r'ps': ps,
      r'force_refresh': forceRefresh,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<PopularResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/web-interface/popular',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<PopularResponse> _value;
    try {
      _value = ApiResponse<PopularResponse>.fromJson(
        _result.data!,
        (json) => PopularResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<VideoDetail>> fetchVideoView(String bvid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'bvid': bvid};
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<VideoDetail>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/web-interface/view',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<VideoDetail> _value;
    try {
      _value = ApiResponse<VideoDetail>.fromJson(
        _result.data!,
        (json) => VideoDetail.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<List<VideoTag>>> fetchVideoTags(String bvid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'bvid': bvid};
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<List<VideoTag>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/tag/archive/tags',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<List<VideoTag>> _value;
    try {
      _value = ApiResponse<List<VideoTag>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<VideoTag>(
                    (i) => VideoTag.fromJson(i as Map<String, dynamic>),
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
  Future<ApiResponse<PlayUrl>> fetchVideoPlayUrl(
    int aid,
    int cid,
    int qn,
    int fnval,
    int fnver,
    int fourk,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'avid': aid,
      r'cid': cid,
      r'qn': qn,
      r'fnval': fnval,
      r'fnver': fnver,
      r'fourk': fourk,
    };
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<PlayUrl>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/player/wbi/playurl',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<PlayUrl> _value;
    try {
      _value = ApiResponse<PlayUrl>.fromJson(
        _result.data!,
        (json) => PlayUrl.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<PlayerInfo>> fetchPlayerInfo(int aid, int cid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'aid': aid, r'cid': cid};
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<PlayerInfo>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/player/wbi/v2',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<PlayerInfo> _value;
    try {
      _value = ApiResponse<PlayerInfo>.fromJson(
        _result.data!,
        (json) => PlayerInfo.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<List<RelatedVideo>>> fetchRelatedVideos(
    String bvid,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'bvid': bvid};
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<List<RelatedVideo>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/web-interface/archive/related',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<List<RelatedVideo>> _value;
    try {
      _value = ApiResponse<List<RelatedVideo>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<RelatedVideo>(
                    (i) => RelatedVideo.fromJson(i as Map<String, dynamic>),
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
  Future<ApiResponse<CommentResponse>> fetchComments(
    int oid,
    int type,
    int sort,
    int ps,
    int pn,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'oid': oid,
      r'type': type,
      r'sort': sort,
      r'ps': ps,
      r'pn': pn,
    };
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<CommentResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/v2/reply',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<CommentResponse> _value;
    try {
      _value = ApiResponse<CommentResponse>.fromJson(
        _result.data!,
        (json) => CommentResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<CommentResponse>> fetchReply(
    int oid,
    int root,
    int type,
    int ps,
    int pn,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'oid': oid,
      r'root': root,
      r'type': type,
      r'ps': ps,
      r'pn': pn,
    };
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<CommentResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/v2/reply/reply',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<CommentResponse> _value;
    try {
      _value = ApiResponse<CommentResponse>.fromJson(
        _result.data!,
        (json) => CommentResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<void>> actionComment(
    int oid,
    int rpid,
    int action,
    int type,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-bili-csrf': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'oid': oid, 'rpid': rpid, 'action': action, 'type': type};
    final _options = _setStreamType<ApiResponse<void>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v2/reply/action',
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

  @override
  Future<ApiResponse<void>> hateComment(
    int oid,
    int rpid,
    int action,
    int type,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-bili-csrf': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'oid': oid, 'rpid': rpid, 'action': action, 'type': type};
    final _options = _setStreamType<ApiResponse<void>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v2/reply/hate',
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

  @override
  Future<ApiResponse<CommentItem>> addReply(
    int oid,
    int root,
    int parent,
    String message,
    int type,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-bili-csrf': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'oid': oid,
      'root': root,
      'parent': parent,
      'message': message,
      'type': type,
    };
    final _options = _setStreamType<ApiResponse<CommentItem>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v2/reply/add',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<CommentItem> _value;
    try {
      _value = ApiResponse<CommentItem>.fromJson(
        _result.data!,
        (json) => CommentItem.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<void>> reportVideoProgress(
    int aid,
    int cid,
    int progress,
    String platform,
    int type,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-bili-csrf': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'aid': aid,
      'cid': cid,
      'progress': progress,
      'platform': platform,
      'type': type,
    };
    final _options = _setStreamType<ApiResponse<void>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            '/x/v2/history/report',
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
