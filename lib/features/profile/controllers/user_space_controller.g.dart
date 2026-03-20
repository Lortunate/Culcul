// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_space_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserSpaceNotifier)
final userSpaceProvider = UserSpaceNotifierFamily._();

final class UserSpaceNotifierProvider
    extends $AsyncNotifierProvider<UserSpaceNotifier, UserProfile> {
  UserSpaceNotifierProvider._({
    required UserSpaceNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userSpaceProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userSpaceNotifierHash();

  @override
  String toString() {
    return r'userSpaceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserSpaceNotifier create() => UserSpaceNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserSpaceNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpaceNotifierHash() => r'e0c0a62e7040492fd54d71f54da760f00bf6a454';

final class UserSpaceNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserSpaceNotifier,
          AsyncValue<UserProfile>,
          UserProfile,
          FutureOr<UserProfile>,
          String
        > {
  UserSpaceNotifierFamily._()
    : super(
        retry: null,
        name: r'userSpaceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  UserSpaceNotifierProvider call(String mid) =>
      UserSpaceNotifierProvider._(argument: mid, from: this);

  @override
  String toString() => r'userSpaceProvider';
}

abstract class _$UserSpaceNotifier extends $AsyncNotifier<UserProfile> {
  late final _$args = ref.$arg as String;
  String get mid => _$args;

  FutureOr<UserProfile> build(String mid);
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
