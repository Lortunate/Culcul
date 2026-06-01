// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_lifecycle_sync_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationLifecycleSync)
final notificationLifecycleSyncProvider = NotificationLifecycleSyncProvider._();

final class NotificationLifecycleSyncProvider
    extends $NotifierProvider<NotificationLifecycleSync, bool> {
  NotificationLifecycleSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationLifecycleSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationLifecycleSyncHash();

  @$internal
  @override
  NotificationLifecycleSync create() => NotificationLifecycleSync();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$notificationLifecycleSyncHash() => r'465a5e2ad894b4b62afd9a5b7495140cfd982d57';

abstract class _$NotificationLifecycleSync extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
