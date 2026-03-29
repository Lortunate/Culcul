// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/profile/data/relation_repository.dart';

part 'relation_controller.g.dart';

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
    final repository = ref.read(relationRepositoryProvider);
    final data = await repository.getFollowings(_vmid, pn: page);
    return data.list;
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
    final repository = ref.read(relationRepositoryProvider);
    final data = await repository.getFollowers(_vmid, pn: page);
    return data.list;
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
