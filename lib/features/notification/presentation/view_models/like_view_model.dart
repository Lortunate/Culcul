import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_view_model.g.dart';

@riverpod
class LikeList extends _$LikeList
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
        .getLikeList(id: cursor?.id, likeTime: cursor?.time)
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
