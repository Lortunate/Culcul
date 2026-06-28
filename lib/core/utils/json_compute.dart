import 'dart:convert';

import 'package:flutter/foundation.dart';

const int _isolateDecodeThresholdChars = 16 * 1024;

/// Decode JSON in a separate isolate to avoid jank on the UI thread.
Future<dynamic> jsonDecodeCompute(String text) async {
  if (text.length <= _isolateDecodeThresholdChars) {
    return jsonDecode(text);
  }
  return compute(jsonDecode, text);
}
