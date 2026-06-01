// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepositoryImpl,
          NotificationRepositoryImpl,
          NotificationRepositoryImpl
        >
    with $Provider<NotificationRepositoryImpl> {
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationRepositoryImpl create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepositoryImpl>(value),
    );
  }
}

String _$notificationRepositoryHash() => r'73f946c785f002090cf96d1f61ed9b0613ab358b';
