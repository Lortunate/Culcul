import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BiliAccelerationInterceptor extends Interceptor {
  BiliAccelerationInterceptor(this._ref);

  final Ref _ref;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final currentState = _ref.read(bilibiliAccelerationControllerProvider);
    final activePreset = biliPresetById(currentState.activePresetId);
    final originalUri = options.uri;
    final rewrittenUri = rewriteUriWithPreset(originalUri, activePreset);

    if (rewrittenUri == originalUri) {
      handler.next(options);
      return;
    }

    if (_isAbsoluteUrl(options.path)) {
      options.path = rewrittenUri.toString();
    } else {
      final authority = rewrittenUri.hasPort
          ? '${rewrittenUri.host}:${rewrittenUri.port}'
          : rewrittenUri.host;
      options.baseUrl = '${rewrittenUri.scheme}://$authority';
    }

    options.extra['bili_acceleration_preset'] = activePreset.id;
    handler.next(options);
  }

  bool _isAbsoluteUrl(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }
}
