// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _LiveApi implements LiveApi {
  _LiveApi(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://api.live.bilibili.com';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiResponse<LiveRoomDetailModel>> getRoomInfo(int roomId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'room_id': roomId};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LiveRoomDetailModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/room/v1/Room/get_info',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LiveRoomDetailModel> _value;
    try {
      _value = ApiResponse<LiveRoomDetailModel>.fromJson(
        _result.data!,
        (json) => LiveRoomDetailModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LivePlayUrlModel>> getPlayUrl({
    required int roomId,
    int? qn,
    String? platform,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'cid': roomId,
      r'qn': qn,
      r'platform': platform,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LivePlayUrlModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/room/v1/Room/playUrl',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LivePlayUrlModel> _value;
    try {
      _value = ApiResponse<LivePlayUrlModel>.fromJson(
        _result.data!,
        (json) => LivePlayUrlModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LiveDanmakuConfigModel>> getDanmakuConfig(
    int roomId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'room_id': roomId};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LiveDanmakuConfigModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/xlive/web-room/v1/dM/GetDMConfigByGroup',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LiveDanmakuConfigModel> _value;
    try {
      _value = ApiResponse<LiveDanmakuConfigModel>.fromJson(
        _result.data!,
        (json) => LiveDanmakuConfigModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LiveHistoryDanmakuModel>> getHistoryDanmaku(
    int roomId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'roomid': roomId};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LiveHistoryDanmakuModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/xlive/web-room/v1/dM/gethistory',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LiveHistoryDanmakuModel> _value;
    try {
      _value = ApiResponse<LiveHistoryDanmakuModel>.fromJson(
        _result.data!,
        (json) =>
            LiveHistoryDanmakuModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LiveDanmuInfoModel>> getDanmuInfo(
    int roomId,
    int type,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': roomId, r'type': type};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LiveDanmuInfoModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/xlive/web-room/v1/index/getDanmuInfo',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LiveDanmuInfoModel> _value;
    try {
      _value = ApiResponse<LiveDanmuInfoModel>.fromJson(
        _result.data!,
        (json) => LiveDanmuInfoModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LiveRecommendResponse>> getRecommendList({
    String platform = 'web',
    String? webLocation,
    int page = 1,
    int pageSize = 30,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'platform': platform,
      r'web_location': webLocation,
      r'page': page,
      r'page_size': pageSize,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LiveRecommendResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/xlive/web-interface/v1/webMain/getMoreRecList',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LiveRecommendResponse> _value;
    try {
      _value = ApiResponse<LiveRecommendResponse>.fromJson(
        _result.data!,
        (json) => LiveRecommendResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LiveAnchorInfoModel>> getAnchorInfo(int uid) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'uid': uid};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LiveAnchorInfoModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/live_user/v1/Master/info',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LiveAnchorInfoModel> _value;
    try {
      _value = ApiResponse<LiveAnchorInfoModel>.fromJson(
        _result.data!,
        (json) => LiveAnchorInfoModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LiveGoldRankModel>> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'ruid': ruid,
      r'roomId': roomId,
      r'page': page,
      r'pageSize': pageSize,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LiveGoldRankModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/xlive/general-interface/v1/rank/getOnlineGoldRank',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LiveGoldRankModel> _value;
    try {
      _value = ApiResponse<LiveGoldRankModel>.fromJson(
        _result.data!,
        (json) => LiveGoldRankModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LiveGuardListModel>> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'ruid': ruid,
      r'roomid': roomId,
      r'page': page,
      r'page_size': pageSize,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LiveGuardListModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/xlive/app-room/v2/guardTab/topListNew',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LiveGuardListModel> _value;
    try {
      _value = ApiResponse<LiveGuardListModel>.fromJson(
        _result.data!,
        (json) => LiveGuardListModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<void>> sendDanmaku({
    required String msg,
    required int roomId,
    required int rnd,
    int color = 16777215,
    int fontsize = 25,
    int mode = 1,
    int bubble = 0,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'x-bili-csrf': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'msg': msg,
      'roomid': roomId,
      'rnd': rnd,
      'color': color,
      'fontsize': fontsize,
      'mode': mode,
      'bubble': bubble,
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
            '/msg/send',
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
