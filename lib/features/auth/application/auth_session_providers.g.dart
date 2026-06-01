// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

final class CurrentUserProvider
    extends $FunctionalProvider<UserSession?, UserSession?, UserSession?>
    with $Provider<UserSession?> {
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<UserSession?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserSession? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserSession? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserSession?>(value),
    );
  }
}

String _$currentUserHash() => r'd3e960d9657e3258b99370690a1c0904cce16ea1';
