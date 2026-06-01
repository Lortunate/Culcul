import 'dart:async';

import 'package:culcul/features/notification/application/notification_resume_sync_application_providers.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_owner_uid_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_lifecycle_sync_view_model.g.dart';

@Riverpod(keepAlive: true)
class NotificationLifecycleSync extends _$NotificationLifecycleSync
    with WidgetsBindingObserver {
  int _lastResumeSyncAt = 0;

  @override
  bool build() {
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() => WidgetsBinding.instance.removeObserver(this));
    return true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastResumeSyncAt < 60000) return;
    _lastResumeSyncAt = now;

    final ownerUid = ref.read(notificationOwnerUidProvider);
    if (ownerUid == null) return;
    unawaited(_syncOnResume(ownerUid));
  }

  Future<void> _syncOnResume(int ownerUid) async {
    await ref.read(notificationResumeSyncPortProvider).syncOnResume(ownerUid: ownerUid);
  }
}
