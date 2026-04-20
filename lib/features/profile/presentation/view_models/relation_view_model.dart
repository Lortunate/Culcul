// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/shared/pagination/paged_async_notifier.dart';
import 'package:culcul/shared/contracts/relation_user_contract.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_view_model.g.dart';

@riverpod
class Followings extends _$Followings with OffsetPagedAsyncNotifier<ProfileRelationUser> {
  late int _vmid;
  static const _pageSize = 50;

  @override
  Future<List<ProfileRelationUser>> build(int vmid) async {
    _vmid = vmid;
    return buildFirstPage();
  }

  @override
  Future<List<ProfileRelationUser>> fetchPage(int page) async {
    final result = await ref
        .read(relationRepositoryProvider)
        .getFollowings(_vmid, page: page);
    return result.dataOrNull ?? const <ProfileRelationUser>[];
  }

  @override
  Object itemId(ProfileRelationUser item) => item.mid;

  @override
  bool hasMoreAfterPage(List<ProfileRelationUser> items) => items.length >= _pageSize;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}

@riverpod
class Followers extends _$Followers with OffsetPagedAsyncNotifier<ProfileRelationUser> {
  late int _vmid;
  static const _pageSize = 50;

  @override
  Future<List<ProfileRelationUser>> build(int vmid) async {
    _vmid = vmid;
    return buildFirstPage();
  }

  @override
  Future<List<ProfileRelationUser>> fetchPage(int page) async {
    final result = await ref
        .read(relationRepositoryProvider)
        .getFollowers(_vmid, page: page);
    return result.dataOrNull ?? const <ProfileRelationUser>[];
  }

  @override
  Object itemId(ProfileRelationUser item) => item.mid;

  @override
  bool hasMoreAfterPage(List<ProfileRelationUser> items) => items.length >= _pageSize;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}
