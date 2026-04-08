# Perf Baseline Workflow

## 1) Collect baseline logs (before)
- Android:
  - `flutter run --profile`
  - `adb logcat -c`
  - Reproduce scenario (open video detail, wait first frame, interact controls, scroll comments).
  - `adb logcat -d | findstr "video_perf" > before.log`
- iOS:
  - `flutter run --profile`
  - Collect device logs from Xcode console and filter `video_perf`, save as `before.log`.

## 2) Collect optimized logs (after)
- Repeat the same scenario on the same device/network/build mode.
- Save logs as `after.log`.

## 3) Compare
- `dart run tool/perf/compare_video_perf.dart before.log after.log`
- Optional artifact outputs:
  - text report:
    - `dart run tool/perf/compare_video_perf.dart before.log after.log --text-out=compare_result.txt`
  - json report:
    - `dart run tool/perf/compare_video_perf.dart before.log after.log --json-out=compare_result.json`
  - both:
    - `dart run tool/perf/compare_video_perf.dart before.log after.log --text-out=compare_result.txt --json-out=compare_result.json`
  - reproducible pair output directory (recommended):
    - `dart run tool/perf/compare_video_perf.dart before.log after.log --out-dir=tool/perf/results`
    - emits both `<before>__vs__<after>.txt` and `<before>__vs__<after>.json`

## 4) Metrics to watch
- `critical_loaded(ms)`: video detail critical path latency.
- `playurl_loaded(ms)`: playurl resolution latency.
- `first_frame_ready(elapsedMs)`: request-to-first-frame latency.
- `frame_jank_ratio`: frame jank ratio from debug/profile frame timing summaries.
- `startup_perf`: `first_frame` / `home_ready` elapsed timings.
- `list_perf`: `load_trigger`/`load_complete` ratio by `source`, with `session_id` correlation.
- `audio_perf`: playback state broadcast `rate` and `count`.

## 5) Gate thresholds (PLAN16)
- `first_frame_ready_ms` / `critical_loaded_ms` / `playurl_loaded_ms`: no regression over `+5.0%`.
- `frame_jank_ratio`: must improve by at least `10%` (`after <= before * 0.90`).
- `startup_home_ready_elapsed_ms`: improve by at least `3%` (`delta <= -3.0%`).
- `first_frame_ready_ms`: improve by at least `3%` (`delta <= -3.0%`).
- PLAN16 key gate: among `first_screen` / `first_frame` / `jank`, at least 2 pass their improvement thresholds.
- `list_perf` by source: `load_trigger / load_complete <= 1.10`.

## Notes
- Compare only same-device + same-network + same scenario runs.
- If `elapsedMs` is missing in old logs, comparator falls back to `positionMs` for compatibility.
- JSON output includes a `meta` section (input paths, line counts, UTC generation time, gate thresholds) to support reproducible before/after comparisons.
- `--out-dir` writes text + JSON together with deterministic filenames derived from input log names.
- Optimization acceptance should include both `before.log` and `after.log` comparison results from the same device/network/path.
