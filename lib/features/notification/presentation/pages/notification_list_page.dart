import 'dart:async';

import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/application/notification_navigation.dart';
import 'package:culcul/features/notification/data/notification_paging_constants.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_cursor.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_item_widget.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _notificationFeedListProvider = AsyncNotifierProvider.autoDispose
    .family<_NotificationFeedList, List<NotificationEntry>, NotificationFeedType>(
      _NotificationFeedList.new,
    );

class _NotificationFeedList extends AsyncNotifier<List<NotificationEntry>>
    with CursorPagedAsyncNotifier<NotificationEntry, NotificationFeedCursor> {
  _NotificationFeedList(this.type);

  final NotificationFeedType type;

  @override
  FutureOr<List<NotificationEntry>> build() async {
    final firstPage = await buildFirstPage();
    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid != null) {
      unawaited(_syncHeadAndRefresh(ownerUid));
    }
    return firstPage;
  }

  @override
  Future<CursorPage<NotificationEntry, NotificationFeedCursor>> fetchPage(
    NotificationFeedCursor? cursor,
  ) async {
    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid == null || type == NotificationFeedType.system) {
      return const CursorPage(items: [], nextCursor: null, hasMore: false);
    }

    final repository = ref.read(notificationRepositoryProvider);
    if (isRefreshing || cursor == null) {
      await repository.syncFeedHead(ownerUid: ownerUid, type: type);
    } else {
      await repository.syncFeedOlder(ownerUid: ownerUid, type: type, cursor: cursor);
    }

    final data = await repository.pageFeedFromLocal(
      ownerUid: ownerUid,
      type: type,
      cursor: cursor,
    );

    return CursorPage(
      items: data,
      nextCursor: data.isEmpty
          ? null
          : NotificationFeedCursor(id: data.last.id, time: data.last.eventTime),
      hasMore: data.length >= notificationPrivateMessagePageSize,
    );
  }

  @override
  Object itemId(NotificationEntry item) => item.id;

  Future<void> loadMore() => loadNextPage();

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

class NotificationListPage extends ConsumerStatefulWidget {
  final NotificationFeedType type;
  final NotificationTargetOpener onOpenTarget;
  final ValueChanged<int> onOpenUser;

  const NotificationListPage({
    super.key,
    required this.type,
    required this.onOpenTarget,
    required this.onOpenUser,
  });

  @override
  ConsumerState<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends ConsumerState<NotificationListPage> {
  final EasyRefreshController _erController = EasyRefreshController();
  final PaginationLoadGate _loadMoreGate = PaginationLoadGate();

  @override
  void didUpdateWidget(covariant NotificationListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      _loadMoreGate.reset();
    }
  }

  @override
  void dispose() {
    _erController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.type == NotificationFeedType.system
        ? const AsyncValue<List<NotificationEntry>>.data([])
        : ref.watch(_notificationFeedListProvider(widget.type));
    final t = context.t;
    final colorScheme = Theme.of(context).colorScheme;
    final title = switch (widget.type) {
      NotificationFeedType.reply => t.notification.types.reply,
      NotificationFeedType.at => t.notification.types.at,
      NotificationFeedType.like => t.notification.types.like,
      NotificationFeedType.system => t.notification.types.system,
    };

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: Text(title)),
      body: state.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(t.notification.chat.no_message));
          }

          return EasyRefresh(
            controller: _erController,
            footer: const MaterialFooter(),
            onLoad: _loadMore,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Column(
                children: [
                  SizedBox(height: 12),
                  Divider(height: 1),
                  SizedBox(height: 12),
                ],
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return KeyedSubtree(
                  key: ValueKey('notification_${item.id}'),
                  child: _buildItem(context, item),
                );
              },
            ),
          );
        },
        error: (e, s) {
          return AppErrorWidget(error: e, stackTrace: s, onRetry: _retry);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildItem(BuildContext context, NotificationEntry item) {
    return NotificationItemWidget(
      item: item,
      type: widget.type,
      onOpenTarget: widget.onOpenTarget,
      onOpenUser: widget.onOpenUser,
    );
  }

  void _retry() {
    if (widget.type == NotificationFeedType.system) {
      return;
    }
    ref.invalidate(_notificationFeedListProvider(widget.type));
  }

  Future<IndicatorResult> _loadMore() {
    if (widget.type == NotificationFeedType.system) {
      return Future.value(IndicatorResult.noMore);
    }

    return ScrollLoadTrigger.runWithNotifier(
      gate: _loadMoreGate,
      hasMore: () =>
          ref.read(_notificationFeedListProvider(widget.type).notifier).hasMore,
      loadMore: ref.read(_notificationFeedListProvider(widget.type).notifier).loadMore,
      itemCount: () =>
          ref.read(_notificationFeedListProvider(widget.type)).asData?.value.length ?? 0,
      source: 'notification.notification_list',
    );
  }
}
