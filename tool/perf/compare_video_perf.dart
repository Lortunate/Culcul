import 'dart:convert';
import 'dart:io';

const double _jankImprovementTargetRatio = 0.10;
const double _listTriggerCompleteRatioGate = 1.10;
const double _coreMetricNoRegressionPct = 5.0;
const double _firstScreenImprovementTargetPct = 3.0;
const double _firstFrameImprovementTargetPct = 3.0;

class NumericSummary {
  final int samples;
  final double? avg;

  const NumericSummary({required this.samples, required this.avg});
}

class ComparisonMetric {
  final String name;
  final NumericSummary before;
  final NumericSummary after;
  final bool lowerIsBetter;

  const ComparisonMetric({
    required this.name,
    required this.before,
    required this.after,
    required this.lowerIsBetter,
  });

  double? get deltaPct {
    final beforeAvg = before.avg;
    final afterAvg = after.avg;
    if (beforeAvg == null || afterAvg == null || beforeAvg == 0) {
      return null;
    }
    return (afterAvg - beforeAvg) / beforeAvg * 100;
  }

  bool? get improved {
    final delta = deltaPct;
    if (delta == null) {
      return null;
    }
    return lowerIsBetter ? delta < 0 : delta > 0;
  }

  Map<String, Object?> toJson() => <String, Object?>{
    'name': name,
    'before_samples': before.samples,
    'before_avg': before.avg,
    'after_samples': after.samples,
    'after_avg': after.avg,
    'delta_pct': deltaPct,
    'lower_is_better': lowerIsBetter,
    'improved': improved,
  };
}

class ListSourceSummary {
  final String source;
  final int triggerCount;
  final int completeCount;
  final int matchedSessionCount;

  const ListSourceSummary({
    required this.source,
    required this.triggerCount,
    required this.completeCount,
    required this.matchedSessionCount,
  });

  double? get triggerToCompleteRatio {
    if (completeCount == 0) {
      return triggerCount == 0 ? 1.0 : null;
    }
    return triggerCount / completeCount;
  }

  Map<String, Object?> toJson() => <String, Object?>{
    'source': source,
    'trigger_count': triggerCount,
    'complete_count': completeCount,
    'matched_session_count': matchedSessionCount,
    'trigger_to_complete_ratio': triggerToCompleteRatio,
  };
}

class PerfExtract {
  final List<double> firstFrameReadyMs;
  final List<double> criticalLoadedMs;
  final List<double> playurlLoadedMs;
  final List<double> jankRatios;
  final Map<String, List<double>> startupElapsedByEvent;
  final List<double> listLoadElapsedMs;
  final List<double> listDroppedUnknownTypeCount;
  final List<double> audioBroadcastRate;
  final List<double> audioBroadcastCount;
  final Map<String, ListSourceSummary> listSourceSummaries;

  const PerfExtract({
    required this.firstFrameReadyMs,
    required this.criticalLoadedMs,
    required this.playurlLoadedMs,
    required this.jankRatios,
    required this.startupElapsedByEvent,
    required this.listLoadElapsedMs,
    required this.listDroppedUnknownTypeCount,
    required this.audioBroadcastRate,
    required this.audioBroadcastCount,
    required this.listSourceSummaries,
  });
}

class PerfComparisonReport {
  final List<ComparisonMetric> metrics;
  final List<ListSourceComparison> listSourceComparisons;
  final List<Map<String, Object?>> gates;

  const PerfComparisonReport({
    required this.metrics,
    required this.listSourceComparisons,
    required this.gates,
  });

  Map<String, Object?> toJson() => <String, Object?>{
    'metrics': metrics.map((m) => m.toJson()).toList(),
    'list_source_comparisons': listSourceComparisons.map((c) => c.toJson()).toList(),
    'gates': gates,
  };
}

class ListSourceComparison {
  final String source;
  final ListSourceSummary before;
  final ListSourceSummary after;

  const ListSourceComparison({
    required this.source,
    required this.before,
    required this.after,
  });

  Map<String, Object?> toJson() => <String, Object?>{
    'source': source,
    'before': before.toJson(),
    'after': after.toJson(),
  };
}

class _ListEventState {
  final Set<String> triggerSessions = <String>{};
  final Set<String> completeSessions = <String>{};
  int triggerCount = 0;
  int completeCount = 0;
}

void main(List<String> args) {
  if (args.length < 2) {
    stderr.writeln(
      'Usage: dart run tool/perf/compare_video_perf.dart <before.log> <after.log> '
      '[--text-out=<path>] [--json-out=<path>] [--out-dir=<dir>]',
    );
    exitCode = 64;
    return;
  }

  final beforeFile = File(args[0]);
  final afterFile = File(args[1]);
  if (!beforeFile.existsSync() || !afterFile.existsSync()) {
    stderr.writeln('Input file not found.');
    exitCode = 66;
    return;
  }

  String? jsonOutputPath;
  String? textOutputPath;
  String? outputDirPath;
  for (final arg in args.skip(2)) {
    const prefix = '--json-out=';
    const textPrefix = '--text-out=';
    const outDirPrefix = '--out-dir=';
    if (arg.startsWith(prefix)) {
      jsonOutputPath = arg.substring(prefix.length);
      continue;
    }
    if (arg.startsWith(textPrefix)) {
      textOutputPath = arg.substring(textPrefix.length);
      continue;
    }
    if (arg.startsWith(outDirPrefix)) {
      outputDirPath = arg.substring(outDirPrefix.length);
      continue;
    }

    stderr.writeln('Unknown option: $arg');
    exitCode = 64;
    return;
  }

  if (outputDirPath != null && outputDirPath.isNotEmpty) {
    final outDir = Directory(outputDirPath)..createSync(recursive: true);
    final beforeStem = _sanitizeFileStem(beforeFile.path);
    final afterStem = _sanitizeFileStem(afterFile.path);
    final artifactPrefix = '${beforeStem}__vs__$afterStem';
    textOutputPath ??= '${outDir.path}${Platform.pathSeparator}$artifactPrefix.txt';
    jsonOutputPath ??= '${outDir.path}${Platform.pathSeparator}$artifactPrefix.json';
  }

  final beforeLines = beforeFile.readAsLinesSync();
  final afterLines = afterFile.readAsLinesSync();
  final before = parsePerfLogLines(beforeLines);
  final after = parsePerfLogLines(afterLines);
  final report = comparePerfExtract(before, after);
  final textReport = formatPerfComparisonText(report);
  final jsonMap = <String, Object?>{
    'meta': <String, Object?>{
      'generated_at_utc': DateTime.now().toUtc().toIso8601String(),
      'before_log': beforeFile.absolute.path,
      'after_log': afterFile.absolute.path,
      'before_line_count': beforeLines.length,
      'after_line_count': afterLines.length,
      'gate_thresholds': <String, Object?>{
        'jank_ratio_improvement_target_ratio': _jankImprovementTargetRatio,
        'list_trigger_complete_ratio_gate': _listTriggerCompleteRatioGate,
        'core_metric_no_regression_pct': _coreMetricNoRegressionPct,
        'first_screen_improvement_target_pct': _firstScreenImprovementTargetPct,
        'first_frame_improvement_target_pct': _firstFrameImprovementTargetPct,
      },
    },
    ...report.toJson(),
  };
  final json = const JsonEncoder.withIndent('  ').convert(jsonMap);

  stdout.writeln(textReport);
  stdout.writeln('== json ==');
  stdout.writeln(json);

  if (textOutputPath != null && textOutputPath.isNotEmpty) {
    File(textOutputPath).writeAsStringSync(textReport);
    stdout.writeln('text report written to: ${File(textOutputPath).absolute.path}');
  }
  if (jsonOutputPath != null && jsonOutputPath.isNotEmpty) {
    File(jsonOutputPath).writeAsStringSync(json);
    stdout.writeln('json report written to: ${File(jsonOutputPath).absolute.path}');
  }
}

String _sanitizeFileStem(String path) {
  final rawName = path.split(RegExp(r'[\\/]')).last;
  final dot = rawName.lastIndexOf('.');
  final stem = dot > 0 ? rawName.substring(0, dot) : rawName;
  return stem.replaceAll(RegExp(r'[^A-Za-z0-9._-]+'), '_');
}

PerfExtract parsePerfLogLines(List<String> lines) {
  final firstFrameReadyMs = <double>[];
  final criticalLoadedMs = <double>[];
  final playurlLoadedMs = <double>[];
  final jankRatios = <double>[];
  final startupElapsedByEvent = <String, List<double>>{};
  final listLoadElapsedMs = <double>[];
  final listDroppedUnknownTypeCount = <double>[];
  final audioBroadcastRate = <double>[];
  final audioBroadcastCount = <double>[];
  final listEventStateBySource = <String, _ListEventState>{};

  for (final line in lines) {
    if (line.contains('video_perf')) {
      if (line.contains('first_frame_ready')) {
        final value =
            readNumericField(line, 'elapsedMs') ?? readNumericField(line, 'positionMs');
        if (value != null) {
          firstFrameReadyMs.add(value);
        }
      } else if (line.contains('critical_loaded')) {
        final value = readNumericField(line, 'ms');
        if (value != null) {
          criticalLoadedMs.add(value);
        }
      } else if (line.contains('playurl_loaded')) {
        final value = readNumericField(line, 'ms');
        if (value != null) {
          playurlLoadedMs.add(value);
        }
      } else if (line.contains('frame_timing_summary')) {
        final value = readNumericField(line, 'jank_ratio');
        if (value != null) {
          jankRatios.add(value);
        }
      }
      continue;
    }

    if (line.contains('startup_perf')) {
      final event = readEventName(line, 'startup_perf');
      final elapsed = readNumericField(line, 'elapsed_ms');
      if (event != null && elapsed != null) {
        startupElapsedByEvent.putIfAbsent(event, () => <double>[]).add(elapsed);
      }
      continue;
    }

    if (line.contains('list_perf')) {
      final event = readEventName(line, 'list_perf');
      if (event == 'load_trigger' || event == 'load_complete') {
        final source = readStringField(line, 'source') ?? 'unknown';
        final sessionId = readStringField(line, 'session_id');
        final state = listEventStateBySource.putIfAbsent(source, _ListEventState.new);
        if (event == 'load_trigger') {
          state.triggerCount++;
          if (sessionId != null && sessionId.isNotEmpty) {
            state.triggerSessions.add(sessionId);
          }
        } else {
          state.completeCount++;
          if (sessionId != null && sessionId.isNotEmpty) {
            state.completeSessions.add(sessionId);
          }
          final elapsedMs = readNumericField(line, 'elapsed_ms');
          if (elapsedMs != null) {
            listLoadElapsedMs.add(elapsedMs);
          }
        }
      } else if (event == 'drop_unknown_search_type') {
        final count = readNumericField(line, 'count');
        if (count != null) {
          listDroppedUnknownTypeCount.add(count);
        }
      }
      continue;
    }

    if (line.contains('audio_perf') && line.contains('playback_state_broadcast')) {
      final rate = readNumericField(line, 'rate');
      if (rate != null) {
        audioBroadcastRate.add(rate);
      }
      final count = readNumericField(line, 'count');
      if (count != null) {
        audioBroadcastCount.add(count);
      }
    }
  }

  final listSourceSummaries = <String, ListSourceSummary>{};
  for (final entry in listEventStateBySource.entries) {
    final source = entry.key;
    final state = entry.value;
    final matched = state.triggerSessions.intersection(state.completeSessions).length;
    listSourceSummaries[source] = ListSourceSummary(
      source: source,
      triggerCount: state.triggerCount,
      completeCount: state.completeCount,
      matchedSessionCount: matched,
    );
  }

  return PerfExtract(
    firstFrameReadyMs: firstFrameReadyMs,
    criticalLoadedMs: criticalLoadedMs,
    playurlLoadedMs: playurlLoadedMs,
    jankRatios: jankRatios,
    startupElapsedByEvent: startupElapsedByEvent,
    listLoadElapsedMs: listLoadElapsedMs,
    listDroppedUnknownTypeCount: listDroppedUnknownTypeCount,
    audioBroadcastRate: audioBroadcastRate,
    audioBroadcastCount: audioBroadcastCount,
    listSourceSummaries: listSourceSummaries,
  );
}

PerfComparisonReport comparePerfExtract(PerfExtract before, PerfExtract after) {
  final metrics = <ComparisonMetric>[
    _metric(
      'first_frame_ready_ms',
      before.firstFrameReadyMs,
      after.firstFrameReadyMs,
      lowerIsBetter: true,
    ),
    _metric(
      'critical_loaded_ms',
      before.criticalLoadedMs,
      after.criticalLoadedMs,
      lowerIsBetter: true,
    ),
    _metric(
      'playurl_loaded_ms',
      before.playurlLoadedMs,
      after.playurlLoadedMs,
      lowerIsBetter: true,
    ),
    _metric('frame_jank_ratio', before.jankRatios, after.jankRatios, lowerIsBetter: true),
    _metric(
      'startup_first_frame_elapsed_ms',
      before.startupElapsedByEvent['first_frame'] ?? const <double>[],
      after.startupElapsedByEvent['first_frame'] ?? const <double>[],
      lowerIsBetter: true,
    ),
    _metric(
      'startup_home_ready_elapsed_ms',
      before.startupElapsedByEvent['home_ready'] ?? const <double>[],
      after.startupElapsedByEvent['home_ready'] ?? const <double>[],
      lowerIsBetter: true,
    ),
    _metric(
      'list_load_elapsed_ms',
      before.listLoadElapsedMs,
      after.listLoadElapsedMs,
      lowerIsBetter: true,
    ),
    _metric(
      'list_drop_unknown_type_count',
      before.listDroppedUnknownTypeCount,
      after.listDroppedUnknownTypeCount,
      lowerIsBetter: true,
    ),
    _metric(
      'audio_playback_broadcast_rate',
      before.audioBroadcastRate,
      after.audioBroadcastRate,
      lowerIsBetter: true,
    ),
    _metric(
      'audio_playback_broadcast_count',
      before.audioBroadcastCount,
      after.audioBroadcastCount,
      lowerIsBetter: true,
    ),
  ];

  final allSources = <String>{
    ...before.listSourceSummaries.keys,
    ...after.listSourceSummaries.keys,
  }.toList()..sort();
  final listSourceComparisons = allSources.map((source) {
    final empty = ListSourceSummary(
      source: source,
      triggerCount: 0,
      completeCount: 0,
      matchedSessionCount: 0,
    );
    return ListSourceComparison(
      source: source,
      before: before.listSourceSummaries[source] ?? empty,
      after: after.listSourceSummaries[source] ?? empty,
    );
  }).toList();

  final gates = <Map<String, Object?>>[];
  final beforeJank = _avg(before.jankRatios);
  final afterJank = _avg(after.jankRatios);
  final jankMultiplier = 1 - _jankImprovementTargetRatio;
  final jankGatePassed = beforeJank == null || afterJank == null
      ? null
      : afterJank <= beforeJank * jankMultiplier;
  gates.add(
    _buildGate(
      name: 'jank_ratio_improvement_10pct',
      passed: jankGatePassed,
      details:
          'requires after <= before * ${jankMultiplier.toStringAsFixed(2)}, '
          'before=${_fmt(beforeJank)} after=${_fmt(afterJank)}',
    ),
  );

  final firstFrameMetric = metrics.firstWhere((m) => m.name == 'first_frame_ready_ms');
  final firstFrameDelta = firstFrameMetric.deltaPct;
  final firstFrameGatePassed = firstFrameDelta == null
      ? null
      : firstFrameDelta <= -_firstFrameImprovementTargetPct;
  gates.add(
    _buildGate(
      name: 'first_frame_improvement_3pct',
      passed: firstFrameGatePassed,
      details:
          'requires delta <= -${_firstFrameImprovementTargetPct.toStringAsFixed(1)}, '
          'delta=${firstFrameDelta?.toStringAsFixed(2) ?? 'n/a'}%',
    ),
  );

  final firstScreenMetric = metrics.firstWhere(
    (m) => m.name == 'startup_home_ready_elapsed_ms',
  );
  final firstScreenDelta = firstScreenMetric.deltaPct;
  final firstScreenGatePassed = firstScreenDelta == null
      ? null
      : firstScreenDelta <= -_firstScreenImprovementTargetPct;
  gates.add(
    _buildGate(
      name: 'first_screen_improvement_3pct',
      passed: firstScreenGatePassed,
      details:
          'requires delta <= -${_firstScreenImprovementTargetPct.toStringAsFixed(1)}, '
          'delta=${firstScreenDelta?.toStringAsFixed(2) ?? 'n/a'}%',
    ),
  );

  final plan16KeyGates = <bool?>[
    firstScreenGatePassed,
    firstFrameGatePassed,
    jankGatePassed,
  ];
  final knownCount = plan16KeyGates.whereType<bool>().length;
  final passCount = plan16KeyGates.where((value) => value == true).length;
  final keyMetricsGatePassed = knownCount < 2 ? null : passCount >= 2;
  gates.add(
    _buildGate(
      name: 'plan16_two_of_three_key_metrics',
      passed: keyMetricsGatePassed,
      details:
          'requires >=2 passes among {first_screen, first_frame, jank}; '
          'passed=$passCount known=$knownCount',
    ),
  );

  for (final metric in metrics.where((m) {
    return m.name == 'first_frame_ready_ms' ||
        m.name == 'critical_loaded_ms' ||
        m.name == 'playurl_loaded_ms';
  })) {
    final delta = metric.deltaPct;
    gates.add(
      _buildGate(
        name: '${metric.name}_no_regression_5pct',
        passed: delta == null ? null : delta <= _coreMetricNoRegressionPct,
        details:
            'requires delta <= ${_coreMetricNoRegressionPct.toStringAsFixed(1)}, '
            'delta=${delta?.toStringAsFixed(2) ?? 'n/a'}%',
      ),
    );
  }

  for (final sourceSummary in listSourceComparisons) {
    final ratio = sourceSummary.after.triggerToCompleteRatio;
    gates.add(
      _buildGate(
        name: 'list_ratio_${sourceSummary.source}',
        passed: ratio == null ? null : ratio <= _listTriggerCompleteRatioGate,
        details:
            'requires trigger/complete <= ${_listTriggerCompleteRatioGate.toStringAsFixed(2)}, '
            'ratio=${_fmt(ratio)}',
      ),
    );
  }

  return PerfComparisonReport(
    metrics: metrics,
    listSourceComparisons: listSourceComparisons,
    gates: gates,
  );
}

String formatPerfComparisonText(PerfComparisonReport report) {
  final buffer = StringBuffer();
  for (final metric in report.metrics) {
    buffer.writeln('== ${metric.name} ==');
    buffer.writeln(
      'before samples=${metric.before.samples} avg=${_fmt(metric.before.avg)}',
    );
    buffer.writeln(
      'after  samples=${metric.after.samples} avg=${_fmt(metric.after.avg)}',
    );
    final delta = metric.deltaPct;
    if (delta == null) {
      buffer.writeln('delta: n/a');
    } else {
      final label = metric.improved == true ? 'improved' : 'regressed';
      buffer.writeln('delta: ${delta.toStringAsFixed(2)}% ($label)');
    }
    buffer.writeln();
  }

  buffer.writeln('== list_source_ratio(trigger/complete) ==');
  for (final comparison in report.listSourceComparisons) {
    buffer.writeln(
      '${comparison.source}: '
      'before=${_fmt(comparison.before.triggerToCompleteRatio)} '
      'after=${_fmt(comparison.after.triggerToCompleteRatio)} '
      'matched_after=${comparison.after.matchedSessionCount}',
    );
  }
  buffer.writeln();

  buffer.writeln('== gates ==');
  for (final gate in report.gates) {
    buffer.writeln('${gate['name']}: ${gate['status']} (${gate['details']})');
  }
  return buffer.toString();
}

ComparisonMetric _metric(
  String name,
  List<double> before,
  List<double> after, {
  required bool lowerIsBetter,
}) {
  return ComparisonMetric(
    name: name,
    before: NumericSummary(samples: before.length, avg: _avg(before)),
    after: NumericSummary(samples: after.length, avg: _avg(after)),
    lowerIsBetter: lowerIsBetter,
  );
}

Map<String, Object?> _buildGate({
  required String name,
  required bool? passed,
  required String details,
}) {
  final status = switch (passed) {
    true => 'pass',
    false => 'fail',
    null => 'n/a',
  };
  return <String, Object?>{
    'name': name,
    'status': status,
    'passed': passed,
    'details': details,
  };
}

double? readNumericField(String line, String key) {
  final token = '$key=';
  final index = line.indexOf(token);
  if (index < 0) {
    return null;
  }
  final start = index + token.length;
  var end = line.indexOf(' ', start);
  if (end < 0) {
    end = line.length;
  }
  return double.tryParse(line.substring(start, end));
}

String? readStringField(String line, String key) {
  final token = '$key=';
  final index = line.indexOf(token);
  if (index < 0) {
    return null;
  }
  final start = index + token.length;
  var end = line.indexOf(' ', start);
  if (end < 0) {
    end = line.length;
  }
  final value = line.substring(start, end).trim();
  return value.isEmpty ? null : value;
}

String? readEventName(String line, String prefix) {
  final marker = '$prefix ';
  final start = line.indexOf(marker);
  if (start < 0) {
    return null;
  }
  final eventStart = start + marker.length;
  var eventEnd = line.indexOf(' ', eventStart);
  if (eventEnd < 0) {
    eventEnd = line.length;
  }
  final event = line.substring(eventStart, eventEnd).trim();
  return event.isEmpty ? null : event;
}

double? _avg(List<double> values) {
  if (values.isEmpty) {
    return null;
  }
  return values.reduce((a, b) => a + b) / values.length;
}

String _fmt(double? value) => value == null ? 'n/a' : value.toStringAsFixed(3);
