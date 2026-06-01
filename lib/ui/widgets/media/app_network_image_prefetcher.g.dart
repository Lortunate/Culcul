// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_network_image_prefetcher.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appNetworkImagePrefetcher)
final appNetworkImagePrefetcherProvider = AppNetworkImagePrefetcherProvider._();

final class AppNetworkImagePrefetcherProvider
    extends
        $FunctionalProvider<
          AppNetworkImagePrefetcher,
          AppNetworkImagePrefetcher,
          AppNetworkImagePrefetcher
        >
    with $Provider<AppNetworkImagePrefetcher> {
  AppNetworkImagePrefetcherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appNetworkImagePrefetcherProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appNetworkImagePrefetcherHash();

  @$internal
  @override
  $ProviderElement<AppNetworkImagePrefetcher> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppNetworkImagePrefetcher create(Ref ref) {
    return appNetworkImagePrefetcher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppNetworkImagePrefetcher value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppNetworkImagePrefetcher>(value),
    );
  }
}

String _$appNetworkImagePrefetcherHash() => r'2a49c6a2e083ac0b4d1072e39ef649ef507b18b7';
