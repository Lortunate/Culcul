// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Followings)
final followingsProvider = FollowingsFamily._();

final class FollowingsProvider
    extends $AsyncNotifierProvider<Followings, List<ProfileRelationUser>> {
  FollowingsProvider._({
    required FollowingsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'followingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$followingsHash();

  @override
  String toString() {
    return r'followingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Followings create() => Followings();

  @override
  bool operator ==(Object other) {
    return other is FollowingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followingsHash() => r'2348120e68860f57c83a879902dbb410f094ab5a';

final class FollowingsFamily extends $Family
    with
        $ClassFamilyOverride<
          Followings,
          AsyncValue<List<ProfileRelationUser>>,
          List<ProfileRelationUser>,
          FutureOr<List<ProfileRelationUser>>,
          int
        > {
  FollowingsFamily._()
    : super(
        retry: null,
        name: r'followingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FollowingsProvider call(int vmid) => FollowingsProvider._(argument: vmid, from: this);

  @override
  String toString() => r'followingsProvider';
}

abstract class _$Followings extends $AsyncNotifier<List<ProfileRelationUser>> {
  late final _$args = ref.$arg as int;
  int get vmid => _$args;

  FutureOr<List<ProfileRelationUser>> build(int vmid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ProfileRelationUser>>, List<ProfileRelationUser>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ProfileRelationUser>>,
                List<ProfileRelationUser>
              >,
              AsyncValue<List<ProfileRelationUser>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(Followers)
final followersProvider = FollowersFamily._();

final class FollowersProvider
    extends $AsyncNotifierProvider<Followers, List<ProfileRelationUser>> {
  FollowersProvider._({required FollowersFamily super.from, required int super.argument})
    : super(
        retry: null,
        name: r'followersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$followersHash();

  @override
  String toString() {
    return r'followersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Followers create() => Followers();

  @override
  bool operator ==(Object other) {
    return other is FollowersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followersHash() => r'576233a0ecc39292f8235cbacf27e2190c692499';

final class FollowersFamily extends $Family
    with
        $ClassFamilyOverride<
          Followers,
          AsyncValue<List<ProfileRelationUser>>,
          List<ProfileRelationUser>,
          FutureOr<List<ProfileRelationUser>>,
          int
        > {
  FollowersFamily._()
    : super(
        retry: null,
        name: r'followersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FollowersProvider call(int vmid) => FollowersProvider._(argument: vmid, from: this);

  @override
  String toString() => r'followersProvider';
}

abstract class _$Followers extends $AsyncNotifier<List<ProfileRelationUser>> {
  late final _$args = ref.$arg as int;
  int get vmid => _$args;

  FutureOr<List<ProfileRelationUser>> build(int vmid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ProfileRelationUser>>, List<ProfileRelationUser>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ProfileRelationUser>>,
                List<ProfileRelationUser>
              >,
              AsyncValue<List<ProfileRelationUser>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
