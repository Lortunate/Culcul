import 'dart:convert';
import 'package:cilixili/core/constants/api_constants.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class WbiHelper {
  static const _mixinKeyEncTab = [
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

  String? _imgKey;
  String? _subKey;
  DateTime? _lastUpdateTime;

  Future<void> updateKeys(Dio dio) async {
    // Cache valid for 24 hours
    if (_imgKey != null &&
        _subKey != null &&
        _lastUpdateTime != null &&
        DateTime.now().difference(_lastUpdateTime!).inHours < 24) {
      return;
    }

    try {
      final response = await dio.get(ApiConstants.nav);
      final data = response.data['data'];
      if (data != null && data['wbi_img'] != null) {
        final wbiImg = data['wbi_img'];
        final imgUrl = wbiImg['img_url'] as String;
        final subUrl = wbiImg['sub_url'] as String;

        _imgKey = imgUrl.split('/').last.split('.').first;
        _subKey = subUrl.split('/').last.split('.').first;
        _lastUpdateTime = DateTime.now();
      }
    } catch (e) {
      // Silent error
    }
  }

  String _getMixinKey(String orig) {
    String temp = '';
    for (var i in _mixinKeyEncTab) {
      if (i < orig.length) {
        temp += orig[i];
      }
    }
    return temp.substring(0, 32);
  }

  Map<String, dynamic> sign(Map<String, dynamic> params) {
    if (_imgKey == null || _subKey == null) {
      return params;
    }

    final mixinKey = _getMixinKey(_imgKey! + _subKey!);
    final currTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final newParams = Map<String, dynamic>.from(params);
    newParams['wts'] = currTime;

    final sortedKeys = newParams.keys.toList()..sort();

    final queryList = <String>[];
    for (var key in sortedKeys) {
      final value = newParams[key];
      if (value != null) {
        queryList.add(
          '${Uri.encodeComponent(key)}=${Uri.encodeComponent(value.toString())}',
        );
      }
    }

    final queryString = queryList.join('&');
    final stringToSign = queryString + mixinKey;
    final wRid = md5.convert(utf8.encode(stringToSign)).toString();

    newParams['w_rid'] = wRid;
    return newParams;
  }
}
