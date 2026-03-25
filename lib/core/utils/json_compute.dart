import 'dart:convert';

import 'package:flutter/foundation.dart';

/// Decode JSON in a separate isolate to avoid jank on the UI thread.
Future<dynamic> jsonDecodeCompute(String text) async {
  return compute(_parseAndDecode, text);
}

dynamic _parseAndDecode(String encoded) {
  return jsonDecode(encoded);
}

