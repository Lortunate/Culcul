# Phase 22 Performance Baseline

## Environment

- Date: 2026-05-14
- Flutter: 3.41.9 stable
- Dart: 3.11.5
- DevTools: 2.54.2
- Host: Windows x64, Microsoft Windows 10.0.26220.8370
- Connected devices:
  - Windows desktop
  - Chrome web
  - Edge web
- Android/iOS device or emulator: not connected in this session.

## Mode Coverage

- Debug: available through desktop/web targets, not profiled here.
- Profile: not captured. No Android/iOS profile-capable target was connected.
- Release: not captured. No release smoke was run in this baseline pass.

## Startup Smoke

- Not measured yet.
- Reason: no Android/iOS emulator or device was connected, and the plan calls for profile-oriented runtime notes rather than desktop-only debug startup numbers.
- Next measurement target: Android profile launch with first-frame/startup notes.

## Scroll Smoothness Notes

- Home feed: not measured yet.
- Dynamic/notification lists: not measured yet.
- Trace target status: no existing `integration_test/` setup was present at baseline, so no opt-in trace file was added in Task 1.

## Video and Wakelock Notes

- Video playback: not measured yet.
- Route-exit wakelock cleanup: not measured yet.
- Next measurement target: Android profile smoke covering playback start, route exit, background/foreground, and wakelock release.

## Network Request Notes

- Home cold/warm request timing: not measured yet.
- Profile cold/warm request timing: not measured yet.
- Search cold/warm request timing: not measured yet.
- Current policy files already present:
  - `lib/core/data/network/network_quality_policy.dart`
  - `lib/core/data/network/dio_client.dart`
  - `lib/core/data/network/request_executor.dart`

## Verification Baseline

- `flutter --version`: passed.
- `flutter devices`: passed; only Windows desktop and web devices detected.
- `dart format --output=none --set-exit-if-changed .`: failed baseline formatting gate; reported 227 files that would change. The command did not modify tracked files in this run.
- `flutter analyze`: failed baseline analyzer gate with 305 issues.
- `flutter test test/core/data/network test/core/runtime`: failed before Task 1 because both directories were missing.

## Task 1 Updates

- Added focused network/runtime test directories.
- Added baseline tests for `NetworkQualityPolicy`.
- Added baseline tests for `PerformancePolicy`.
- Added a skipped endpoint-policy placeholder test because endpoint policy types are scheduled for Phase 22 Task 3, not Task 1.
