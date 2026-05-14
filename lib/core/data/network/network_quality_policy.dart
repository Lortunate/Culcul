import 'dart:async';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_quality_policy.g.dart';

enum NetworkQualityProfile { fast, normal, constrained }

@immutable
class NetworkQualityPolicy {
  final NetworkQualityProfile profile;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final Duration connectionIdleTimeout;
  final int retryMaxAttempts;
  final int retryBaseDelayMs;
  final int retryMaxDelayMs;
  final double prefetchLimitFactor;
  final int prefetchMaxConcurrency;
  final int prefetchQueueCapacity;
  final Duration prefetchKeyTtl;
  final int prefetchLruCapacity;

  const NetworkQualityPolicy({
    required this.profile,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.sendTimeout,
    required this.connectionIdleTimeout,
    required this.retryMaxAttempts,
    required this.retryBaseDelayMs,
    required this.retryMaxDelayMs,
    required this.prefetchLimitFactor,
    required this.prefetchMaxConcurrency,
    required this.prefetchQueueCapacity,
    required this.prefetchKeyTtl,
    required this.prefetchLruCapacity,
  });

  bool get isConstrained => profile == NetworkQualityProfile.constrained;

  int resolvePrefetchLimit(int baseLimit) {
    if (baseLimit <= 0) {
      return 0;
    }
    return math.max(1, (baseLimit * prefetchLimitFactor).round());
  }

  static NetworkQualityPolicy forProfile(NetworkQualityProfile profile) {
    return switch (profile) {
      NetworkQualityProfile.fast => const NetworkQualityPolicy(
        profile: NetworkQualityProfile.fast,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 8),
        sendTimeout: Duration(seconds: 5),
        connectionIdleTimeout: Duration(seconds: 120),
        retryMaxAttempts: 2,
        retryBaseDelayMs: 150,
        retryMaxDelayMs: 1500,
        prefetchLimitFactor: 1.0,
        prefetchMaxConcurrency: 3,
        prefetchQueueCapacity: 100,
        prefetchKeyTtl: Duration(minutes: 20),
        prefetchLruCapacity: 600,
      ),
      NetworkQualityProfile.normal => const NetworkQualityPolicy(
        profile: NetworkQualityProfile.normal,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 12),
        sendTimeout: Duration(seconds: 10),
        connectionIdleTimeout: Duration(seconds: 90),
        retryMaxAttempts: 3,
        retryBaseDelayMs: 200,
        retryMaxDelayMs: 2000,
        prefetchLimitFactor: 1.0,
        prefetchMaxConcurrency: 2,
        prefetchQueueCapacity: 60,
        prefetchKeyTtl: Duration(minutes: 15),
        prefetchLruCapacity: 500,
      ),
      NetworkQualityProfile.constrained => const NetworkQualityPolicy(
        profile: NetworkQualityProfile.constrained,
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 18),
        sendTimeout: Duration(seconds: 15),
        connectionIdleTimeout: Duration(seconds: 45),
        retryMaxAttempts: 3,
        retryBaseDelayMs: 300,
        retryMaxDelayMs: 3000,
        prefetchLimitFactor: 0.5,
        prefetchMaxConcurrency: 1,
        prefetchQueueCapacity: 30,
        prefetchKeyTtl: Duration(minutes: 10),
        prefetchLruCapacity: 300,
      ),
    };
  }
}

@Riverpod(keepAlive: true)
Stream<NetworkQualityProfile> networkQualityProfile(Ref ref) {
  final connectivity = Connectivity();
  return _watchConnectivityProfiles(connectivity);
}

@Riverpod(keepAlive: true)
NetworkQualityPolicy networkQualityPolicy(Ref ref) {
  final profile = ref
      .watch(networkQualityProfileProvider)
      .maybeWhen(data: (value) => value, orElse: () => NetworkQualityProfile.normal);
  return NetworkQualityPolicy.forProfile(profile);
}

Stream<NetworkQualityProfile> _watchConnectivityProfiles(
  Connectivity connectivity,
) async* {
  try {
    final initial = await connectivity.checkConnectivity();
    yield _profileFromConnectivityResult(initial);
  } catch (_) {
    yield NetworkQualityProfile.normal;
  }

  yield* connectivity.onConnectivityChanged
      .map(_profileFromConnectivityResult)
      .distinct();
}

NetworkQualityProfile _profileFromConnectivityResult(Object value) {
  final normalized = _normalizeResults(value);
  if (normalized.isEmpty) {
    return NetworkQualityProfile.constrained;
  }

  if (normalized.contains(ConnectivityResult.wifi) ||
      normalized.contains(ConnectivityResult.ethernet)) {
    return NetworkQualityProfile.fast;
  }

  if (normalized.contains(ConnectivityResult.mobile)) {
    return NetworkQualityProfile.normal;
  }

  return NetworkQualityProfile.constrained;
}

List<ConnectivityResult> _normalizeResults(Object value) {
  if (value is ConnectivityResult) {
    return <ConnectivityResult>[value];
  }
  if (value is List<ConnectivityResult>) {
    return value;
  }
  if (value is Iterable) {
    return value.whereType<ConnectivityResult>().toList(growable: false);
  }
  return const <ConnectivityResult>[];
}
