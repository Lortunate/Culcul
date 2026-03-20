// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_events.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeTabTap)
final homeTabTapProvider = HomeTabTapProvider._();

final class HomeTabTapProvider
    extends $NotifierProvider<HomeTabTap, HomeTabTapEvent?> {
  HomeTabTapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeTabTapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeTabTapHash();

  @$internal
  @override
  HomeTabTap create() => HomeTabTap();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeTabTapEvent? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeTabTapEvent?>(value),
    );
  }
}

String _$homeTabTapHash() => r'f58964ba0be143fa8a789368bb72b253c4024e2d';

abstract class _$HomeTabTap extends $Notifier<HomeTabTapEvent?> {
  HomeTabTapEvent? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HomeTabTapEvent?, HomeTabTapEvent?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeTabTapEvent?, HomeTabTapEvent?>,
              HomeTabTapEvent?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
