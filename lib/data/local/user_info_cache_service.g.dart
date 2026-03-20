// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_cache_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userInfoCacheService)
final userInfoCacheServiceProvider = UserInfoCacheServiceProvider._();

final class UserInfoCacheServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserInfoCacheService>,
          UserInfoCacheService,
          FutureOr<UserInfoCacheService>
        >
    with
        $FutureModifier<UserInfoCacheService>,
        $FutureProvider<UserInfoCacheService> {
  UserInfoCacheServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userInfoCacheServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userInfoCacheServiceHash();

  @$internal
  @override
  $FutureProviderElement<UserInfoCacheService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserInfoCacheService> create(Ref ref) {
    return userInfoCacheService(ref);
  }
}

String _$userInfoCacheServiceHash() =>
    r'5e5fbeb5d6e4cad92e2001df200daebf3c01bf3f';
