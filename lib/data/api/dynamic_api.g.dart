// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _DynamicApi implements DynamicApi {
  _DynamicApi(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiResponse<DynamicData>> getDynamicFeed({
    String type = 'all',
    String? offset,
    int timezoneOffset = -480,
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
    int page = 1,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'offset': offset,
      r'timezone_offset': timezoneOffset,
      r'features': features,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<DynamicData>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/polymer/web-dynamic/v1/feed/all',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<DynamicData> _value;
    try {
      _value = ApiResponse<DynamicData>.fromJson(
        _result.data!,
        (json) => DynamicData.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<DynamicData>> getSpaceDynamicFeed({
    required int hostMid,
    String? offset,
    int timezoneOffset = -480,
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'host_mid': hostMid,
      r'offset': offset,
      r'timezone_offset': timezoneOffset,
      r'features': features,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<DynamicData>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/polymer/web-dynamic/v1/feed/space',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<DynamicData> _value;
    try {
      _value = ApiResponse<DynamicData>.fromJson(
        _result.data!,
        (json) => DynamicData.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<DynamicData>> getTopicFeed({
    required int topicId,
    String? offset,
    int sortBy = 0,
    int pageSize = 20,
    int timezoneOffset = -480,
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'topic_id': topicId,
      r'offset': offset,
      r'sort_by': sortBy,
      r'page_size': pageSize,
      r'timezone_offset': timezoneOffset,
      r'features': features,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<DynamicData>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/polymer/web-dynamic/v1/feed/topic',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<DynamicData> _value;
    try {
      _value = ApiResponse<DynamicData>.fromJson(
        _result.data!,
        (json) => DynamicData.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<CommentResponse>> getComments({
    required int oid,
    required int type,
    int sort = 1,
    int pn = 1,
    int ps = 20,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'oid': oid,
      r'type': type,
      r'sort': sort,
      r'pn': pn,
      r'ps': ps,
    };
    final _headers = <String, dynamic>{};
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
  Future<ApiResponse<CommentItem>> addReply({
    required int oid,
    required int root,
    required int parent,
    required String message,
    required int type,
  }) async {
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
  Future<ApiResponse<void>> actionComment({
    required int oid,
    required int rpid,
    required int action,
    required int type,
  }) async {
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
  Future<ApiResponse<DynamicDetailData>> getDynamicDetail({
    required String id,
    String features =
        'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete,onlyfansQaCard,commentsNewVersion',
    int timezoneOffset = -480,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'features': features,
      r'timezone_offset': timezoneOffset,
    };
    final _headers = <String, dynamic>{r'x-bili-wbi': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<DynamicDetailData>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/polymer/web-dynamic/v1/detail',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<DynamicDetailData> _value;
    try {
      _value = ApiResponse<DynamicDetailData>.fromJson(
        _result.data!,
        (json) => DynamicDetailData.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<void>> likeDynamic({
    required Map<String, dynamic> body,
    required String csrf,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'csrf': csrf};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<ApiResponse<void>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/dynamic/feed/dyn/thumb',
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
  Future<ApiResponse<DynamicPublishData>> createDynamic({
    required String csrf,
    required Map<String, dynamic> body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'csrf': csrf};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<ApiResponse<DynamicPublishData>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/x/dynamic/feed/create/dyn',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<DynamicPublishData> _value;
    try {
      _value = ApiResponse<DynamicPublishData>.fromJson(
        _result.data!,
        (json) => DynamicPublishData.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<DynamicUploadImageData>> uploadImage({
    required File file,
    String category = 'daily',
    required String csrf,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(
      MapEntry(
        'file_up',
        MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split(Platform.pathSeparator).last,
        ),
      ),
    );
    _data.fields.add(MapEntry('category', category));
    _data.fields.add(MapEntry('csrf', csrf));
    final _options = _setStreamType<ApiResponse<DynamicUploadImageData>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            '/x/dynamic/feed/draw/upload_bfs',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<DynamicUploadImageData> _value;
    try {
      _value = ApiResponse<DynamicUploadImageData>.fromJson(
        _result.data!,
        (json) => DynamicUploadImageData.fromJson(json as Map<String, dynamic>),
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
