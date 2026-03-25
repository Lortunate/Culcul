import 'dart:math';

class IdUtils {
  static const String _table =
      'fZodR9XQDSUm21yCkr6zBqiveYah8bt4xsWpHnJE7jL5VG3guMTKNPAwcF';
  static final Map<String, int> _tr = {};
  static final List<int> _s = [11, 10, 3, 8, 4, 6];
  static const int _xor = 177451812;
  static const int _add = 8728348608;

  static void _init() {
    if (_tr.isNotEmpty) return;
    for (int i = 0; i < 58; i++) {
      _tr[_table[i]] = i;
    }
  }

  static int bv2av(String bvid) {
    _init();
    int r = 0;
    if (bvid.length < 12) {
      if (!bvid.startsWith('BV')) {
        bvid = 'BV$bvid';
      }
    }

    if (bvid.length != 12) {
      return 0;
    }

    for (int i = 0; i < 6; i++) {
      r += _tr[bvid[_s[i]]]! * pow(58, i).toInt();
    }
    return (r - _add) ^ _xor;
  }
}

