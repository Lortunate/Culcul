import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

enum NetworkPerfEvent { queueWait, taskSuccess, taskFailure, taskFallback, groupComplete }

extension on NetworkPerfEvent {
  String get value => switch (this) {
    NetworkPerfEvent.queueWait => 'queue_wait',
    NetworkPerfEvent.taskSuccess => 'task_success',
    NetworkPerfEvent.taskFailure => 'task_failure',
    NetworkPerfEvent.taskFallback => 'task_fallback',
    NetworkPerfEvent.groupComplete => 'group_complete',
  };
}

class NetworkPerfLogger {
  NetworkPerfLogger._();

  static const String _loggerName = 'network.performance';

  static void log(
    NetworkPerfEvent event, {
    Map<String, Object?> fields = const <String, Object?>{},
  }) {
    if (!kDebugMode && !kProfileMode) {
      return;
    }

    final payload = StringBuffer('network_perf ${event.value}');
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
