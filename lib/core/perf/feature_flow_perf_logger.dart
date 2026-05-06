import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class FeatureFlowPerfLogger {
  FeatureFlowPerfLogger._();

  static const String _loggerName = 'feature.performance';

  static void log({
    required String chain,
    required String stage,
    Map<String, Object?> fields = const <String, Object?>{},
  }) {
    if (!kDebugMode && !kProfileMode) {
      return;
    }

    final payload = StringBuffer('feature_perf chain=$chain stage=$stage');
    for (final entry in fields.entries) {
      final value = entry.value;
      if (value == null) {
        continue;
      }
      payload.write(' ${entry.key}=$value');
    }
    developer.log(payload.toString(), name: _loggerName);
  }
}
