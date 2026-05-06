import 'dart:async';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        connectTimeout: Duration(seconds: 8),
        receiveTimeout: Duration(seconds: 10),
        sendTimeout: Duration(seconds: 8),
        connectionIdleTimeout: Duration(seconds: 90),
        retryMaxAttempts: 2,
        retryBaseDelayMs: 180,
        retryMaxDelayMs: 1800,
        prefetchLimitFactor: 1.0,
        prefetchMaxConcurrency: 2,
        prefetchQueueCapacity: 80,
        prefetchKeyTtl: Duration(minutes: 15),
        prefetchLruCapacity: 500,
      ),
      NetworkQualityProfile.normal => const NetworkQualityPolicy(
        profile: NetworkQualityProfile.normal,
        connectTimeout: Duration(seconds: 12),
        receiveTimeout: Duration(seconds: 14),
        sendTimeout: Duration(seconds: 12),
        connectionIdleTimeout: Duration(seconds: 75),
        retryMaxAttempts: 3,
        retryBaseDelayMs: 250,
        retryMaxDelayMs: 2500,
        prefetchLimitFactor: 1.0,
        prefetchMaxConcurrency: 2,
        prefetchQueueCapacity: 60,
        prefetchKeyTtl: Duration(minutes: 15),
        prefetchLruCapacity: 500,
      ),
      NetworkQualityProfile.constrained => const NetworkQualityPolicy(
        profile: NetworkQualityProfile.constrained,
        connectTimeout: Duration(seconds: 18),
        receiveTimeout: Duration(seconds: 20),
        sendTimeout: Duration(seconds: 18),
        connectionIdleTimeout: Duration(seconds: 45),
        retryMaxAttempts: 4,
        retryBaseDelayMs: 320,
        retryMaxDelayMs: 3200,
        prefetchLimitFactor: 0.5,
        prefetchMaxConcurrency: 1,
        prefetchQueueCapacity: 30,
        prefetchKeyTtl: Duration(minutes: 10),
        prefetchLruCapacity: 300,
      ),
    };
  }
}

final _connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final networkQualityProfileProvider = StreamProvider<NetworkQualityProfile>((ref) {
  final connectivity = ref.watch(_connectivityProvider);
  return _watchConnectivityProfiles(connectivity);
});

final networkQualityPolicyProvider = Provider<NetworkQualityPolicy>((ref) {
  final profile = ref.watch(
    networkQualityProfileProvider.select(
      (state) => state.maybeWhen(
        data: (value) => value,
        orElse: () => NetworkQualityProfile.normal,
      ),
    ),
  );
  return NetworkQualityPolicy.forProfile(profile);
});

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
