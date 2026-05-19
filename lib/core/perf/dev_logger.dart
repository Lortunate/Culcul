import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Unified development-only logger for performance and flow tracing.
///
/// All output is suppressed in release builds. Use [category] to group
/// related events (e.g. 'network', 'video', 'startup', 'feature', 'list').
class DevLogger {
  DevLogger._();

  static void log(String category, String event, [Map<String, Object?>? fields]) {
    if (!kDebugMode && !kProfileMode) return;
    final buffer = StringBuffer(event);
    if (fields != null) {
      for (final entry in fields.entries) {
        if (entry.value != null) {
          buffer.write(' ${entry.key}=${entry.value}');
        }
      }
    }
    developer.log(buffer.toString(), name: category);
  }
}
