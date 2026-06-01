// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myProfile)
final myProfileProvider = MyProfileProvider._();

final class MyProfileProvider
    extends
        $FunctionalProvider<AsyncValue<ProfileUser>, ProfileUser, FutureOr<ProfileUser>>
    with $FutureModifier<ProfileUser>, $FutureProvider<ProfileUser> {
  MyProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProfileHash();

  @$internal
  @override
  $FutureProviderElement<ProfileUser> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ProfileUser> create(Ref ref) {
    return myProfile(ref);
  }
}

String _$myProfileHash() => r'fc953e2bfa0c1e2170036dc76e7b9a9919d35600';
