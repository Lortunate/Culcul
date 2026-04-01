import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/core/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

class _FakeSettingsBox extends Fake implements Box<dynamic> {
  final Map<dynamic, dynamic> _store = <dynamic, dynamic>{};

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) {
    return _store.containsKey(key) ? _store[key] : defaultValue;
  }

  @override
  Future<void> put(dynamic key, dynamic value) async {
    _store[key] = value;
  }
}

ProviderContainer _buildContainer(_FakeSettingsBox box) {
  return ProviderContainer(
    overrides: [settingsStorageBoxProvider.overrideWith((ref) => box)],
  );
}

void main() {
  test('rewrite api host to active preset base domain', () {
    final originalUri = Uri.parse(
      'https://api.bilibili.com/x/web-interface/nav?from=test',
    );
    final rewritten = rewriteUriWithPreset(originalUri, biliPresetById('dns_backup'));

    expect(rewritten.host, 'api.biliapi.net');
    expect(rewritten.path, '/x/web-interface/nav');
    expect(rewritten.queryParameters['from'], 'test');
  });

  test('rewrite bilivideo hosts including mcdn.bilivideo.cn', () {
    final preset = biliPresetById('cdn_ks3');

    final bilivideoCom = Uri.parse(
      'https://upos-sz-mirrorcos.bilivideo.com/upgcxcode/1/2/3/test.m4s',
    );
    final bilivideoCn = Uri.parse(
      'https://xy113x200x108x47xy.mcdn.bilivideo.cn/upgcxcode/1/2/3/test.m4s',
    );

    final rewrittenCom = rewriteUriWithPreset(bilivideoCom, preset);
    final rewrittenCn = rewriteUriWithPreset(bilivideoCn, preset);

    expect(rewrittenCom.host, 'upos-sz-mirrorks3.bilivideo.com');
    expect(rewrittenCn.host, 'upos-sz-mirrorks3.bilivideo.com');
  });

  test('latency score uses weighted value when api and cdn are both available', () {
    final score = calculateLatencyScore(
      const BiliLatencySnapshot(apiLatencyMs: 100, cdnLatencyMs: 50),
    );
    expect(score, 85);
  });

  test('hysteresis requires enough absolute or relative improvement', () {
    expect(shouldSwitchByHysteresis(currentScore: 100, candidateScore: 90), isFalse);
    expect(shouldSwitchByHysteresis(currentScore: 100, candidateScore: 70), isTrue);
    expect(shouldSwitchByHysteresis(currentScore: 100, candidateScore: 84), isTrue);
  });

  test(
    'probe switch respects hysteresis and cooldown, and unreachable active can switch',
    () async {
      final box = _FakeSettingsBox();
      final container = _buildContainer(box);
      addTearDown(container.dispose);
      final notifier = container.read(bilibiliAccelerationControllerProvider.notifier);

      final t0 = DateTime(2026, 1, 1, 10, 0, 0);
      await notifier.applyProbeResultForTesting({
        'official_direct': const BiliLatencySnapshot(
          apiLatencyMs: 100,
          cdnLatencyMs: 100,
        ),
        'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 90, cdnLatencyMs: 90),
        'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 120, cdnLatencyMs: 120),
        'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 130, cdnLatencyMs: 130),
        'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 140, cdnLatencyMs: 140),
      }, now: t0);

      var state = container.read(bilibiliAccelerationControllerProvider);
      expect(state.activePresetId, 'official_direct');

      await notifier.applyProbeResultForTesting({
        'official_direct': const BiliLatencySnapshot(
          apiLatencyMs: 120,
          cdnLatencyMs: 120,
        ),
        'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 60, cdnLatencyMs: 60),
        'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 130, cdnLatencyMs: 130),
        'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 140, cdnLatencyMs: 140),
        'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 150, cdnLatencyMs: 150),
      }, now: t0.add(const Duration(minutes: 1)));

      state = container.read(bilibiliAccelerationControllerProvider);
      expect(state.activePresetId, 'dns_backup');
      expect(state.probeSwitchCooldownUntil, isNotNull);
      expect(state.autoSwitchLogs, isNotEmpty);

      await notifier.applyProbeResultForTesting({
        'official_direct': const BiliLatencySnapshot(
          apiLatencyMs: 180,
          cdnLatencyMs: 180,
        ),
        'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 90, cdnLatencyMs: 90),
        'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 20, cdnLatencyMs: 20),
        'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 22, cdnLatencyMs: 22),
        'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 24, cdnLatencyMs: 24),
      }, now: t0.add(const Duration(minutes: 2)));

      state = container.read(bilibiliAccelerationControllerProvider);
      expect(state.activePresetId, 'dns_backup');

      await notifier.applyProbeResultForTesting({
        'official_direct': const BiliLatencySnapshot(
          apiLatencyMs: 180,
          cdnLatencyMs: 180,
        ),
        'dns_backup': const BiliLatencySnapshot(apiLatencyMs: null, cdnLatencyMs: null),
        'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 25, cdnLatencyMs: 25),
        'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 22, cdnLatencyMs: 22),
        'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 24, cdnLatencyMs: 24),
      }, now: t0.add(const Duration(minutes: 2, seconds: 30)));

      state = container.read(bilibiliAccelerationControllerProvider);
      expect(state.activePresetId, 'cdn_ks3');
    },
  );

  test(
    'failure fallback triggers after threshold and writes failure-trigger log',
    () async {
      final box = _FakeSettingsBox();
      final container = _buildContainer(box);
      addTearDown(container.dispose);
      final notifier = container.read(bilibiliAccelerationControllerProvider.notifier);

      final t0 = DateTime(2026, 1, 1, 10, 0, 0);
      await notifier.applyProbeResultForTesting(
        {
          'official_direct': const BiliLatencySnapshot(
            apiLatencyMs: 90,
            cdnLatencyMs: 90,
          ),
          'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 100, cdnLatencyMs: 100),
          'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 120, cdnLatencyMs: 120),
          'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 130, cdnLatencyMs: 130),
          'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 140, cdnLatencyMs: 140),
        },
        now: t0,
        applyAutoSwitch: false,
      );

      var fallback = await notifier.registerFailureAndTryFallbackForTesting(
        failedPresetId: 'official_direct',
        triedPresetIds: {'official_direct'},
        now: t0,
      );
      expect(fallback, isNull);

      fallback = await notifier.registerFailureAndTryFallbackForTesting(
        failedPresetId: 'official_direct',
        triedPresetIds: {'official_direct'},
        now: t0.add(const Duration(seconds: 20)),
      );
      expect(fallback, isNotNull);

      final state = container.read(bilibiliAccelerationControllerProvider);
      expect(state.activePresetId, isNot('official_direct'));
      expect(state.presetHealth['official_direct'], PresetHealthState.unreachable);
      expect(state.lastAutoSwitchLog?.triggeredByFailure, isTrue);
    },
  );

  test('failure fallback does not trigger in manual mode or when locked', () async {
    final box = _FakeSettingsBox();
    final container = _buildContainer(box);
    addTearDown(container.dispose);
    final notifier = container.read(bilibiliAccelerationControllerProvider.notifier);

    final t0 = DateTime(2026, 1, 1, 10, 0, 0);
    await notifier.applyProbeResultForTesting(
      {
        'official_direct': const BiliLatencySnapshot(apiLatencyMs: 90, cdnLatencyMs: 90),
        'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 100, cdnLatencyMs: 100),
        'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 120, cdnLatencyMs: 120),
        'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 130, cdnLatencyMs: 130),
        'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 140, cdnLatencyMs: 140),
      },
      now: t0,
      applyAutoSwitch: false,
    );

    await notifier.manualSwitchPreset('official_direct');
    var fallback = await notifier.registerFailureAndTryFallbackForTesting(
      failedPresetId: 'official_direct',
      triedPresetIds: {'official_direct'},
      now: t0.add(const Duration(seconds: 5)),
    );
    fallback = await notifier.registerFailureAndTryFallbackForTesting(
      failedPresetId: 'official_direct',
      triedPresetIds: {'official_direct'},
      now: t0.add(const Duration(seconds: 10)),
    );
    expect(fallback, isNull);

    var state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.mode, BiliAccelerationMode.manual);
    expect(state.activePresetId, 'official_direct');

    await notifier.setMode(BiliAccelerationMode.auto);
    await notifier.setLocked(true);
    fallback = await notifier.registerFailureAndTryFallbackForTesting(
      failedPresetId: 'official_direct',
      triedPresetIds: {'official_direct'},
      now: t0.add(const Duration(seconds: 20)),
    );
    fallback = await notifier.registerFailureAndTryFallbackForTesting(
      failedPresetId: 'official_direct',
      triedPresetIds: {'official_direct'},
      now: t0.add(const Duration(seconds: 25)),
    );
    expect(fallback, isNull);

    state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.locked, isTrue);
    expect(state.activePresetId, 'official_direct');
  });

  test('failure fallback applies 2-minute stable window for probe switching', () async {
    final box = _FakeSettingsBox();
    final container = _buildContainer(box);
    addTearDown(container.dispose);
    final notifier = container.read(bilibiliAccelerationControllerProvider.notifier);

    final t0 = DateTime(2026, 1, 1, 10, 0, 0);
    await notifier.applyProbeResultForTesting(
      {
        'official_direct': const BiliLatencySnapshot(apiLatencyMs: 95, cdnLatencyMs: 95),
        'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 85, cdnLatencyMs: 85),
        'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 120, cdnLatencyMs: 120),
        'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 130, cdnLatencyMs: 130),
        'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 140, cdnLatencyMs: 140),
      },
      now: t0,
      applyAutoSwitch: false,
    );

    await notifier.registerFailureAndTryFallbackForTesting(
      failedPresetId: 'official_direct',
      triedPresetIds: {'official_direct'},
      now: t0.add(const Duration(seconds: 5)),
    );
    await notifier.registerFailureAndTryFallbackForTesting(
      failedPresetId: 'official_direct',
      triedPresetIds: {'official_direct'},
      now: t0.add(const Duration(seconds: 10)),
    );

    var state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.activePresetId, 'dns_backup');
    expect(state.probeSwitchCooldownUntil, isNotNull);

    await notifier.applyProbeResultForTesting({
      'official_direct': const BiliLatencySnapshot(apiLatencyMs: 200, cdnLatencyMs: 200),
      'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 90, cdnLatencyMs: 90),
      'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 20, cdnLatencyMs: 20),
      'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 25, cdnLatencyMs: 25),
      'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 30, cdnLatencyMs: 30),
    }, now: t0.add(const Duration(minutes: 1)));
    state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.activePresetId, 'dns_backup');

    await notifier.applyProbeResultForTesting({
      'official_direct': const BiliLatencySnapshot(apiLatencyMs: 200, cdnLatencyMs: 200),
      'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 90, cdnLatencyMs: 90),
      'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 20, cdnLatencyMs: 20),
      'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 25, cdnLatencyMs: 25),
      'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 30, cdnLatencyMs: 30),
    }, now: t0.add(const Duration(minutes: 3)));
    state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.activePresetId, 'cdn_cos');
  });

  test('initial state restores active preset from storage', () async {
    final box = _FakeSettingsBox();
    await box.put(StorageKeys.biliAccelerationActivePresetId, 'cdn_ks3');
    final container = _buildContainer(box);
    addTearDown(container.dispose);

    final state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.activePresetId, 'cdn_ks3');
  });

  test('locking keeps current active preset unchanged', () async {
    final box = _FakeSettingsBox();
    final container = _buildContainer(box);
    addTearDown(container.dispose);
    final notifier = container.read(bilibiliAccelerationControllerProvider.notifier);

    await notifier.manualSwitchPreset('cdn_ks3');
    var state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.activePresetId, 'cdn_ks3');

    await notifier.setMode(BiliAccelerationMode.auto);
    await notifier.setLocked(true);

    state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.mode, BiliAccelerationMode.auto);
    expect(state.locked, isTrue);
    expect(state.activePresetId, 'cdn_ks3');
  });

  test('auto switch logs keep at most 10 records and survive rebuild', () async {
    final box = _FakeSettingsBox();
    final container1 = _buildContainer(box);
    final notifier1 = container1.read(bilibiliAccelerationControllerProvider.notifier);

    final t0 = DateTime(2026, 1, 1, 10, 0, 0);
    for (var i = 0; i < 11; i++) {
      final officialBase = i.isEven ? 200 : 40;
      final dnsBase = i.isEven ? 40 : 200;
      await notifier1.applyProbeResultForTesting({
        'official_direct': BiliLatencySnapshot(
          apiLatencyMs: officialBase + i,
          cdnLatencyMs: officialBase + i,
        ),
        'dns_backup': BiliLatencySnapshot(
          apiLatencyMs: dnsBase + i,
          cdnLatencyMs: dnsBase + i,
        ),
        'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 180, cdnLatencyMs: 180),
        'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 190, cdnLatencyMs: 190),
        'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 195, cdnLatencyMs: 195),
      }, now: t0.add(Duration(minutes: 6 * i)));
    }

    final state1 = container1.read(bilibiliAccelerationControllerProvider);
    expect(state1.autoSwitchLogs.length, kMaxAutoSwitchLogs);
    container1.dispose();

    final container2 = _buildContainer(box);
    addTearDown(container2.dispose);
    final state2 = container2.read(bilibiliAccelerationControllerProvider);
    expect(state2.autoSwitchLogs.length, kMaxAutoSwitchLogs);
  });
}
