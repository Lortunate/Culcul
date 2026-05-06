import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:culcul/core/pagination/scroll_load_trigger.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AsyncValue<List<NotificationEntry>> resolveNotificationListState({
  required NotificationFeedType type,
  required AsyncValue<List<NotificationEntry>> Function() watchFeedState,
}) {
  return switch (type) {
    NotificationFeedType.reply => watchFeedState(),
    NotificationFeedType.at => watchFeedState(),
    NotificationFeedType.like => watchFeedState(),
    NotificationFeedType.system => const AsyncValue.data([]),
  };
}

void retryNotificationList({
  required NotificationFeedType type,
  required VoidCallback invalidateFeed,
}) {
  if (type == NotificationFeedType.system) {
    return;
  }
  invalidateFeed();
}

Future<IndicatorResult> loadMoreNotificationList({
  required NotificationFeedType type,
  required PaginationLoadGate gate,
  required bool Function() hasMore,
  required Future<void> Function() loadMore,
  required int Function() itemCount,
  String source = 'notification.notification_list',
}) {
  if (type == NotificationFeedType.system) {
    return SynchronousFuture(IndicatorResult.noMore);
  }

  return ScrollLoadTrigger.runWithNotifier(
    gate: gate,
    hasMore: hasMore,
    loadMore: loadMore,
    itemCount: itemCount,
    source: source,
  );
}
