import 'dart:convert';

import 'package:crypto/crypto.dart';

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

class WbiSigner {
  const WbiSigner();

  Map<String, dynamic> sign({
    required Map<String, dynamic> params,
    required String imgKey,
    required String subKey,
  }) {
    final mixinKey = _getMixinKey(imgKey + subKey);
    final currTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final newParams = Map<String, dynamic>.from(params)
      ..remove('wts')
      ..remove('w_rid');
    newParams['wts'] = currTime;

    final sortedKeys = newParams.keys.toList()..sort();
    final queryList = <String>[];

    for (final key in sortedKeys) {
      final value = newParams[key];
      if (value == null) continue;

      final valStr = value.toString().replaceAll(RegExp(r"[!'()*]"), '');
      newParams[key] = valStr;
      queryList.add('$key=${Uri.encodeComponent(valStr)}');
    }

    final query = queryList.join('&');
    final wbiSign = md5.convert(utf8.encode(query + mixinKey)).toString();

    newParams['w_rid'] = wbiSign;
    return newParams;
  }

  String _getMixinKey(String orig) {
    final buffer = StringBuffer();
    for (final index in _mixinKeyEncTab) {
      if (index < orig.length) {
        buffer.write(orig[index]);
      }
    }
    return buffer.toString().substring(0, 32);
  }
}
