import 'dart:async';

import 'package:culcul/core/data/network/resource_api.dart';
import 'package:culcul/core/data/network/resource_api_provider.dart';
import 'package:culcul/core/data/network/providers/wbi_signer.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wbi_helper_provider.g.dart';

class WbiHelper {
  static const _keyTtl = Duration(hours: 1);
  static const _signer = WbiSigner();

  final ResourceApi _resourceApi;
  String? _imgKey;
  String? _subKey;
  DateTime? _lastUpdate;
  Completer<void>? _updateCompleter;

  WbiHelper(this._resourceApi);

  /// Synchronous check — avoids await overhead when keys are fresh.
  bool get areKeysFresh {
    if (_imgKey == null || _subKey == null || _lastUpdate == null) return false;
    return DateTime.now().difference(_lastUpdate!) < _keyTtl;
  }

  Future<void> updateKeys() async {
    if (areKeysFresh) return;

    if (_updateCompleter != null) {
      return _updateCompleter!.future;
    }

    _updateCompleter = Completer<void>();

    try {
      final response = await _resourceApi.fetchNav();
      final data = Map<String, dynamic>.from(response as Map);

      if (data['code'] != 0) {
        if (kDebugMode) {
          debugPrint('Nav API error: code=${data['code']}, message=${data['message']}');
        }
        if (data['code'] == -352) {
          throw const AppError.data('Nav API risk control (-352)', code: -352);
        }
      }

      if (data['data'] == null) {
        throw AppError.data('Nav response data is null: $data');
      }

      final navData = data['data'];
      final wbiImg = navData['wbi_img'];
      if (wbiImg == null) {
        throw const AppError.data('wbi_img is null in nav data');
      }

      final imgUrl = wbiImg['img_url'] as String?;
      final subUrl = wbiImg['sub_url'] as String?;

      if (imgUrl == null || subUrl == null) {
        throw const AppError.data('img_url or sub_url is null');
      }

      _imgKey = imgUrl.split('/').last.split('.').first;
      _subKey = subUrl.split('/').last.split('.').first;
      _lastUpdate = DateTime.now();
      if (kDebugMode) {
        debugPrint('Wbi keys updated: $_imgKey, $_subKey');
      }
      _updateCompleter?.complete();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Wbi updateKeys failed: $e');
      }
      _imgKey = null;
      _subKey = null;
      _updateCompleter?.completeError(e);
      rethrow;
    } finally {
      _updateCompleter = null;
    }
  }

  Map<String, dynamic> sign(Map<String, dynamic> params) {
    if (_imgKey == null || _subKey == null) {
      // If keys update failed, we can't sign properly.
      // Return params as is? Or throw?
      // WbiInterceptor catches exception.
      throw const AppError.data('WBI keys not initialized');
    }

    return _signer.sign(params: params, imgKey: _imgKey!, subKey: _subKey!);
  }
}

@Riverpod(keepAlive: true)
WbiHelper wbiHelper(Ref ref) {
  return WbiHelper(ref.watch(basicResourceApiProvider));
}
