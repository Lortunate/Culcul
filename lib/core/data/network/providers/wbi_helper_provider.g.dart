// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wbi_helper_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(wbiHelper)
final wbiHelperProvider = WbiHelperProvider._();

final class WbiHelperProvider extends $FunctionalProvider<WbiHelper, WbiHelper, WbiHelper>
    with $Provider<WbiHelper> {
  WbiHelperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wbiHelperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wbiHelperHash();

  @$internal
  @override
  $ProviderElement<WbiHelper> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WbiHelper create(Ref ref) {
    return wbiHelper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WbiHelper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WbiHelper>(value),
    );
  }
}

String _$wbiHelperHash() => r'97d52d44e6b6c8e371ca81233a02e2b7a93bde12';
