// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/models/relation_user_contract.dart';
import 'package:culcul/features/profile/relation_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_view_model.g.dart';

@riverpod
class Followings extends _$Followings with OffsetPagedAsyncNotifier<ProfileRelationUser> {
  late int _vmid;

  @override
  Future<List<ProfileRelationUser>> build(int vmid) async {
    _vmid = vmid;
    return buildFirstPage();
  }

  @override
  Future<List<ProfileRelationUser>> fetchPage(int page) async {
    final result = await ref
        .read(relationServiceProvider)
        .getFollowings(_vmid, page: page);
    return result.when(success: (data) => data, failure: (error) => throw error);
  }

  @override
  Object itemId(ProfileRelationUser item) => item.mid;

  @override
  bool hasMoreAfterPage(List<ProfileRelationUser> items) =>
      items.length >= RelationApi.defaultPageSize;

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

  @override
  Future<List<ProfileRelationUser>> build(int vmid) async {
    _vmid = vmid;
    return buildFirstPage();
  }

  @override
  Future<List<ProfileRelationUser>> fetchPage(int page) async {
    final result = await ref
        .read(relationServiceProvider)
        .getFollowers(_vmid, page: page);
    return result.when(success: (data) => data, failure: (error) => throw error);
  }

  @override
  Object itemId(ProfileRelationUser item) => item.mid;

  @override
  bool hasMoreAfterPage(List<ProfileRelationUser> items) =>
      items.length >= RelationApi.defaultPageSize;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}
