import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/presentation/pages/notification_list_page_helpers.dart';
import 'package:culcul/shared/pagination/pagination_load_gate.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('notification_list_page_helpers', () {
    test('resolveNotificationListState returns empty data for system type', () {
      final state = resolveNotificationListState(
        type: NotificationFeedType.system,
        watchFeedState: () => const AsyncValue.data(<NotificationEntry>[]),
      );

      expect(
        state,
        const AsyncValue<List<NotificationEntry>>.data(<NotificationEntry>[]),
      );
    });

    test('retryNotificationList no-ops for system type', () {
      var invalidated = false;

      retryNotificationList(
        type: NotificationFeedType.system,
        invalidateFeed: () {
          invalidated = true;
        },
      );

      expect(invalidated, isFalse);
    });

    test('loadMoreNotificationList returns noMore for system type', () async {
      final result = await loadMoreNotificationList(
        type: NotificationFeedType.system,
        gate: PaginationLoadGate(),
        hasMore: () => true,
        loadMore: () async {},
        itemCount: () => 1,
      );

      expect(result, IndicatorResult.noMore);
    });
  });
}
