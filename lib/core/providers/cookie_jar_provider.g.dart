// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie_jar_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cookieJar)
final cookieJarProvider = CookieJarProvider._();

final class CookieJarProvider
    extends $FunctionalProvider<CookieJar, CookieJar, CookieJar>
    with $Provider<CookieJar> {
  CookieJarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cookieJarProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cookieJarHash();

  @$internal
  @override
  $ProviderElement<CookieJar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CookieJar create(Ref ref) {
    return cookieJar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CookieJar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CookieJar>(value),
    );
  }
}

String _$cookieJarHash() => r'fc8061ad83beb6162d62cabffcb663f534833f66';
