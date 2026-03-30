// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/features/profile/application/use_case/profile_query_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_view_model.g.dart';

@riverpod
class Followings extends _$Followings with OffsetPagedAsyncNotifier<RelationUser> {
  late int _vmid;
  static const _pageSize = 50;

  @override
  Future<List<RelationUser>> build(int vmid) async {
    _vmid = vmid;
    return buildFirstPage();
  }

  @override
  Future<List<RelationUser>> fetchPage(int page, {bool refresh = false}) async {
    final result = await ref
        .read(profileQueryUseCasesProvider)
        .getFollowings(vmid: _vmid, page: page);
    return result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
  }

  @override
  Object itemId(RelationUser item) => item.mid;

  @override
  bool hasMoreAfterPage(List<RelationUser> items) => items.length >= _pageSize;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}

@riverpod
class Followers extends _$Followers with OffsetPagedAsyncNotifier<RelationUser> {
  late int _vmid;
  static const _pageSize = 50;

  @override
  Future<List<RelationUser>> build(int vmid) async {
    _vmid = vmid;
    return buildFirstPage();
  }

  @override
  Future<List<RelationUser>> fetchPage(int page, {bool refresh = false}) async {
    final result = await ref
        .read(profileQueryUseCasesProvider)
        .getFollowers(vmid: _vmid, page: page);
    return result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
  }

  @override
  Object itemId(RelationUser item) => item.mid;

  @override
  bool hasMoreAfterPage(List<RelationUser> items) => items.length >= _pageSize;

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> loadMore() {
    return loadNextPage();
  }
}
