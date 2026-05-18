import 'dart:async';

import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/data/dtos/system_notice.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_notification_view_model.g.dart';

@riverpod
class SystemNotificationList extends _$SystemNotificationList {
  StreamSubscription<List<SystemNotice>>? _subscription;

  @override
  Future<List<SystemNotice>> build() async {
    final ownerUid = ref.watch(notificationOwnerUidProvider);
    if (ownerUid == null) return const <SystemNotice>[];

    final repository = ref.read(notificationRepositoryProvider);
    final stream = repository.watchSystemNotices(ownerUid: ownerUid);
    _subscription = stream.listen((items) {
      state = AsyncData(items);
    });
    ref.onDispose(() => _subscription?.cancel());

    unawaited(
      repository.syncFeedHead(ownerUid: ownerUid, type: NotificationFeedType.system),
    );
    return stream.first;
  }

  Future<void> refresh() async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) return;
    await ref
        .read(notificationRepositoryProvider)
        .syncFeedHead(ownerUid: ownerUid, type: NotificationFeedType.system);
  }
}
