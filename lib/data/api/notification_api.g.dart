// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _NotificationApi implements NotificationApi {
  _NotificationApi(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApiResponse<ImageUploadResponse>> uploadImage({
    required File file,
    String biz = 'draw',
    String category = 'daily',
    int build = 0,
    String mobiApp = 'web',
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
    _data.fields.add(MapEntry('biz', biz));
    _data.fields.add(MapEntry('category', category));
    _data.fields.add(MapEntry('build', build.toString()));
    _data.fields.add(MapEntry('mobi_app', mobiApp));
    final _options = _setStreamType<ApiResponse<ImageUploadResponse>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            'https://api.vc.bilibili.com/api/v1/drawImage/upload',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<ImageUploadResponse> _value;
    try {
      _value = ApiResponse<ImageUploadResponse>.fromJson(
        _result.data!,
        (json) => ImageUploadResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<UnreadCountModel>> getUnreadCount() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<UnreadCountModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.bilibili.com/x/msgfeed/unread',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<UnreadCountModel> _value;
    try {
      _value = ApiResponse<UnreadCountModel>.fromJson(
        _result.data!,
        (json) => UnreadCountModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<ReplyResponse>> getReplyList({
    int? id,
    int? replyTime,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'reply_time': replyTime,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<ReplyResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.bilibili.com/x/msgfeed/reply',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<ReplyResponse> _value;
    try {
      _value = ApiResponse<ReplyResponse>.fromJson(
        _result.data!,
        (json) => ReplyResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<ReplyResponse>> getAtList({int? id, int? atTime}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id, r'at_time': atTime};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<ReplyResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.bilibili.com/x/msgfeed/at',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<ReplyResponse> _value;
    try {
      _value = ApiResponse<ReplyResponse>.fromJson(
        _result.data!,
        (json) => ReplyResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<LikeResponse>> getLikeList({
    int? id,
    int? likeTime,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'id': id,
      r'like_time': likeTime,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<LikeResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.bilibili.com/x/msgfeed/like',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<LikeResponse> _value;
    try {
      _value = ApiResponse<LikeResponse>.fromJson(
        _result.data!,
        (json) => LikeResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<PrivateMessageSessionResponse>> getPrivateSessions({
    int sessionType = 1,
    int size = 20,
    int? endTs,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'session_type': sessionType,
      r'size': size,
      r'end_ts': endTs,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<PrivateMessageSessionResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.vc.bilibili.com/session_svr/v1/session_svr/get_sessions',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<PrivateMessageSessionResponse> _value;
    try {
      _value = ApiResponse<PrivateMessageSessionResponse>.fromJson(
        _result.data!,
        (json) => PrivateMessageSessionResponse.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<PrivateMessageListResponse>> getPrivateMessages({
    required int talkerId,
    int sessionType = 1,
    int size = 20,
    int? beginSeqno,
    int? endSeqno,
    int senderDeviceId = 1,
    int build = 0,
    String mobiApp = 'web',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'talker_id': talkerId,
      r'session_type': sessionType,
      r'size': size,
      r'begin_seqno': beginSeqno,
      r'end_seqno': endSeqno,
      r'sender_device_id': senderDeviceId,
      r'build': build,
      r'mobi_app': mobiApp,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<ApiResponse<PrivateMessageListResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'https://api.vc.bilibili.com/svr_sync/v1/svr_sync/fetch_session_msgs',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<PrivateMessageListResponse> _value;
    try {
      _value = ApiResponse<PrivateMessageListResponse>.fromJson(
        _result.data!,
        (json) =>
            PrivateMessageListResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ApiResponse<SendMessageResponse>> sendPrivateMessage({
    required int wSenderUid,
    required int wReceiverId,
    required String wDevId,
    required int senderUid,
    required int receiverId,
    required int receiverType,
    required int msgType,
    required String devId,
    required int timestamp,
    required String content,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'w_sender_uid': wSenderUid,
      r'w_receiver_id': wReceiverId,
      r'w_dev_id': wDevId,
    };
    final _headers = <String, dynamic>{
      r'x-bili-wbi': 'true',
      r'x-bili-csrf': 'true',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'msg[sender_uid]': senderUid,
      'msg[receiver_id]': receiverId,
      'msg[receiver_type]': receiverType,
      'msg[msg_type]': msgType,
      'msg[dev_id]': devId,
      'msg[timestamp]': timestamp,
      'msg[content]': content,
    };
    final _options = _setStreamType<ApiResponse<SendMessageResponse>>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
          )
          .compose(
            _dio.options,
            'https://api.vc.bilibili.com/web_im/v1/web_im/send_msg',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<SendMessageResponse> _value;
    try {
      _value = ApiResponse<SendMessageResponse>.fromJson(
        _result.data!,
        (json) => SendMessageResponse.fromJson(json as Map<String, dynamic>),
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
