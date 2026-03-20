// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storageBox)
final storageBoxProvider = StorageBoxProvider._();

final class StorageBoxProvider
    extends $FunctionalProvider<Box<dynamic>, Box<dynamic>, Box<dynamic>>
    with $Provider<Box<dynamic>> {
  StorageBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageBoxHash();

  @$internal
  @override
  $ProviderElement<Box<dynamic>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Box<dynamic> create(Ref ref) {
    return storageBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<dynamic>>(value),
    );
  }
}

String _$storageBoxHash() => r'50d7613efd4338c78f127fc608a6ba8f59e6a05a';
