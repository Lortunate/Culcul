import 'dart:async';

import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/application/notification_navigation.dart';
import 'package:culcul/features/notification/data/notification_paging_constants.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/models/notification_entry.dart';
import 'package:culcul/features/notification/models/notification_feed_cursor.dart';
import 'package:culcul/features/notification/models/notification_feed_type.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
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
  static const NotificationNavigationParser _navigationParser =
      NotificationNavigationParser();

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final title = switch (widget.type) {
      NotificationFeedType.reply => t.notification.types.reply,
      NotificationFeedType.at => t.notification.types.at,
      NotificationFeedType.like => t.notification.types.like,
      NotificationFeedType.system => t.notification.types.system,
    };

    Widget notificationItem(NotificationEntry item) {
      final user = item.primaryActor;
      final detail = item.detail;

      if (user == null) return const SizedBox.shrink();

      final time = DateTime.fromMillisecondsSinceEpoch(item.eventTime * 1000);
      final actionText = switch (widget.type) {
        NotificationFeedType.like => t.notification.types.like,
        NotificationFeedType.at => t.notification.types.at,
        NotificationFeedType.reply => t.notification.types.reply,
        NotificationFeedType.system => t.notification.types.system,
      };
      final sourceText = detail.sourceContent.isNotEmpty
          ? detail.sourceContent
          : detail.title.isNotEmpty
          ? detail.title
          : t.notification.related_content;

      return InkWell(
        onTap: () async {
          final target = _navigationParser.fromNotificationDetail(detail);
          final handled = await widget.onOpenTarget(target);
          if (handled || !context.mounted) return;

          context.showAppFeedback(
            t.notification.navigation_error(
              type: detail.type,
              id: detail.subjectId.toString(),
            ),
            level: AppFeedbackLevel.error,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (user.mid != 0) {
                  widget.onOpenUser(user.mid);
                }
              },
              child: AppAvatar(url: user.avatar, size: 40),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.nickname,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        actionText,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        FormatUtils.formatSimpleDate(time),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (widget.type != NotificationFeedType.like) ...[
                    Text(
                      detail.message.isNotEmpty
                          ? detail.message
                          : detail.targetReplyContent,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                  ],
                  Container(
                    padding: const EdgeInsets.all(CulculSpacing.xs),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(CulculRadius.xs),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            sourceText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (detail.image.isNotEmpty) ...[
                          const SizedBox(width: CulculSpacing.xs),
                          AppNetworkImage(
                            url: detail.image,
                            width: 40,
                            height: 40,
                            borderRadius: BorderRadius.circular(CulculRadius.xs),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

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
            onLoad: () {
              if (widget.type == NotificationFeedType.system) {
                return Future.value(IndicatorResult.noMore);
              }

              return ScrollLoadTrigger.runWithNotifier(
                gate: _loadMoreGate,
                hasMore: () =>
                    ref.read(_notificationFeedListProvider(widget.type).notifier).hasMore,
                loadMore: ref
                    .read(_notificationFeedListProvider(widget.type).notifier)
                    .loadMore,
                itemCount: () =>
                    ref
                        .read(_notificationFeedListProvider(widget.type))
                        .asData
                        ?.value
                        .length ??
                    0,
                source: 'notification.notification_list',
              );
            },
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
                  child: notificationItem(item),
                );
              },
            ),
          );
        },
        error: (e, s) {
          return AppErrorWidget(
            error: e,
            stackTrace: s,
            onRetry: () {
              if (widget.type == NotificationFeedType.system) {
                return;
              }
              ref.invalidate(_notificationFeedListProvider(widget.type));
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
