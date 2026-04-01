import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reply_view_model.g.dart';

@riverpod
class ReplyList extends _$ReplyList
    with CursorPagedAsyncNotifier<NotificationEntry, ({int id, int time})> {
  @override
  FutureOr<List<NotificationEntry>> build() async {
    return buildFirstPage();
  }

  @override
  Future<CursorPage<NotificationEntry, ({int id, int time})>> fetchPage(
    ({int id, int time})? cursor, {
    bool refresh = false,
  }) {
    return ref
        .read(notificationRepositoryProvider)
        .getReplyList(id: cursor?.id, replyTime: cursor?.time)
        .then(
          (data) => CursorPage(
            items: data,
            nextCursor: data.isEmpty
                ? null
                : (id: data.last.id, time: data.last.eventTime),
            hasMore: data.isNotEmpty,
          ),
        );
  }

  @override
  Object itemId(NotificationEntry item) => item.id;

  Future<void> loadMore() => loadNextPage();

  Future<void> refresh() => refreshPage();
}
