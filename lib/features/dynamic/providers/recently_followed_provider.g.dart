// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_followed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecentlyFollowed)
final recentlyFollowedProvider = RecentlyFollowedProvider._();

final class RecentlyFollowedProvider
    extends $AsyncNotifierProvider<RecentlyFollowed, List<RelationUser>> {
  RecentlyFollowedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentlyFollowedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentlyFollowedHash();

  @$internal
  @override
  RecentlyFollowed create() => RecentlyFollowed();
}

String _$recentlyFollowedHash() => r'd87190f5ab9017a5a4869c7d92847bc4c8f1e222';

abstract class _$RecentlyFollowed extends $AsyncNotifier<List<RelationUser>> {
  FutureOr<List<RelationUser>> build();
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
    element.handleCreate(ref, build);
  }
}
