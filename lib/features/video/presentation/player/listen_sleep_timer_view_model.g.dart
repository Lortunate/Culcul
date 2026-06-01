// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listen_sleep_timer_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listenSleepTimerOnExpire)
final listenSleepTimerOnExpireProvider = ListenSleepTimerOnExpireProvider._();

final class ListenSleepTimerOnExpireProvider
    extends
        $FunctionalProvider<
          Future<void> Function(),
          Future<void> Function(),
          Future<void> Function()
        >
    with $Provider<Future<void> Function()> {
  ListenSleepTimerOnExpireProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listenSleepTimerOnExpireProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listenSleepTimerOnExpireHash();

  @$internal
  @override
  $ProviderElement<Future<void> Function()> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Future<void> Function() create(Ref ref) {
    return listenSleepTimerOnExpire(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<void> Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<void> Function()>(value),
    );
  }
}

String _$listenSleepTimerOnExpireHash() => r'85262035fb7a5d7351e0e87aeb7758d49507df6a';

@ProviderFor(ListenSleepTimerController)
final listenSleepTimerControllerProvider = ListenSleepTimerControllerProvider._();

final class ListenSleepTimerControllerProvider
    extends $NotifierProvider<ListenSleepTimerController, ListenSleepTimerState> {
  ListenSleepTimerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listenSleepTimerControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listenSleepTimerControllerHash();

  @$internal
  @override
  ListenSleepTimerController create() => ListenSleepTimerController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListenSleepTimerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListenSleepTimerState>(value),
    );
  }
}

String _$listenSleepTimerControllerHash() => r'47bfe31145a7decfbc302f646d611a724f3e7ee0';

abstract class _$ListenSleepTimerController extends $Notifier<ListenSleepTimerState> {
  ListenSleepTimerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ListenSleepTimerState, ListenSleepTimerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ListenSleepTimerState, ListenSleepTimerState>,
              ListenSleepTimerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
