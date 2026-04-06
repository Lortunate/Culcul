import 'dart:developer' as developer;
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

@immutable
class FrameTimingSummary {
  final int samples;
  final int buildP50Us;
  final int buildP95Us;
  final int rasterP50Us;
  final int rasterP95Us;
  final double jankRatio;

  const FrameTimingSummary({
    required this.samples,
    required this.buildP50Us,
    required this.buildP95Us,
    required this.rasterP50Us,
    required this.rasterP95Us,
    required this.jankRatio,
  });
}

class FrameTimingSampler {
  FrameTimingSampler._();

  static const String _loggerName = 'video.performance';
  static const int _jankBudgetUs = 16667;

  static bool _started = false;
  static DateTime _lastReportAt = DateTime.fromMillisecondsSinceEpoch(0);
  static final ValueNotifier<FrameTimingSummary?> summaryNotifier =
      ValueNotifier<FrameTimingSummary?>(null);

  static final List<int> _buildUs = <int>[];
  static final List<int> _rasterUs = <int>[];
  static final List<int> _totalUs = <int>[];

  static int _batchSize = 180;
  static Duration _reportInterval = const Duration(seconds: 20);

  static void start({
    int batchSize = 180,
    Duration reportInterval = const Duration(seconds: 20),
  }) {
    if (_started || (!kDebugMode && !kProfileMode)) {
      return;
    }
    _started = true;
    _batchSize = math.max(30, batchSize);
    _reportInterval = reportInterval;
    _lastReportAt = DateTime.now();
    SchedulerBinding.instance.addTimingsCallback(_onFrameTimings);
  }

  static void _onFrameTimings(List<FrameTiming> timings) {
    if (timings.isEmpty) {
      return;
    }

    for (final timing in timings) {
      _buildUs.add(timing.buildDuration.inMicroseconds);
      _rasterUs.add(timing.rasterDuration.inMicroseconds);
      _totalUs.add(timing.totalSpan.inMicroseconds);
    }

    final now = DateTime.now();
    final shouldFlush =
        _totalUs.length >= _batchSize || now.difference(_lastReportAt) >= _reportInterval;

    if (!shouldFlush) {
      return;
    }

    _flush(now);
  }

  static void _flush(DateTime now) {
    if (_totalUs.isEmpty) {
      _lastReportAt = now;
      return;
    }

    final sampleCount = _totalUs.length;
    final jankCount = _totalUs.where((value) => value > _jankBudgetUs).length;
    final jankRatio = jankCount / sampleCount;

    final buildP50 = _percentileUs(_buildUs, 0.50);
    final buildP95 = _percentileUs(_buildUs, 0.95);
    final rasterP50 = _percentileUs(_rasterUs, 0.50);
    final rasterP95 = _percentileUs(_rasterUs, 0.95);
    summaryNotifier.value = FrameTimingSummary(
      samples: sampleCount,
      buildP50Us: buildP50,
      buildP95Us: buildP95,
      rasterP50Us: rasterP50,
      rasterP95Us: rasterP95,
      jankRatio: jankRatio,
    );

    developer.log(
      'video_perf frame_timing_summary '
      'samples=$sampleCount '
      'build_p50_ms=${_toMs(buildP50)} '
      'build_p95_ms=${_toMs(buildP95)} '
      'raster_p50_ms=${_toMs(rasterP50)} '
      'raster_p95_ms=${_toMs(rasterP95)} '
      'jank_ratio=${jankRatio.toStringAsFixed(3)}',
      name: _loggerName,
    );

    _buildUs.clear();
    _rasterUs.clear();
    _totalUs.clear();
    _lastReportAt = now;
  }

  static int _percentileUs(List<int> values, double percentile) {
    if (values.isEmpty) {
      return 0;
    }

    final sorted = List<int>.from(values)..sort();
    final index = ((sorted.length - 1) * percentile).round();
    return sorted[index];
  }

  static String _toMs(int micros) {
    return (micros / 1000).toStringAsFixed(2);
  }
}
