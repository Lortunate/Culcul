// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danmaku_repository.dart';

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
          DanmakuRepository,
          DanmakuRepository,
          DanmakuRepository
        >
    with $Provider<DanmakuRepository> {
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
  $ProviderElement<DanmakuRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DanmakuRepository create(Ref ref) {
    return danmakuRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DanmakuRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DanmakuRepository>(value),
    );
  }
}

String _$danmakuRepositoryHash() => r'dd42d29905c52b8d10834008bdffceb60358abc9';
