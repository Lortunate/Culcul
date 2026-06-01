// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_space_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserSpaceNotifier)
final userSpaceProvider = UserSpaceNotifierFamily._();

final class UserSpaceNotifierProvider
    extends $AsyncNotifierProvider<UserSpaceNotifier, ProfileUser> {
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

String _$userSpaceNotifierHash() => r'56d2d2ebe59893830f4c569eb6afb40a08c781a6';

final class UserSpaceNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserSpaceNotifier,
          AsyncValue<ProfileUser>,
          ProfileUser,
          FutureOr<ProfileUser>,
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

abstract class _$UserSpaceNotifier extends $AsyncNotifier<ProfileUser> {
  late final _$args = ref.$arg as String;
  String get mid => _$args;

  FutureOr<ProfileUser> build(String mid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProfileUser>, ProfileUser>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileUser>, ProfileUser>,
              AsyncValue<ProfileUser>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
