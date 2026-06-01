// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepositoryImpl,
          ProfileRepositoryImpl,
          ProfileRepositoryImpl
        >
    with $Provider<ProfileRepositoryImpl> {
  ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepositoryImpl> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileRepositoryImpl create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepositoryImpl>(value),
    );
  }
}

String _$profileRepositoryHash() => r'b3fe4281a0fd0c1d53121efcebf452cc82d6f350';
