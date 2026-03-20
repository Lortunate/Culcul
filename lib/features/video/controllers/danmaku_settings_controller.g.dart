// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danmaku_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DanmakuSettingsController)
final danmakuSettingsControllerProvider = DanmakuSettingsControllerProvider._();

final class DanmakuSettingsControllerProvider
    extends $NotifierProvider<DanmakuSettingsController, DanmakuSettings> {
  DanmakuSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'danmakuSettingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$danmakuSettingsControllerHash();

  @$internal
  @override
  DanmakuSettingsController create() => DanmakuSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DanmakuSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DanmakuSettings>(value),
    );
  }
}

String _$danmakuSettingsControllerHash() =>
    r'2aeef48b9c0b7e2ba79ade3d5d35cf57ac92e3a6';

abstract class _$DanmakuSettingsController extends $Notifier<DanmakuSettings> {
  DanmakuSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DanmakuSettings, DanmakuSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DanmakuSettings, DanmakuSettings>,
              DanmakuSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
