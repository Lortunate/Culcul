import 'package:culcul/core/perf/startup_perf_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartupPerfTimeline', () {
    test('records elapsed marks in order', () {
      var now = DateTime(2026, 1, 1, 0, 0, 0);
      final timeline = StartupPerfTimeline(now: () => now);

      final first = timeline.mark(StartupPerfEvent.bootstrapStart);
      now = now.add(const Duration(milliseconds: 12));
      final second = timeline.mark(StartupPerfEvent.bootstrapReady);

      expect(first.elapsedMs, 0);
      expect(second.elapsedMs, 12);
      expect(timeline.marks.map((mark) => mark.event), <StartupPerfEvent>[
        StartupPerfEvent.bootstrapStart,
        StartupPerfEvent.bootstrapReady,
      ]);
    });

    test('reset clears marks and restarts elapsed baseline', () {
      var now = DateTime(2026, 1, 1, 0, 0, 0);
      final timeline = StartupPerfTimeline(now: () => now);

      timeline.mark(StartupPerfEvent.bootstrapStart);
      now = now.add(const Duration(milliseconds: 20));
      timeline.mark(StartupPerfEvent.bootstrapReady);

      timeline.reset();
      now = now.add(const Duration(milliseconds: 50));
      final mark = timeline.mark(StartupPerfEvent.runApp);

      expect(timeline.marks.length, 1);
      expect(mark.elapsedMs, 0);
      expect(mark.event, StartupPerfEvent.runApp);
    });
  });

  group('StartupPerfLogger', () {
    setUp(StartupPerfLogger.debugReset);
    tearDown(StartupPerfLogger.debugReset);

    test('appends marks to shared debug timeline', () {
      StartupPerfLogger.log(StartupPerfEvent.bootstrapStart);
      StartupPerfLogger.log(StartupPerfEvent.runApp);

      final marks = StartupPerfLogger.debugTimeline.marks;
      expect(marks.length, 2);
      expect(marks[0].event, StartupPerfEvent.bootstrapStart);
      expect(marks[1].event, StartupPerfEvent.runApp);
      expect(marks[1].elapsedMs, greaterThanOrEqualTo(marks[0].elapsedMs));
    });
  });
}
