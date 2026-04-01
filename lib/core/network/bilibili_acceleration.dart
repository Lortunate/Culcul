import 'dart:async';
import 'dart:convert';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/providers/storage_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const int kProbeSwitchAbsoluteImproveMs = 25;
const double kProbeSwitchRelativeImprove = 0.15;
const Duration kProbeSwitchCooldown = Duration(minutes: 5);
const Duration kFailureWindow = Duration(seconds: 30);
const int kFailureFallbackThreshold = 2;
const int kFailureDegradedThreshold = 1;
const Duration kFailureStableWindow = Duration(minutes: 2);
const int kMaxAutoSwitchLogs = 10;

enum BiliAccelerationMode { auto, manual }

enum BiliAutoSwitchReason { probeBest, retryFallback }

enum PresetHealthState { healthy, degraded, unreachable }

extension BiliAccelerationModeStorage on BiliAccelerationMode {
  static BiliAccelerationMode fromStorage(String? raw) {
    return switch (raw) {
      'manual' => BiliAccelerationMode.manual,
      _ => BiliAccelerationMode.auto,
    };
  }

  String get storageValue {
    return switch (this) {
      BiliAccelerationMode.auto => 'auto',
      BiliAccelerationMode.manual => 'manual',
    };
  }
}

extension PresetHealthStateStorage on PresetHealthState {
  static PresetHealthState fromStorage(String? raw) {
    return switch (raw) {
      'degraded' => PresetHealthState.degraded,
      'unreachable' => PresetHealthState.unreachable,
      _ => PresetHealthState.healthy,
    };
  }

  String get storageValue {
    return switch (this) {
      PresetHealthState.healthy => 'healthy',
      PresetHealthState.degraded => 'degraded',
      PresetHealthState.unreachable => 'unreachable',
    };
  }
}

extension BiliAutoSwitchReasonStorage on BiliAutoSwitchReason {
  static BiliAutoSwitchReason fromStorage(String? raw) {
    return switch (raw) {
      'retryFallback' => BiliAutoSwitchReason.retryFallback,
      _ => BiliAutoSwitchReason.probeBest,
    };
  }

  String get storageValue {
    return switch (this) {
      BiliAutoSwitchReason.probeBest => 'probeBest',
      BiliAutoSwitchReason.retryFallback => 'retryFallback',
    };
  }
}

class BiliLatencySnapshot {
  const BiliLatencySnapshot({this.apiLatencyMs, this.cdnLatencyMs});

  final int? apiLatencyMs;
  final int? cdnLatencyMs;

  int? get totalLatencyMs {
    final values = <int?>[apiLatencyMs, cdnLatencyMs].whereType<int>().toList();
    if (values.isEmpty) {
      return null;
    }
    final sum = values.fold<int>(0, (acc, value) => acc + value);
    return sum ~/ values.length;
  }
}

double? calculateLatencyScore(BiliLatencySnapshot? snapshot) {
  if (snapshot == null) {
    return null;
  }
  final api = snapshot.apiLatencyMs;
  final cdn = snapshot.cdnLatencyMs;
  if (api != null && cdn != null) {
    return api * 0.7 + cdn * 0.3;
  }
  if (api != null) {
    return api.toDouble();
  }
  if (cdn != null) {
    return cdn.toDouble();
  }
  return null;
}

bool shouldSwitchByHysteresis({
  required double currentScore,
  required double candidateScore,
}) {
  if (candidateScore >= currentScore) {
    return false;
  }
  final improveAbs = currentScore - candidateScore;
  final improveRatio = currentScore <= 0 ? 0 : improveAbs / currentScore;
  return improveAbs >= kProbeSwitchAbsoluteImproveMs ||
      improveRatio >= kProbeSwitchRelativeImprove;
}

class BiliAccelerationPreset {
  const BiliAccelerationPreset({
    required this.id,
    required this.displayName,
    required this.apiBaseUrl,
    this.videoCdnHost,
    this.imageCdnHost,
  });

  final String id;
  final String displayName;
  final String apiBaseUrl;
  final String? videoCdnHost;
  final String? imageCdnHost;
}

class FailureTracker {
  const FailureTracker({this.recentFailures = const <DateTime>[], this.blockedUntil});

  final List<DateTime> recentFailures;
  final DateTime? blockedUntil;

  FailureTracker copyWith({
    List<DateTime>? recentFailures,
    DateTime? blockedUntil,
    bool clearBlockedUntil = false,
  }) {
    return FailureTracker(
      recentFailures: recentFailures ?? this.recentFailures,
      blockedUntil: clearBlockedUntil ? null : (blockedUntil ?? this.blockedUntil),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'recentFailures': recentFailures
          .map((time) => time.toIso8601String())
          .toList(growable: false),
      'blockedUntil': blockedUntil?.toIso8601String(),
    };
  }

  static FailureTracker fromJson(Map<String, dynamic> json) {
    final rawFailures = json['recentFailures'];
    final failures = <DateTime>[];
    if (rawFailures is List) {
      for (final raw in rawFailures) {
        if (raw is String) {
          final parsed = DateTime.tryParse(raw);
          if (parsed != null) {
            failures.add(parsed);
          }
        }
      }
    }
    DateTime? blockedUntil;
    final blockedRaw = json['blockedUntil'];
    if (blockedRaw is String) {
      blockedUntil = DateTime.tryParse(blockedRaw);
    }
    return FailureTracker(recentFailures: failures, blockedUntil: blockedUntil);
  }
}

class BiliAutoSwitchLog {
  const BiliAutoSwitchLog({
    required this.fromPresetId,
    required this.toPresetId,
    required this.reason,
    required this.occurredAt,
    this.costMs,
    this.fromLatencyMs,
    this.toLatencyMs,
    this.fromScore,
    this.toScore,
    this.triggeredByFailure = false,
  });

  final String fromPresetId;
  final String toPresetId;
  final BiliAutoSwitchReason reason;
  final DateTime occurredAt;
  final int? costMs;
  final int? fromLatencyMs;
  final int? toLatencyMs;
  final double? fromScore;
  final double? toScore;
  final bool triggeredByFailure;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fromPresetId': fromPresetId,
      'toPresetId': toPresetId,
      'reason': reason.storageValue,
      'occurredAt': occurredAt.toIso8601String(),
      'costMs': costMs,
      'fromLatencyMs': fromLatencyMs,
      'toLatencyMs': toLatencyMs,
      'fromScore': fromScore,
      'toScore': toScore,
      'triggeredByFailure': triggeredByFailure,
    };
  }

  static BiliAutoSwitchLog? fromJson(dynamic raw) {
    if (raw is! Map) {
      return null;
    }
    final fromPresetId = raw['fromPresetId'];
    final toPresetId = raw['toPresetId'];
    final occurredAtRaw = raw['occurredAt'];
    if (fromPresetId is! String || toPresetId is! String || occurredAtRaw is! String) {
      return null;
    }
    final occurredAt = DateTime.tryParse(occurredAtRaw);
    if (occurredAt == null) {
      return null;
    }
    return BiliAutoSwitchLog(
      fromPresetId: fromPresetId,
      toPresetId: toPresetId,
      reason: BiliAutoSwitchReasonStorage.fromStorage(raw['reason'] as String?),
      occurredAt: occurredAt,
      costMs: (raw['costMs'] as num?)?.toInt(),
      fromLatencyMs: (raw['fromLatencyMs'] as num?)?.toInt(),
      toLatencyMs: (raw['toLatencyMs'] as num?)?.toInt(),
      fromScore: (raw['fromScore'] as num?)?.toDouble(),
      toScore: (raw['toScore'] as num?)?.toDouble(),
      triggeredByFailure: raw['triggeredByFailure'] == true,
    );
  }
}

const List<BiliAccelerationPreset> kBiliAccelerationPresets = [
  BiliAccelerationPreset(
    id: 'official_direct',
    displayName: 'Official Direct',
    apiBaseUrl: 'https://api.bilibili.com',
  ),
  BiliAccelerationPreset(
    id: 'dns_backup',
    displayName: 'DNS Backup',
    apiBaseUrl: 'https://api.biliapi.net',
  ),
  BiliAccelerationPreset(
    id: 'app_backup',
    displayName: 'App API',
    apiBaseUrl: 'https://app.bilibili.com',
  ),
  BiliAccelerationPreset(
    id: 'app_dns_backup',
    displayName: 'App DNS Backup',
    apiBaseUrl: 'https://app.biliapi.net',
  ),
  BiliAccelerationPreset(
    id: 'cdn_cos',
    displayName: 'CDN COS',
    apiBaseUrl: 'https://api.bilibili.com',
    videoCdnHost: 'upos-sz-mirrorcos.bilivideo.com',
    imageCdnHost: 'i0.hdslb.com',
  ),
  BiliAccelerationPreset(
    id: 'cdn_ks3',
    displayName: 'CDN KS3',
    apiBaseUrl: 'https://api.bilibili.com',
    videoCdnHost: 'upos-sz-mirrorks3.bilivideo.com',
    imageCdnHost: 'i1.hdslb.com',
  ),
  BiliAccelerationPreset(
    id: 'cdn_ali',
    displayName: 'CDN ALI',
    apiBaseUrl: 'https://api.bilibili.com',
    videoCdnHost: 'upos-sz-mirrorali.bilivideo.com',
    imageCdnHost: 'i2.hdslb.com',
  ),
  BiliAccelerationPreset(
    id: 'cdn_hw',
    displayName: 'CDN HW',
    apiBaseUrl: 'https://api.bilibili.com',
    videoCdnHost: 'upos-sz-mirrorhw.bilivideo.com',
    imageCdnHost: 'i0.hdslb.com',
  ),
  BiliAccelerationPreset(
    id: 'cdn_bos',
    displayName: 'CDN BOS',
    apiBaseUrl: 'https://api.bilibili.com',
    videoCdnHost: 'upos-sz-mirrorbos.bilivideo.com',
    imageCdnHost: 'i1.hdslb.com',
  ),
  BiliAccelerationPreset(
    id: 'cdn_tencent',
    displayName: 'CDN TENCENT',
    apiBaseUrl: 'https://api.bilibili.com',
    videoCdnHost: 'upos-sz-mirrortencent.bilivideo.com',
    imageCdnHost: 'i2.hdslb.com',
  ),
  BiliAccelerationPreset(
    id: 'cdn_akam',
    displayName: 'CDN AKAMAI',
    apiBaseUrl: 'https://api.bilibili.com',
    videoCdnHost: 'upos-hz-mirrorakam.akamaized.net',
    imageCdnHost: 'i0.hdslb.com',
  ),
];

final Set<String> _biliApiHosts = <String>{
  Uri.parse(ApiConstants.baseUrl).host,
  Uri.parse(ApiConstants.baseUrlFallback).host,
  ...kBiliAccelerationPresets.map((preset) => Uri.parse(preset.apiBaseUrl).host),
};

BiliAccelerationPreset biliPresetById(String id) {
  for (final preset in kBiliAccelerationPresets) {
    if (preset.id == id) {
      return preset;
    }
  }
  return kBiliAccelerationPresets.first;
}

bool isBiliAccelerationTargetHost(String host) {
  return _biliApiHosts.contains(host) ||
      _isBiliVideoHost(host) ||
      _isHdslbImageHost(host);
}

Uri rewriteUriWithPreset(Uri originalUri, BiliAccelerationPreset preset) {
  final host = originalUri.host;
  if (host.isEmpty) {
    return originalUri;
  }

  if (_biliApiHosts.contains(host)) {
    final target = Uri.parse(preset.apiBaseUrl);
    return originalUri.replace(
      scheme: target.scheme,
      host: target.host,
      port: target.hasPort ? target.port : null,
    );
  }

  if (preset.videoCdnHost != null && _isBiliVideoHost(host)) {
    return originalUri.replace(host: preset.videoCdnHost);
  }

  if (preset.imageCdnHost != null && _isHdslbImageHost(host)) {
    return originalUri.replace(host: preset.imageCdnHost);
  }

  return originalUri;
}

class BiliAccelerationState {
  const BiliAccelerationState({
    required this.mode,
    required this.locked,
    required this.activePresetId,
    required this.latencies,
    required this.isTesting,
    required this.autoSwitchLogs,
    required this.presetFailureTrackers,
    required this.presetHealth,
    this.lastProbeAt,
    this.probeSwitchCooldownUntil,
  });

  final BiliAccelerationMode mode;
  final bool locked;
  final String activePresetId;
  final Map<String, BiliLatencySnapshot> latencies;
  final bool isTesting;
  final List<BiliAutoSwitchLog> autoSwitchLogs;
  final Map<String, FailureTracker> presetFailureTrackers;
  final Map<String, PresetHealthState> presetHealth;
  final DateTime? lastProbeAt;
  final DateTime? probeSwitchCooldownUntil;

  BiliAutoSwitchLog? get lastAutoSwitchLog {
    return autoSwitchLogs.isEmpty ? null : autoSwitchLogs.first;
  }

  BiliAccelerationState copyWith({
    BiliAccelerationMode? mode,
    bool? locked,
    String? activePresetId,
    Map<String, BiliLatencySnapshot>? latencies,
    bool? isTesting,
    List<BiliAutoSwitchLog>? autoSwitchLogs,
    Map<String, FailureTracker>? presetFailureTrackers,
    Map<String, PresetHealthState>? presetHealth,
    DateTime? lastProbeAt,
    DateTime? probeSwitchCooldownUntil,
    bool clearLastProbeAt = false,
    bool clearProbeSwitchCooldownUntil = false,
  }) {
    return BiliAccelerationState(
      mode: mode ?? this.mode,
      locked: locked ?? this.locked,
      activePresetId: activePresetId ?? this.activePresetId,
      latencies: latencies ?? this.latencies,
      isTesting: isTesting ?? this.isTesting,
      autoSwitchLogs: autoSwitchLogs ?? this.autoSwitchLogs,
      presetFailureTrackers: presetFailureTrackers ?? this.presetFailureTrackers,
      presetHealth: presetHealth ?? this.presetHealth,
      lastProbeAt: clearLastProbeAt ? null : (lastProbeAt ?? this.lastProbeAt),
      probeSwitchCooldownUntil: clearProbeSwitchCooldownUntil
          ? null
          : (probeSwitchCooldownUntil ?? this.probeSwitchCooldownUntil),
    );
  }
}

final bilibiliAccelerationControllerProvider =
    NotifierProvider<BilibiliAccelerationController, BiliAccelerationState>(
      BilibiliAccelerationController.new,
    );

class BilibiliAccelerationController extends Notifier<BiliAccelerationState> {
  bool _startupProbeScheduled = false;

  @override
  BiliAccelerationState build() {
    final box = ref.watch(settingsStorageBoxProvider);
    final mode = BiliAccelerationModeStorage.fromStorage(
      box.get(StorageKeys.biliAccelerationMode) as String?,
    );
    final locked =
        box.get(StorageKeys.biliAccelerationLocked, defaultValue: false) as bool? ??
        false;
    final activePresetId = _normalizePresetId(
      box.get(StorageKeys.biliAccelerationActivePresetId) as String?,
    );

    final latencies = {
      for (final preset in kBiliAccelerationPresets)
        preset.id: const BiliLatencySnapshot(),
    };
    final now = DateTime.now();
    final failureTrackers = _readFailureTrackers(box);
    final normalizedTrackers = _normalizeFailureTrackers(failureTrackers, now);
    final persistedHealth = _readPresetHealth(box);
    final computedHealth = _computePresetHealth(
      now: now,
      latencies: latencies,
      trackers: normalizedTrackers,
    );
    final mergedHealth = {
      for (final preset in kBiliAccelerationPresets)
        preset.id: persistedHealth[preset.id] ?? computedHealth[preset.id]!,
    };
    final logs = _readLogs(box);
    final cooldownUntil = _readDateTime(
      box.get(StorageKeys.biliAccelerationProbeSwitchCooldownUntil) as String?,
    );

    final initialState = BiliAccelerationState(
      mode: mode,
      locked: locked,
      activePresetId: activePresetId,
      latencies: latencies,
      isTesting: false,
      autoSwitchLogs: logs,
      presetFailureTrackers: normalizedTrackers,
      presetHealth: mergedHealth,
      probeSwitchCooldownUntil: cooldownUntil,
    );

    _scheduleStartupProbe(initialState);
    return initialState;
  }

  BiliAccelerationPreset get activePreset => biliPresetById(state.activePresetId);

  Future<void> setMode(BiliAccelerationMode mode) async {
    var next = state.copyWith(mode: mode);
    if (mode == BiliAccelerationMode.auto && !next.locked) {
      final bestPresetId = _findBestPresetId(
        latencies: next.latencies,
        healthMap: next.presetHealth,
        preferCurrentPresetId: next.activePresetId,
      );
      next = next.copyWith(activePresetId: bestPresetId ?? next.activePresetId);
    }
    state = next;
    await _persistAllState(next);
    if (mode == BiliAccelerationMode.auto && !next.locked) {
      unawaited(probeLatencies());
    }
  }

  Future<void> setLocked(bool locked) async {
    var next = state.copyWith(locked: locked);
    if (!locked && next.mode == BiliAccelerationMode.auto) {
      final bestPresetId = _findBestPresetId(
        latencies: next.latencies,
        healthMap: next.presetHealth,
        preferCurrentPresetId: next.activePresetId,
      );
      next = next.copyWith(activePresetId: bestPresetId ?? next.activePresetId);
    }
    state = next;
    await _persistAllState(next);
    if (!locked && next.mode == BiliAccelerationMode.auto) {
      unawaited(probeLatencies());
    }
  }

  Future<void> manualSwitchPreset(String presetId) async {
    final normalizedPresetId = _normalizePresetId(presetId);
    final next = state.copyWith(
      mode: BiliAccelerationMode.manual,
      activePresetId: normalizedPresetId,
    );
    state = next;
    await _persistAllState(next);
  }

  Future<void> probeLatencies({bool applyAutoSwitch = true}) async {
    if (state.isTesting) {
      return;
    }
    state = state.copyWith(isTesting: true);

    final probeDio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 4),
        receiveTimeout: const Duration(seconds: 4),
        sendTimeout: const Duration(seconds: 4),
        validateStatus: (_) => true,
        headers: const <String, String>{
          'User-Agent': ApiConstants.userAgent,
          'Referer': ApiConstants.referer,
          'Accept': 'application/json, text/plain, */*',
        },
      ),
    );

    final latencyMap = <String, BiliLatencySnapshot>{};
    final stopwatch = Stopwatch()..start();
    try {
      final futures = kBiliAccelerationPresets.map((preset) async {
        final snapshot = await _probePreset(probeDio, preset);
        return MapEntry(preset.id, snapshot);
      });
      final entries = await Future.wait(futures);
      latencyMap.addEntries(entries);
    } finally {
      stopwatch.stop();
      probeDio.close(force: true);
    }

    await applyProbeResult(
      latencyMap,
      applyAutoSwitch: applyAutoSwitch,
      now: DateTime.now(),
      probeCostMs: stopwatch.elapsedMilliseconds,
    );
  }

  Future<void> applyProbeResult(
    Map<String, BiliLatencySnapshot> latencyMap, {
    required bool applyAutoSwitch,
    DateTime? now,
    int? probeCostMs,
  }) async {
    final nowTime = now ?? DateTime.now();
    var trackers = _normalizeFailureTrackers(state.presetFailureTrackers, nowTime);
    final healthMap = _computePresetHealth(
      now: nowTime,
      latencies: latencyMap,
      trackers: trackers,
    );
    var next = state.copyWith(
      latencies: latencyMap,
      isTesting: false,
      lastProbeAt: nowTime,
      presetFailureTrackers: trackers,
      presetHealth: healthMap,
    );

    if (applyAutoSwitch && next.mode == BiliAccelerationMode.auto && !next.locked) {
      final switchTarget = _decideProbeSwitchTarget(next, nowTime);
      if (switchTarget != null) {
        final fromPresetId = next.activePresetId;
        next = next.copyWith(
          activePresetId: switchTarget,
          autoSwitchLogs: _pushAutoSwitchLog(
            next.autoSwitchLogs,
            _buildSwitchLog(
              fromPresetId: fromPresetId,
              toPresetId: switchTarget,
              reason: BiliAutoSwitchReason.probeBest,
              occurredAt: nowTime,
              costMs: probeCostMs,
              latencies: latencyMap,
              triggeredByFailure: false,
            ),
          ),
          probeSwitchCooldownUntil: nowTime.add(kProbeSwitchCooldown),
        );
      }
    }

    state = next;
    await _persistAllState(next);
  }

  Future<BiliAccelerationPreset?> registerFailureAndTryFallback({
    required String failedPresetId,
    required Set<String> triedPresetIds,
    DateTime? now,
  }) async {
    final nowTime = now ?? DateTime.now();
    final normalizedPresetId = _normalizePresetId(failedPresetId);
    var trackers = _normalizeFailureTrackers(state.presetFailureTrackers, nowTime);
    final currentTracker = trackers[normalizedPresetId] ?? const FailureTracker();
    final recentFailures = List<DateTime>.from(currentTracker.recentFailures)
      ..add(nowTime);
    trackers[normalizedPresetId] = currentTracker.copyWith(
      recentFailures: recentFailures,
    );

    var healthMap = _computePresetHealth(
      now: nowTime,
      latencies: state.latencies,
      trackers: trackers,
    );
    var next = state.copyWith(presetFailureTrackers: trackers, presetHealth: healthMap);

    final shouldFallback =
        next.mode == BiliAccelerationMode.auto &&
        !next.locked &&
        (trackers[normalizedPresetId]?.recentFailures.length ?? 0) >=
            kFailureFallbackThreshold;
    if (!shouldFallback) {
      state = next;
      await _persistAllState(next);
      return null;
    }

    final fallbackPresetId = _findBestPresetId(
      latencies: next.latencies,
      healthMap: next.presetHealth,
      preferCurrentPresetId: next.activePresetId,
      excludedPresetIds: triedPresetIds,
    );
    if (fallbackPresetId == null || fallbackPresetId == next.activePresetId) {
      state = next;
      await _persistAllState(next);
      return null;
    }

    final failedTracker = trackers[normalizedPresetId] ?? const FailureTracker();
    trackers[normalizedPresetId] = failedTracker.copyWith(
      blockedUntil: nowTime.add(kFailureStableWindow),
    );
    healthMap = _computePresetHealth(
      now: nowTime,
      latencies: next.latencies,
      trackers: trackers,
    );

    next = next.copyWith(
      activePresetId: fallbackPresetId,
      presetFailureTrackers: trackers,
      presetHealth: healthMap,
      probeSwitchCooldownUntil: nowTime.add(kFailureStableWindow),
      autoSwitchLogs: _pushAutoSwitchLog(
        next.autoSwitchLogs,
        _buildSwitchLog(
          fromPresetId: normalizedPresetId,
          toPresetId: fallbackPresetId,
          reason: BiliAutoSwitchReason.retryFallback,
          occurredAt: nowTime,
          costMs: null,
          latencies: next.latencies,
          triggeredByFailure: true,
        ),
      ),
    );
    state = next;
    await _persistAllState(next);
    return biliPresetById(fallbackPresetId);
  }

  @visibleForTesting
  Future<void> applyProbeResultForTesting(
    Map<String, BiliLatencySnapshot> latencyMap, {
    required DateTime now,
    bool applyAutoSwitch = true,
    int? probeCostMs,
  }) {
    return applyProbeResult(
      latencyMap,
      applyAutoSwitch: applyAutoSwitch,
      now: now,
      probeCostMs: probeCostMs,
    );
  }

  @visibleForTesting
  Future<BiliAccelerationPreset?> registerFailureAndTryFallbackForTesting({
    required String failedPresetId,
    required Set<String> triedPresetIds,
    required DateTime now,
  }) {
    return registerFailureAndTryFallback(
      failedPresetId: failedPresetId,
      triedPresetIds: triedPresetIds,
      now: now,
    );
  }

  String? _decideProbeSwitchTarget(BiliAccelerationState snapshot, DateTime now) {
    final activePresetId = snapshot.activePresetId;
    final bestPresetId = _findBestPresetId(
      latencies: snapshot.latencies,
      healthMap: snapshot.presetHealth,
      preferCurrentPresetId: activePresetId,
    );
    if (bestPresetId == null || bestPresetId == activePresetId) {
      return null;
    }

    final activeScore = calculateLatencyScore(snapshot.latencies[activePresetId]);
    final candidateScore = calculateLatencyScore(snapshot.latencies[bestPresetId]);
    if (candidateScore == null) {
      return null;
    }

    final activeHealth = snapshot.presetHealth[activePresetId];
    if (activeHealth == PresetHealthState.unreachable) {
      return bestPresetId;
    }

    if (activeScore == null) {
      return bestPresetId;
    }

    final cooldownUntil = snapshot.probeSwitchCooldownUntil;
    if (cooldownUntil != null && now.isBefore(cooldownUntil)) {
      return null;
    }

    if (!shouldSwitchByHysteresis(
      currentScore: activeScore,
      candidateScore: candidateScore,
    )) {
      return null;
    }
    return bestPresetId;
  }

  String? _findBestPresetId({
    required Map<String, BiliLatencySnapshot> latencies,
    required Map<String, PresetHealthState> healthMap,
    required String preferCurrentPresetId,
    Set<String>? excludedPresetIds,
  }) {
    final excluded = excludedPresetIds ?? const <String>{};
    final candidates = <(String presetId, double score, int order)>[];
    for (var i = 0; i < kBiliAccelerationPresets.length; i++) {
      final presetId = kBiliAccelerationPresets[i].id;
      if (excluded.contains(presetId)) {
        continue;
      }
      if (healthMap[presetId] == PresetHealthState.unreachable) {
        continue;
      }
      final score = calculateLatencyScore(latencies[presetId]);
      if (score == null) {
        continue;
      }
      candidates.add((presetId, score, i));
    }
    if (candidates.isEmpty) {
      return null;
    }
    candidates.sort((left, right) {
      final scoreCompare = left.$2.compareTo(right.$2);
      if (scoreCompare != 0) {
        return scoreCompare;
      }
      final leftIsCurrent = left.$1 == preferCurrentPresetId;
      final rightIsCurrent = right.$1 == preferCurrentPresetId;
      if (leftIsCurrent && !rightIsCurrent) {
        return -1;
      }
      if (!leftIsCurrent && rightIsCurrent) {
        return 1;
      }
      return left.$3.compareTo(right.$3);
    });
    return candidates.first.$1;
  }

  Map<String, PresetHealthState> _computePresetHealth({
    required DateTime now,
    required Map<String, BiliLatencySnapshot> latencies,
    required Map<String, FailureTracker> trackers,
  }) {
    final healthMap = <String, PresetHealthState>{};
    for (final preset in kBiliAccelerationPresets) {
      final presetId = preset.id;
      final tracker = trackers[presetId] ?? const FailureTracker();
      final score = calculateLatencyScore(latencies[presetId]);
      final blockedUntil = tracker.blockedUntil;
      final isBlocked = blockedUntil != null && blockedUntil.isAfter(now);
      if (isBlocked || score == null) {
        healthMap[presetId] = PresetHealthState.unreachable;
        continue;
      }
      if (tracker.recentFailures.length >= kFailureDegradedThreshold) {
        healthMap[presetId] = PresetHealthState.degraded;
        continue;
      }
      healthMap[presetId] = PresetHealthState.healthy;
    }
    return healthMap;
  }

  Map<String, FailureTracker> _normalizeFailureTrackers(
    Map<String, FailureTracker> trackers,
    DateTime now,
  ) {
    final normalized = <String, FailureTracker>{};
    for (final preset in kBiliAccelerationPresets) {
      final tracker = trackers[preset.id] ?? const FailureTracker();
      final failures =
          tracker.recentFailures
              .where((time) => now.difference(time) <= kFailureWindow)
              .toList()
            ..sort();
      final blockedUntil =
          tracker.blockedUntil != null && tracker.blockedUntil!.isAfter(now)
          ? tracker.blockedUntil
          : null;
      normalized[preset.id] = FailureTracker(
        recentFailures: failures,
        blockedUntil: blockedUntil,
      );
    }
    return normalized;
  }

  BiliAutoSwitchLog _buildSwitchLog({
    required String fromPresetId,
    required String toPresetId,
    required BiliAutoSwitchReason reason,
    required DateTime occurredAt,
    required int? costMs,
    required Map<String, BiliLatencySnapshot> latencies,
    required bool triggeredByFailure,
  }) {
    final fromSnapshot = latencies[fromPresetId];
    final toSnapshot = latencies[toPresetId];
    return BiliAutoSwitchLog(
      fromPresetId: fromPresetId,
      toPresetId: toPresetId,
      reason: reason,
      occurredAt: occurredAt,
      costMs: costMs,
      fromLatencyMs: fromSnapshot?.totalLatencyMs,
      toLatencyMs: toSnapshot?.totalLatencyMs,
      fromScore: calculateLatencyScore(fromSnapshot),
      toScore: calculateLatencyScore(toSnapshot),
      triggeredByFailure: triggeredByFailure,
    );
  }

  List<BiliAutoSwitchLog> _pushAutoSwitchLog(
    List<BiliAutoSwitchLog> current,
    BiliAutoSwitchLog incoming,
  ) {
    final next = <BiliAutoSwitchLog>[incoming, ...current];
    if (next.length > kMaxAutoSwitchLogs) {
      next.removeRange(kMaxAutoSwitchLogs, next.length);
    }
    return next;
  }

  void _scheduleStartupProbe(BiliAccelerationState currentState) {
    if (_startupProbeScheduled ||
        currentState.locked ||
        currentState.mode != BiliAccelerationMode.auto) {
      return;
    }
    _startupProbeScheduled = true;
    Future<void>.microtask(() async {
      await probeLatencies();
    });
  }

  String _normalizePresetId(String? presetId) {
    if (presetId == null) {
      return kBiliAccelerationPresets.first.id;
    }
    for (final preset in kBiliAccelerationPresets) {
      if (preset.id == presetId) {
        return preset.id;
      }
    }
    return kBiliAccelerationPresets.first.id;
  }

  Future<void> _persistAllState(BiliAccelerationState state) {
    final box = ref.read(settingsStorageBoxProvider);
    final encodedLogs = jsonEncode(
      state.autoSwitchLogs.map((log) => log.toJson()).toList(growable: false),
    );
    final encodedTrackers = jsonEncode({
      for (final entry in state.presetFailureTrackers.entries)
        entry.key: entry.value.toJson(),
    });
    final encodedHealth = jsonEncode({
      for (final entry in state.presetHealth.entries) entry.key: entry.value.storageValue,
    });
    return Future.wait<void>([
      box.put(StorageKeys.biliAccelerationMode, state.mode.storageValue),
      box.put(StorageKeys.biliAccelerationLocked, state.locked),
      box.put(StorageKeys.biliAccelerationActivePresetId, state.activePresetId),
      box.put(StorageKeys.biliAccelerationAutoSwitchLogs, encodedLogs),
      box.put(
        StorageKeys.biliAccelerationProbeSwitchCooldownUntil,
        state.probeSwitchCooldownUntil?.toIso8601String(),
      ),
      box.put(StorageKeys.biliAccelerationFailureTrackers, encodedTrackers),
      box.put(StorageKeys.biliAccelerationPresetHealth, encodedHealth),
    ]);
  }

  List<BiliAutoSwitchLog> _readLogs(dynamic box) {
    final raw = box.get(StorageKeys.biliAccelerationAutoSwitchLogs);
    if (raw is! String || raw.isEmpty) {
      return const <BiliAutoSwitchLog>[];
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return const <BiliAutoSwitchLog>[];
      }
      final logs = <BiliAutoSwitchLog>[];
      for (final item in decoded) {
        final parsed = BiliAutoSwitchLog.fromJson(item);
        if (parsed != null) {
          logs.add(parsed);
        }
      }
      return logs.take(kMaxAutoSwitchLogs).toList(growable: false);
    } catch (_) {
      return const <BiliAutoSwitchLog>[];
    }
  }

  Map<String, FailureTracker> _readFailureTrackers(dynamic box) {
    final raw = box.get(StorageKeys.biliAccelerationFailureTrackers);
    if (raw is! String || raw.isEmpty) {
      return <String, FailureTracker>{};
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        return <String, FailureTracker>{};
      }
      final trackers = <String, FailureTracker>{};
      decoded.forEach((key, value) {
        if (key is String && value is Map<String, dynamic>) {
          trackers[key] = FailureTracker.fromJson(value);
        } else if (key is String && value is Map) {
          trackers[key] = FailureTracker.fromJson(Map<String, dynamic>.from(value));
        }
      });
      return trackers;
    } catch (_) {
      return <String, FailureTracker>{};
    }
  }

  Map<String, PresetHealthState> _readPresetHealth(dynamic box) {
    final raw = box.get(StorageKeys.biliAccelerationPresetHealth);
    if (raw is! String || raw.isEmpty) {
      return <String, PresetHealthState>{};
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        return <String, PresetHealthState>{};
      }
      final health = <String, PresetHealthState>{};
      decoded.forEach((key, value) {
        if (key is String) {
          health[key] = PresetHealthStateStorage.fromStorage(value as String?);
        }
      });
      return health;
    } catch (_) {
      return <String, PresetHealthState>{};
    }
  }

  DateTime? _readDateTime(String? raw) {
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return DateTime.tryParse(raw);
  }

  Future<BiliLatencySnapshot> _probePreset(
    Dio probeDio,
    BiliAccelerationPreset preset,
  ) async {
    final apiUri = Uri.parse(preset.apiBaseUrl).resolve(ApiConstants.nav);
    final apiLatencyMsFuture = _probeUriLatency(probeDio, apiUri);

    Future<int?> cdnLatencyMsFuture = Future.value(null);
    if (preset.videoCdnHost != null) {
      cdnLatencyMsFuture = _probeUriLatency(
        probeDio,
        Uri.https(preset.videoCdnHost!, '/'),
      );
    } else if (preset.imageCdnHost != null) {
      cdnLatencyMsFuture = _probeUriLatency(
        probeDio,
        Uri.https(preset.imageCdnHost!, '/'),
      );
    }

    final results = await Future.wait([apiLatencyMsFuture, cdnLatencyMsFuture]);
    return BiliLatencySnapshot(
      apiLatencyMs: results[0],
      cdnLatencyMs: results[1],
    );
  }

  Future<int?> _probeUriLatency(Dio probeDio, Uri uri) async {
    final stopwatch = Stopwatch()..start();
    try {
      final uriWithTs = uri.replace(
        queryParameters: <String, String>{
          ...uri.queryParameters,
          '_': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );
      final response = await probeDio.getUri(uriWithTs);
      final statusCode = response.statusCode ?? 0;
      if (statusCode >= 500 || statusCode == 0) {
        return null;
      }
      return stopwatch.elapsedMilliseconds;
    } catch (_) {
      return null;
    } finally {
      stopwatch.stop();
    }
  }
}

bool _isBiliVideoHost(String host) {
  return host.endsWith('.bilivideo.com') || host.endsWith('.bilivideo.cn') || host.endsWith('.akamaized.net');
}

bool _isHdslbImageHost(String host) => RegExp(r'^i\d\.hdslb\.com$').hasMatch(host);
