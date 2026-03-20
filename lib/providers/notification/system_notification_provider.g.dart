// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SystemNotificationList)
final systemNotificationListProvider = SystemNotificationListProvider._();

final class SystemNotificationListProvider
    extends
        $AsyncNotifierProvider<
          SystemNotificationList,
          List<SystemNotificationItem>
        > {
  SystemNotificationListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemNotificationListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemNotificationListHash();

  @$internal
  @override
  SystemNotificationList create() => SystemNotificationList();
}

String _$systemNotificationListHash() =>
    r'c086e5c8427c26ae214e8a2d35f94ac74adefe23';

abstract class _$SystemNotificationList
    extends $AsyncNotifier<List<SystemNotificationItem>> {
  FutureOr<List<SystemNotificationItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<SystemNotificationItem>>,
              List<SystemNotificationItem>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SystemNotificationItem>>,
                List<SystemNotificationItem>
              >,
              AsyncValue<List<SystemNotificationItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
