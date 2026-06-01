// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_lifecycle_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sessionCookieRefresher)
final sessionCookieRefresherProvider = SessionCookieRefresherProvider._();

final class SessionCookieRefresherProvider
    extends
        $FunctionalProvider<
          SessionCookieRefresher,
          SessionCookieRefresher,
          SessionCookieRefresher
        >
    with $Provider<SessionCookieRefresher> {
  SessionCookieRefresherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionCookieRefresherProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionCookieRefresherHash();

  @$internal
  @override
  $ProviderElement<SessionCookieRefresher> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionCookieRefresher create(Ref ref) {
    return sessionCookieRefresher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionCookieRefresher value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionCookieRefresher>(value),
    );
  }
}

String _$sessionCookieRefresherHash() => r'f46841e6784c5cba224368364f34a2163e10ef2f';

@ProviderFor(sessionLogoutCleaner)
final sessionLogoutCleanerProvider = SessionLogoutCleanerProvider._();

final class SessionLogoutCleanerProvider
    extends
        $FunctionalProvider<
          SessionLogoutCleaner,
          SessionLogoutCleaner,
          SessionLogoutCleaner
        >
    with $Provider<SessionLogoutCleaner> {
  SessionLogoutCleanerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionLogoutCleanerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionLogoutCleanerHash();

  @$internal
  @override
  $ProviderElement<SessionLogoutCleaner> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionLogoutCleaner create(Ref ref) {
    return sessionLogoutCleaner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionLogoutCleaner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionLogoutCleaner>(value),
    );
  }
}

String _$sessionLogoutCleanerHash() => r'ad3f434f9202628d55ce43b868f03457357cb2e6';
