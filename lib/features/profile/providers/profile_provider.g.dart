// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myProfile)
final myProfileProvider = MyProfileProvider._();

final class MyProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserProfile>,
          UserProfile,
          FutureOr<UserProfile>
        >
    with $FutureModifier<UserProfile>, $FutureProvider<UserProfile> {
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
  $FutureProviderElement<UserProfile> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserProfile> create(Ref ref) {
    return myProfile(ref);
  }
}

String _$myProfileHash() => r'74b0c60465ffaf6b73d39ecfeaf3138ece4a13fb';

@ProviderFor(UserProfileNotifier)
final userProfileProvider = UserProfileNotifierFamily._();

final class UserProfileNotifierProvider
    extends $AsyncNotifierProvider<UserProfileNotifier, UserProfile> {
  UserProfileNotifierProvider._({
    required UserProfileNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userProfileNotifierHash();

  @override
  String toString() {
    return r'userProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserProfileNotifier create() => UserProfileNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserProfileNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userProfileNotifierHash() =>
    r'7de4ac0fcbd25c75a177d2ce2dc86ab4f80cc1f3';

final class UserProfileNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserProfileNotifier,
          AsyncValue<UserProfile>,
          UserProfile,
          FutureOr<UserProfile>,
          String
        > {
  UserProfileNotifierFamily._()
    : super(
        retry: null,
        name: r'userProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserProfileNotifierProvider call(String userId) =>
      UserProfileNotifierProvider._(argument: userId, from: this);

  @override
  String toString() => r'userProfileProvider';
}

abstract class _$UserProfileNotifier extends $AsyncNotifier<UserProfile> {
  late final _$args = ref.$arg as String;
  String get userId => _$args;

  FutureOr<UserProfile> build(String userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserProfile>, UserProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfile>, UserProfile>,
              AsyncValue<UserProfile>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
