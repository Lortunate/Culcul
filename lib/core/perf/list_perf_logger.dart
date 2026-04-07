import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

enum ListPerfEvent { loadTrigger, loadComplete, dropUnknownSearchType }

extension on ListPerfEvent {
  String get value => switch (this) {
    ListPerfEvent.loadTrigger => 'load_trigger',
    ListPerfEvent.loadComplete => 'load_complete',
    ListPerfEvent.dropUnknownSearchType => 'drop_unknown_search_type',
  };
}

class ListPerfLogger {
  ListPerfLogger._();

  static const String _loggerName = 'list.performance';

  static void log(
    ListPerfEvent event, {
    Map<String, Object?> fields = const <String, Object?>{},
  }) {
    if (!kDebugMode && !kProfileMode) {
      return;
    }

    final payload = StringBuffer('list_perf ${event.value}');
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
