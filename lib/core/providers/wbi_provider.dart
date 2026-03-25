import 'dart:async';
import 'dart:convert';

import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/api/resource_api.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Mixin key encoding table
const _mixinKeyEncTab = [
  46,
  47,
  18,
  2,
  53,
  8,
  23,
  32,
  15,
  50,
  10,
  31,
  58,
  3,
  45,
  35,
  27,
  43,
  5,
  49,
  33,
  9,
  42,
  19,
  29,
  28,
  14,
  39,
  12,
  38,
  41,
  13,
  37,
  48,
  7,
  16,
  24,
  55,
  40,
  61,
  26,
  17,
  0,
  1,
  60,
  51,
  30,
  4,
  22,
  25,
  54,
  21,
  56,
  59,
  6,
  63,
  57,
  62,
  11,
  36,
  20,
  34,
  44,
  52,
];

class WbiHelper {
  final ResourceApi _resourceApi;
  String? _imgKey;
  String? _subKey;
  DateTime? _lastUpdate;
  Completer<void>? _updateCompleter;

  WbiHelper(this._resourceApi);

  Future<void> updateKeys() async {
    // Check if keys are valid (less than 1 hour old)
    if (_imgKey != null && _subKey != null && _lastUpdate != null) {
      final now = DateTime.now();
      if (now.difference(_lastUpdate!).inHours < 1) {
        return;
      }
    }

    if (_updateCompleter != null) {
      return _updateCompleter!.future;
    }

    _updateCompleter = Completer<void>();

    try {
      final response = await _resourceApi.fetchNav();
      final data = Map<String, dynamic>.from(response as Map);

      // Check for API error code
      if (data['code'] != 0) {
        debugPrint('Nav API error: code=${data['code']}, message=${data['message']}');
        // If risk control (-352), we might need to handle it or use fallback
        if (data['code'] == -352) {
          throw Exception('Nav API risk control (-352)');
        }
      }

      if (data['data'] == null) {
        throw Exception('Nav response data is null: $data');
      }

      final navData = data['data'];
      final wbiImg = navData['wbi_img'];
      if (wbiImg == null) {
        throw Exception('wbi_img is null in nav data');
      }

      final imgUrl = wbiImg['img_url'] as String?;
      final subUrl = wbiImg['sub_url'] as String?;

      if (imgUrl == null || subUrl == null) {
        throw Exception('img_url or sub_url is null');
      }

      _imgKey = imgUrl.split('/').last.split('.').first;
      _subKey = subUrl.split('/').last.split('.').first;
      _lastUpdate = DateTime.now();
      debugPrint('Wbi keys updated successfully: $_imgKey, $_subKey');
      _updateCompleter?.complete();
    } catch (e) {
      debugPrint('Wbi updateKeys failed: $e');
      _imgKey = null;
      _subKey = null;
      _updateCompleter?.completeError(e);
      rethrow;
    } finally {
      _updateCompleter = null;
    }
  }

  String _getMixinKey(String orig) {
    String temp = '';
    for (var i = 0; i < _mixinKeyEncTab.length; i++) {
      if (_mixinKeyEncTab[i] < orig.length) {
        temp += orig[_mixinKeyEncTab[i]];
      }
    }
    return temp.substring(0, 32);
  }

  Map<String, dynamic> sign(Map<String, dynamic> params) {
    if (_imgKey == null || _subKey == null) {
      // If keys update failed, we can't sign properly.
      // Return params as is? Or throw?
      // WbiInterceptor catches exception.
      throw Exception('WBI keys not initialized');
    }

    final mixinKey = _getMixinKey(_imgKey! + _subKey!);
    final currTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final newParams = Map<String, dynamic>.from(params);
    newParams['wts'] = currTime;

    final sortedKeys = newParams.keys.toList()..sort();
    final queryList = <String>[];

    for (final key in sortedKeys) {
      final value = newParams[key];
      if (value == null) continue;

      String valStr = value.toString();
      // Remove specific characters: !'()*
      valStr = valStr.replaceAll(RegExp(r"[!'()*]"), '');

      newParams[key] = valStr;
      queryList.add('$key=${Uri.encodeComponent(valStr)}');
    }

    final query = queryList.join('&');
    final wbiSign = md5.convert(utf8.encode(query + mixinKey)).toString();

    newParams['w_rid'] = wbiSign;
    return newParams;
  }
}

final wbiHelperProvider = Provider<WbiHelper>((ref) {
  return WbiHelper(ref.watch(basicResourceApiProvider));
});

