import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show setEquals;

enum EndpointRequestClass {
  interactiveRead,
  backgroundRead,
  mediaMetadata,
  search,
  auth,
  mutation,
  download,
}

final class EndpointPolicy {
  static const String requestClassExtra = 'endpoint_request_class';
  static const String resolvedPolicyExtra = 'resolved_endpoint_policy';
  static const String disableRetryExtra = 'disable_retry';
  static const String forceRetryableExtra = 'force_retryable';
  static const String cacheTtlOverrideExtra = 'cache_ttl_override';

  static const Object _cacheTtlSentinel = Object();

  EndpointPolicy({
    required this.requestClass,
    required this.cacheTtl,
    required this.allowStaleCache,
    required this.retryMaxAttempts,
    required Set<int> retryableStatuses,
    required this.dedupEnabled,
    required this.retryUnsafeMethods,
    required this.allowPrefetch,
  }) : retryableStatuses = Set.unmodifiable(retryableStatuses);

  final EndpointRequestClass requestClass;
  final Duration? cacheTtl;
  final bool allowStaleCache;
  final int retryMaxAttempts;
  final Set<int> retryableStatuses;
  final bool dedupEnabled;
  final bool retryUnsafeMethods;
  final bool allowPrefetch;

  bool get hasCache => cacheTtl != null;

  EndpointPolicy copyWith({
    EndpointRequestClass? requestClass,
    Object? cacheTtl = _cacheTtlSentinel,
    bool? allowStaleCache,
    int? retryMaxAttempts,
    Set<int>? retryableStatuses,
    bool? dedupEnabled,
    bool? retryUnsafeMethods,
    bool? allowPrefetch,
  }) {
    return EndpointPolicy(
      requestClass: requestClass ?? this.requestClass,
      cacheTtl: identical(cacheTtl, _cacheTtlSentinel)
          ? this.cacheTtl
          : cacheTtl as Duration?,
      allowStaleCache: allowStaleCache ?? this.allowStaleCache,
      retryMaxAttempts: retryMaxAttempts ?? this.retryMaxAttempts,
      retryableStatuses: retryableStatuses ?? this.retryableStatuses,
      dedupEnabled: dedupEnabled ?? this.dedupEnabled,
      retryUnsafeMethods: retryUnsafeMethods ?? this.retryUnsafeMethods,
      allowPrefetch: allowPrefetch ?? this.allowPrefetch,
    );
  }

  bool canRetry(RequestOptions options, int attempt) {
    if (options.extra[disableRetryExtra] == true) {
      return false;
    }
    if (options.cancelToken?.isCancelled == true) {
      return false;
    }
    if (attempt >= retryMaxAttempts) {
      return false;
    }

    final method = options.method.toUpperCase();
    final isSafeMethod = method == 'GET' || method == 'HEAD' || method == 'OPTIONS';
    final isForcedRetryable = options.extra[forceRetryableExtra] == true;
    return isSafeMethod || isForcedRetryable || retryUnsafeMethods;
  }

  static EndpointPolicy? fromOptions(RequestOptions options) {
    final value = options.extra[resolvedPolicyExtra];
    return value is EndpointPolicy ? value : null;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EndpointPolicy &&
            other.requestClass == requestClass &&
            other.cacheTtl == cacheTtl &&
            other.allowStaleCache == allowStaleCache &&
            other.retryMaxAttempts == retryMaxAttempts &&
            setEquals(other.retryableStatuses, retryableStatuses) &&
            other.dedupEnabled == dedupEnabled &&
            other.retryUnsafeMethods == retryUnsafeMethods &&
            other.allowPrefetch == allowPrefetch;
  }

  @override
  int get hashCode {
    return Object.hash(
      requestClass,
      cacheTtl,
      allowStaleCache,
      retryMaxAttempts,
      Object.hashAllUnordered(retryableStatuses),
      dedupEnabled,
      retryUnsafeMethods,
      allowPrefetch,
    );
  }

  @override
  String toString() {
    return 'EndpointPolicy('
        'requestClass: $requestClass, '
        'cacheTtl: $cacheTtl, '
        'allowStaleCache: $allowStaleCache, '
        'retryMaxAttempts: $retryMaxAttempts, '
        'retryableStatuses: $retryableStatuses, '
        'dedupEnabled: $dedupEnabled, '
        'retryUnsafeMethods: $retryUnsafeMethods, '
        'allowPrefetch: $allowPrefetch'
        ')';
  }
}

class EndpointPolicyResolver {
  final RuntimePerformancePolicy runtimePolicy;

  const EndpointPolicyResolver({required this.runtimePolicy});

  EndpointPolicy resolve(RequestOptions options) {
    final requestClass = _requestClassFor(options);
    final basePolicy = _basePolicyFor(requestClass, options);
    return _applyRuntimePolicy(basePolicy);
  }

  EndpointPolicy _basePolicyFor(
    EndpointRequestClass requestClass,
    RequestOptions options,
  ) {
    final explicitCacheTtl = options.extra[EndpointPolicy.cacheTtlOverrideExtra];
    final configuredCacheTtlSeconds = ApiConstants.cacheConfig[options.path];
    final cacheTtl = explicitCacheTtl is Duration
        ? explicitCacheTtl
        : configuredCacheTtlSeconds == null
        ? null
        : Duration(seconds: configuredCacheTtlSeconds);

    return switch (requestClass) {
      EndpointRequestClass.interactiveRead => EndpointPolicy(
        requestClass: requestClass,
        cacheTtl: cacheTtl,
        allowStaleCache: cacheTtl != null,
        retryMaxAttempts: 2,
        retryableStatuses: const {408, 429, 500, 502, 503, 504},
        dedupEnabled: true,
        retryUnsafeMethods: false,
        allowPrefetch: true,
      ),
      EndpointRequestClass.backgroundRead => EndpointPolicy(
        requestClass: requestClass,
        cacheTtl: cacheTtl,
        allowStaleCache: true,
        retryMaxAttempts: 1,
        retryableStatuses: const {408, 429, 500, 502, 503, 504},
        dedupEnabled: true,
        retryUnsafeMethods: false,
        allowPrefetch: false,
      ),
      EndpointRequestClass.mediaMetadata => EndpointPolicy(
        requestClass: requestClass,
        cacheTtl: cacheTtl ?? const Duration(minutes: 2),
        allowStaleCache: true,
        retryMaxAttempts: 2,
        retryableStatuses: const {408, 429, 500, 502, 503, 504},
        dedupEnabled: true,
        retryUnsafeMethods: false,
        allowPrefetch: runtimePolicy.allowImagePrefetch,
      ),
      EndpointRequestClass.search => EndpointPolicy(
        requestClass: requestClass,
        cacheTtl: cacheTtl ?? const Duration(minutes: 3),
        allowStaleCache: true,
        retryMaxAttempts: 2,
        retryableStatuses: const {408, 429, 500, 502, 503, 504},
        dedupEnabled: true,
        retryUnsafeMethods: false,
        allowPrefetch: true,
      ),
      EndpointRequestClass.auth => EndpointPolicy(
        requestClass: requestClass,
        cacheTtl: null,
        allowStaleCache: false,
        retryMaxAttempts: 1,
        retryableStatuses: const {408, 429, 500, 502, 503, 504},
        dedupEnabled: false,
        retryUnsafeMethods: false,
        allowPrefetch: false,
      ),
      EndpointRequestClass.mutation => EndpointPolicy(
        requestClass: requestClass,
        cacheTtl: null,
        allowStaleCache: false,
        retryMaxAttempts: 0,
        retryableStatuses: const {408, 429, 500, 502, 503, 504},
        dedupEnabled: false,
        retryUnsafeMethods: false,
        allowPrefetch: false,
      ),
      EndpointRequestClass.download => EndpointPolicy(
        requestClass: requestClass,
        cacheTtl: cacheTtl,
        allowStaleCache: true,
        retryMaxAttempts: 2,
        retryableStatuses: const {408, 429, 500, 502, 503, 504},
        dedupEnabled: false,
        retryUnsafeMethods: false,
        allowPrefetch: false,
      ),
    };
  }

  EndpointPolicy _applyRuntimePolicy(EndpointPolicy policy) {
    if (runtimePolicy.profile == PerformanceProfile.background ||
        !runtimePolicy.allowImagePrefetch) {
      return policy.copyWith(
        retryMaxAttempts: policy.retryMaxAttempts.clamp(0, 1),
        allowPrefetch: false,
        allowStaleCache: true,
      );
    }

    return policy;
  }

  EndpointRequestClass _requestClassFor(RequestOptions options) {
    final explicit = options.extra[EndpointPolicy.requestClassExtra];
    if (explicit is EndpointRequestClass) {
      return explicit;
    }

    final method = options.method.toUpperCase();
    if (method != 'GET' && method != 'HEAD' && method != 'OPTIONS') {
      return EndpointRequestClass.mutation;
    }

    final path = options.path;
    if (path.contains('/passport-login/') || path.contains('/login/')) {
      return EndpointRequestClass.auth;
    }
    if (path.contains('/search/')) {
      return EndpointRequestClass.search;
    }
    if (path.contains('/player/') || path.contains('/archive/')) {
      return EndpointRequestClass.mediaMetadata;
    }
    if (path.contains('/download')) {
      return EndpointRequestClass.download;
    }
    return EndpointRequestClass.interactiveRead;
  }
}
