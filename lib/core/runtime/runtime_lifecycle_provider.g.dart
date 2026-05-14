// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runtime_lifecycle_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RuntimeLifecycle)
final runtimeLifecycleProvider = RuntimeLifecycleProvider._();

final class RuntimeLifecycleProvider
    extends $NotifierProvider<RuntimeLifecycle, AppLifecycleState> {
  RuntimeLifecycleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runtimeLifecycleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runtimeLifecycleHash();

  @$internal
  @override
  RuntimeLifecycle create() => RuntimeLifecycle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLifecycleState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLifecycleState>(value),
    );
  }
}

String _$runtimeLifecycleHash() => r'c32e664c01646c95a54096ace1e8682d12bcf25b';

abstract class _$RuntimeLifecycle extends $Notifier<AppLifecycleState> {
  AppLifecycleState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppLifecycleState, AppLifecycleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLifecycleState, AppLifecycleState>,
              AppLifecycleState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
