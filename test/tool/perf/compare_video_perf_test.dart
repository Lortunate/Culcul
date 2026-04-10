import 'package:flutter_test/flutter_test.dart';

import '../../../tool/perf/compare_video_perf.dart';

void main() {
  group('parsePerfLogLines', () {
    test('parses video/startup/list/audio/feature metrics from mixed logs', () {
      final extract = parsePerfLogLines(<String>[
        'I video_perf critical_loaded ms=120',
        'I video_perf playurl_loaded ms=80',
        'I video_perf first_frame_ready elapsedMs=300',
        'I video_perf frame_timing_summary jank_ratio=0.200',
        'I startup_perf first_frame elapsed_ms=950',
        'I startup_perf home_ready elapsed_ms=1400',
        'I list_perf load_trigger source=search.result session_id=s_1 count=20',
        'I list_perf load_complete source=search.result session_id=s_1 result=success elapsed_ms=120 count=30 items_delta=10',
        'I list_perf drop_unknown_search_type source=search.result_converter count=2',
        'I audio_perf playback_state_broadcast count=30 window_s=10 rate=3.0 reason=position',
        'I feature_perf chain=search.default_hint stage=initial_data cache_present=true has_value=true ms=42',
        'I feature_perf chain=profile.space_videos stage=silent_refresh_apply mid=1 order=pubdate items=30 ms=85',
      ]);

      expect(extract.firstFrameReadyMs, <double>[300]);
      expect(extract.criticalLoadedMs, <double>[120]);
      expect(extract.playurlLoadedMs, <double>[80]);
      expect(extract.jankRatios, <double>[0.2]);
      expect(extract.startupElapsedByEvent['first_frame'], <double>[950]);
      expect(extract.startupElapsedByEvent['home_ready'], <double>[1400]);
      expect(extract.listLoadElapsedMs, <double>[120]);
      expect(extract.listDroppedUnknownTypeCount, <double>[2]);
      expect(extract.audioBroadcastRate, <double>[3]);
      expect(extract.audioBroadcastCount, <double>[30]);
      expect(
        extract.featureFlowElapsedByMetric['search.default_hint.initial_data'],
        <double>[42],
      );
      expect(
        extract.featureFlowElapsedByMetric['profile.space_videos.silent_refresh_apply'],
        <double>[85],
      );
      expect(
        extract.featureFlowCountByMetric['search.default_hint.initial_data'],
        <double>[1],
      );

      final sourceSummary = extract.listSourceSummaries['search.result'];
      expect(sourceSummary, isNotNull);
      expect(sourceSummary!.triggerCount, 1);
      expect(sourceSummary.completeCount, 1);
      expect(sourceSummary.matchedSessionCount, 1);
      expect(sourceSummary.triggerToCompleteRatio, 1.0);
    });

    test('ignores missing fields and malformed numeric values safely', () {
      final extract = parsePerfLogLines(<String>[
        'I video_perf first_frame_ready',
        'I startup_perf home_ready',
        'I list_perf load_complete source=feed.home result=success',
        'I audio_perf playback_state_broadcast count=oops rate=bad',
        'completely unrelated line',
      ]);

      expect(extract.firstFrameReadyMs, isEmpty);
      expect(extract.startupElapsedByEvent, isEmpty);
      expect(extract.audioBroadcastRate, isEmpty);
      expect(extract.audioBroadcastCount, isEmpty);

      final sourceSummary = extract.listSourceSummaries['feed.home'];
      expect(sourceSummary, isNotNull);
      expect(sourceSummary!.triggerCount, 0);
      expect(sourceSummary.completeCount, 1);
      expect(sourceSummary.matchedSessionCount, 0);
    });
  });

  test('comparePerfExtract builds metrics and gate outcomes', () {
    final before = parsePerfLogLines(<String>[
      'I video_perf first_frame_ready elapsedMs=200',
      'I video_perf critical_loaded ms=150',
      'I video_perf playurl_loaded ms=100',
      'I video_perf frame_timing_summary jank_ratio=0.200',
      'I feature_perf chain=home.recommend_feed stage=initial_data items=20 cache_present=true ms=90',
      'I list_perf load_trigger source=feed session_id=s1',
      'I list_perf load_complete source=feed session_id=s1 elapsed_ms=80 result=success',
    ]);
    final after = parsePerfLogLines(<String>[
      'I video_perf first_frame_ready elapsedMs=210',
      'I video_perf critical_loaded ms=140',
      'I video_perf playurl_loaded ms=95',
      'I video_perf frame_timing_summary jank_ratio=0.150',
      'I feature_perf chain=home.recommend_feed stage=initial_data items=20 cache_present=true ms=60',
      'I list_perf load_trigger source=feed session_id=s1',
      'I list_perf load_trigger source=feed session_id=s2',
      'I list_perf load_complete source=feed session_id=s1 elapsed_ms=90 result=success',
    ]);

    final report = comparePerfExtract(before, after);
    final firstFrameMetric = report.metrics.firstWhere(
      (metric) => metric.name == 'first_frame_ready_ms',
    );
    expect(firstFrameMetric.deltaPct, closeTo(5, 0.001));
    final featureMetric = report.metrics.firstWhere(
      (metric) => metric.name == 'feature_home.recommend_feed.initial_data_ms',
    );
    expect(featureMetric.before.avg, 90);
    expect(featureMetric.after.avg, 60);

    final feedComparison = report.listSourceComparisons.firstWhere(
      (comparison) => comparison.source == 'feed',
    );
    expect(feedComparison.after.triggerToCompleteRatio, 2.0);

    final ratioGate = report.gates.firstWhere(
      (gate) => gate['name'] == 'list_ratio_feed',
    );
    expect(ratioGate['status'], 'fail');
  });

  test('PLAN16 gate thresholds are applied (jank 10%, list ratio 1.10)', () {
    final before = parsePerfLogLines(<String>[
      'I video_perf frame_timing_summary jank_ratio=0.200',
      'I list_perf load_trigger source=feed session_id=s1',
      'I list_perf load_complete source=feed session_id=s1 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s2 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s3 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s4 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s5 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s6 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s7 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s8 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s9 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s10 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s11 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s12 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s13 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s14 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s15 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s16 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s17 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s18 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s19 elapsed_ms=100 result=success',
      'I list_perf load_complete source=feed session_id=s20 elapsed_ms=100 result=success',
    ]);
    final after = parsePerfLogLines(<String>[
      'I video_perf frame_timing_summary jank_ratio=0.180',
      'I list_perf load_trigger source=feed session_id=t1',
      'I list_perf load_trigger source=feed session_id=t2',
      'I list_perf load_trigger source=feed session_id=t3',
      'I list_perf load_trigger source=feed session_id=t4',
      'I list_perf load_trigger source=feed session_id=t5',
      'I list_perf load_trigger source=feed session_id=t6',
      'I list_perf load_trigger source=feed session_id=t7',
      'I list_perf load_trigger source=feed session_id=t8',
      'I list_perf load_trigger source=feed session_id=t9',
      'I list_perf load_trigger source=feed session_id=t10',
      'I list_perf load_trigger source=feed session_id=t11',
      'I list_perf load_trigger source=feed session_id=t12',
      'I list_perf load_trigger source=feed session_id=t13',
      'I list_perf load_trigger source=feed session_id=t14',
      'I list_perf load_trigger source=feed session_id=t15',
      'I list_perf load_trigger source=feed session_id=t16',
      'I list_perf load_trigger source=feed session_id=t17',
      'I list_perf load_trigger source=feed session_id=t18',
      'I list_perf load_trigger source=feed session_id=t19',
      'I list_perf load_trigger source=feed session_id=t20',
      'I list_perf load_trigger source=feed session_id=t21',
      'I list_perf load_complete source=feed session_id=t1 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t2 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t3 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t4 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t5 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t6 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t7 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t8 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t9 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t10 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t11 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t12 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t13 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t14 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t15 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t16 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t17 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t18 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t19 elapsed_ms=90 result=success',
      'I list_perf load_complete source=feed session_id=t20 elapsed_ms=90 result=success',
    ]);

    final report = comparePerfExtract(before, after);

    final jankGate = report.gates.firstWhere(
      (gate) => gate['name'] == 'jank_ratio_improvement_10pct',
    );
    expect(jankGate['status'], 'pass');

    final ratioGate = report.gates.firstWhere(
      (gate) => gate['name'] == 'list_ratio_feed',
    );
    expect(ratioGate['status'], 'pass');

    final keyGate = report.gates.firstWhere(
      (gate) => gate['name'] == 'plan16_two_of_three_key_metrics',
    );
    expect(keyGate['status'], 'n/a');
  });

  test('PLAN16 key metrics gate passes when at least two metrics improve', () {
    final before = parsePerfLogLines(<String>[
      'I video_perf first_frame_ready elapsedMs=200',
      'I video_perf frame_timing_summary jank_ratio=0.200',
      'I startup_perf home_ready elapsed_ms=1000',
    ]);
    final after = parsePerfLogLines(<String>[
      'I video_perf first_frame_ready elapsedMs=180',
      'I video_perf frame_timing_summary jank_ratio=0.180',
      'I startup_perf home_ready elapsed_ms=980',
    ]);

    final report = comparePerfExtract(before, after);
    final keyGate = report.gates.firstWhere(
      (gate) => gate['name'] == 'plan16_two_of_three_key_metrics',
    );
    expect(keyGate['status'], 'pass');
  });

  test('PLAN16 key metrics gate fails when fewer than two metrics improve', () {
    final before = parsePerfLogLines(<String>[
      'I video_perf first_frame_ready elapsedMs=200',
      'I video_perf frame_timing_summary jank_ratio=0.200',
      'I startup_perf home_ready elapsed_ms=1000',
    ]);
    final after = parsePerfLogLines(<String>[
      'I video_perf first_frame_ready elapsedMs=199',
      'I video_perf frame_timing_summary jank_ratio=0.220',
      'I startup_perf home_ready elapsed_ms=1010',
    ]);

    final report = comparePerfExtract(before, after);
    final keyGate = report.gates.firstWhere(
      (gate) => gate['name'] == 'plan16_two_of_three_key_metrics',
    );
    expect(keyGate['status'], 'fail');
  });

  test('formatPerfComparisonText includes feature metrics', () {
    final before = parsePerfLogLines(<String>[
      'I feature_perf chain=search.hot_ranking stage=initial_data items=10 cache_present=true ms=50',
    ]);
    final after = parsePerfLogLines(<String>[
      'I feature_perf chain=search.hot_ranking stage=initial_data items=10 cache_present=true ms=40',
    ]);

    final report = comparePerfExtract(before, after);
    final text = formatPerfComparisonText(report);

    expect(text, contains('feature_search.hot_ranking.initial_data_ms'));
  });
}
