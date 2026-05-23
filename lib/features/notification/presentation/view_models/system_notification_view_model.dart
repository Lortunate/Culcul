import 'dart:async';

import 'package:culcul/features/notification/application/notification_system_notice_application_providers.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
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

    final systemNoticePort = ref.read(notificationSystemNoticePortProvider);
    final stream = systemNoticePort.watchSystemNotices(ownerUid: ownerUid);
    _subscription = stream.listen((items) {
      state = AsyncData(items);
    });
    ref.onDispose(() => _subscription?.cancel());

    unawaited(systemNoticePort.syncSystemNotices(ownerUid: ownerUid));
    return stream.first;
  }

  Future<void> refresh() async {
    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) return;
    await ref
        .read(notificationSystemNoticePortProvider)
        .syncSystemNotices(ownerUid: ownerUid);
  }
}
