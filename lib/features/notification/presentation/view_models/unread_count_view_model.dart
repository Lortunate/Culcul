import 'dart:async';

import 'package:culcul/features/notification/domain/entities/notification_summary.dart';
import 'package:culcul/features/notification/feature_scope.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_count_view_model.g.dart';

@riverpod
class UnreadCount extends _$UnreadCount {
  StreamSubscription<NotificationSummary>? _subscription;

  @override
  FutureOr<NotificationSummary> build() async {
    final ownerUid = ref.watch(notificationOwnerUidProvider);
    if (ownerUid == null) {
      return const NotificationSummary(
        at: 0,
        chat: 0,
        coin: 0,
        danmu: 0,
        favorite: 0,
        like: 0,
        recvLike: 0,
        recvReply: 0,
        reply: 0,
        system: 0,
        up: 0,
      );
    }

    final repository = ref.read(notificationRepositoryProvider);
    final stream = repository.watchUnreadCount(ownerUid: ownerUid);
    _subscription = stream.listen((summary) {
      state = AsyncData(summary);
    });
    ref.onDispose(() => _subscription?.cancel());

    unawaited(repository.syncUnreadCount(ownerUid: ownerUid));
    return stream.first;
  }

  Future<void> refresh() async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) return;
    await ref
        .read(notificationRepositoryProvider)
        .syncUnreadCount(ownerUid: ownerUid, force: true);
  }
}
