import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'endpoint_policy.freezed.dart';

enum EndpointRequestClass {
  interactiveRead,
  backgroundRead,
  mediaMetadata,
  search,
  auth,
  mutation,
  download,
}

@freezed
sealed class EndpointPolicy with _$EndpointPolicy {
  static const String requestClassExtra = 'endpoint_request_class';
  static const String resolvedPolicyExtra = 'resolved_endpoint_policy';
  static const String disableRetryExtra = 'disable_retry';
  static const String forceRetryableExtra = 'force_retryable';
  static const String cacheTtlOverrideExtra = 'cache_ttl_override';

  const EndpointPolicy._();

  const factory EndpointPolicy({
    required EndpointRequestClass requestClass,
    required Duration? cacheTtl,
    required bool allowStaleCache,
    required int retryMaxAttempts,
    required Set<int> retryableStatuses,
    required bool dedupEnabled,
    required bool retryUnsafeMethods,
    required bool allowPrefetch,
  }) = _EndpointPolicy;

  bool get hasCache => cacheTtl != null;

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
    final cacheTtl = _cacheTtlFor(options);
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
    if (runtimePolicy.profile == PerformanceProfile.background) {
      return policy.copyWith(
        retryMaxAttempts: policy.retryMaxAttempts.clamp(0, 1),
        allowPrefetch: false,
        allowStaleCache: true,
      );
    }

    if (runtimePolicy.profile == PerformanceProfile.constrained) {
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

  Duration? _cacheTtlFor(RequestOptions options) {
    final override = options.extra[EndpointPolicy.cacheTtlOverrideExtra];
    if (override is Duration) {
      return override;
    }
    final seconds = ApiConstants.cacheConfig[options.path];
    return seconds == null ? null : Duration(seconds: seconds);
  }
}
