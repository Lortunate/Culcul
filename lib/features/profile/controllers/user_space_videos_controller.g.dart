// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_space_videos_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserSpaceVideosNotifier)
final userSpaceVideosProvider = UserSpaceVideosNotifierFamily._();

final class UserSpaceVideosNotifierProvider
    extends
        $AsyncNotifierProvider<
          UserSpaceVideosNotifier,
          List<UserSpaceVideoModel>
        > {
  UserSpaceVideosNotifierProvider._({
    required UserSpaceVideosNotifierFamily super.from,
    required (int, {String order}) super.argument,
  }) : super(
         retry: null,
         name: r'userSpaceVideosProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userSpaceVideosNotifierHash();

  @override
  String toString() {
    return r'userSpaceVideosProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  UserSpaceVideosNotifier create() => UserSpaceVideosNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserSpaceVideosNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpaceVideosNotifierHash() =>
    r'43695f7e71b8f4c7c0a2d81433b847f18ce7d17c';

final class UserSpaceVideosNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserSpaceVideosNotifier,
          AsyncValue<List<UserSpaceVideoModel>>,
          List<UserSpaceVideoModel>,
          FutureOr<List<UserSpaceVideoModel>>,
          (int, {String order})
        > {
  UserSpaceVideosNotifierFamily._()
    : super(
        retry: null,
        name: r'userSpaceVideosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  UserSpaceVideosNotifierProvider call(int mid, {String order = 'pubdate'}) =>
      UserSpaceVideosNotifierProvider._(
        argument: (mid, order: order),
        from: this,
      );

  @override
  String toString() => r'userSpaceVideosProvider';
}

abstract class _$UserSpaceVideosNotifier
    extends $AsyncNotifier<List<UserSpaceVideoModel>> {
  late final _$args = ref.$arg as (int, {String order});
  int get mid => _$args.$1;
  String get order => _$args.order;

  FutureOr<List<UserSpaceVideoModel>> build(
    int mid, {
    String order = 'pubdate',
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<UserSpaceVideoModel>>,
              List<UserSpaceVideoModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<UserSpaceVideoModel>>,
                List<UserSpaceVideoModel>
              >,
              AsyncValue<List<UserSpaceVideoModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, order: _$args.order));
  }
}
