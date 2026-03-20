// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danmaku_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DanmakuProvider)
final danmakuProviderProvider = DanmakuProviderProvider._();

final class DanmakuProviderProvider
    extends $AsyncNotifierProvider<DanmakuProvider, void> {
  DanmakuProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'danmakuProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$danmakuProviderHash();

  @$internal
  @override
  DanmakuProvider create() => DanmakuProvider();
}

String _$danmakuProviderHash() => r'e966ac37990b2427ec0423e0739f2ab9c561e2a8';

abstract class _$DanmakuProvider extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
