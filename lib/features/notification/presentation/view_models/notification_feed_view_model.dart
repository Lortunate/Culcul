import 'dart:async';

import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/notification.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_feed_view_model.g.dart';

@riverpod
class NotificationFeedList extends _$NotificationFeedList
    with CursorPagedAsyncNotifier<NotificationEntry, ({int id, int time})> {
  @override
  FutureOr<List<NotificationEntry>> build(NotificationFeedType type) async {
    final firstPage = await buildFirstPage();
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid != null) {
      unawaited(_syncHeadAndRefresh(ownerUid));
    }
    return firstPage;
  }

  @override
  Future<CursorPage<NotificationEntry, ({int id, int time})>> fetchPage(
    ({int id, int time})? cursor, {
    bool refresh = false,
  }) async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null || type == NotificationFeedType.system) {
      return const CursorPage(items: [], nextCursor: null, hasMore: false);
    }

    final repository = ref.read(notificationRepositoryProvider);
    if (refresh || cursor == null) {
      await repository.syncFeedHead(ownerUid: ownerUid, type: type);
    } else {
      await repository.syncFeedOlder(
        ownerUid: ownerUid,
        type: type,
        cursorId: cursor.id,
        cursorTime: cursor.time,
      );
    }

    final data = await repository.pageFeedFromLocal(
      ownerUid: ownerUid,
      type: type,
      cursorId: cursor?.id,
      cursorTime: cursor?.time,
    );

    return CursorPage(
      items: data,
      nextCursor: data.isEmpty ? null : (id: data.last.id, time: data.last.eventTime),
      hasMore: data.length >= 20,
    );
  }

  @override
  Object itemId(NotificationEntry item) => item.id;

  Future<void> loadMore() => loadNextPage();

  Future<void> refresh() => refreshPage();

  Future<void> _syncHeadAndRefresh(int ownerUid) async {
    if (type == NotificationFeedType.system) return;
    try {
      await ref
          .read(notificationRepositoryProvider)
          .syncFeedHead(ownerUid: ownerUid, type: type);
      await refreshPage();
    } catch (_) {}
  }
}
