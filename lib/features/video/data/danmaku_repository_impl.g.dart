// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danmaku_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(danmakuRepository)
final danmakuRepositoryProvider = DanmakuRepositoryProvider._();

final class DanmakuRepositoryProvider
    extends
        $FunctionalProvider<
          DanmakuRepositoryImpl,
          DanmakuRepositoryImpl,
          DanmakuRepositoryImpl
        >
    with $Provider<DanmakuRepositoryImpl> {
  DanmakuRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'danmakuRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$danmakuRepositoryHash();

  @$internal
  @override
  $ProviderElement<DanmakuRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DanmakuRepositoryImpl create(Ref ref) {
    return danmakuRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DanmakuRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DanmakuRepositoryImpl>(value),
    );
  }
}

String _$danmakuRepositoryHash() => r'904015609bca9cba2ce4e3221712c4d2df126948';
