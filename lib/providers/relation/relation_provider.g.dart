// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Followings)
final followingsProvider = FollowingsFamily._();

final class FollowingsProvider
    extends $AsyncNotifierProvider<Followings, List<RelationUser>> {
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

String _$followingsHash() => r'932a6a3cb7bed51cb832ceb72f2c96180f56e026';

final class FollowingsFamily extends $Family
    with
        $ClassFamilyOverride<
          Followings,
          AsyncValue<List<RelationUser>>,
          List<RelationUser>,
          FutureOr<List<RelationUser>>,
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

  FollowingsProvider call(int vmid) =>
      FollowingsProvider._(argument: vmid, from: this);

  @override
  String toString() => r'followingsProvider';
}

abstract class _$Followings extends $AsyncNotifier<List<RelationUser>> {
  late final _$args = ref.$arg as int;
  int get vmid => _$args;

  FutureOr<List<RelationUser>> build(int vmid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<RelationUser>>, List<RelationUser>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RelationUser>>, List<RelationUser>>,
              AsyncValue<List<RelationUser>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(Followers)
final followersProvider = FollowersFamily._();

final class FollowersProvider
    extends $AsyncNotifierProvider<Followers, List<RelationUser>> {
  FollowersProvider._({
    required FollowersFamily super.from,
    required int super.argument,
  }) : super(
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

String _$followersHash() => r'232dcce34eab8dd9e18cde2972b4927ec7d3c40b';

final class FollowersFamily extends $Family
    with
        $ClassFamilyOverride<
          Followers,
          AsyncValue<List<RelationUser>>,
          List<RelationUser>,
          FutureOr<List<RelationUser>>,
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

  FollowersProvider call(int vmid) =>
      FollowersProvider._(argument: vmid, from: this);

  @override
  String toString() => r'followersProvider';
}

abstract class _$Followers extends $AsyncNotifier<List<RelationUser>> {
  late final _$args = ref.$arg as int;
  int get vmid => _$args;

  FutureOr<List<RelationUser>> build(int vmid);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<RelationUser>>, List<RelationUser>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RelationUser>>, List<RelationUser>>,
              AsyncValue<List<RelationUser>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
