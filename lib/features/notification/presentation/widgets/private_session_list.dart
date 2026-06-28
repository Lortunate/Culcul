import 'dart:async';

import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/notification/data/notification_paging_constants.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/models/private_message.dart';
import 'package:culcul/features/notification/models/private_session.dart';
import 'package:culcul/features/profile/application/profile_session_providers.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _privateSessionListProvider =
    AsyncNotifierProvider<_PrivateSessionList, List<PrivateSession>>(
      _PrivateSessionList.new,
    );

class _PrivateSessionList extends AsyncNotifier<List<PrivateSession>>
    with CursorPagedAsyncNotifier<PrivateSession, int> {
  @override
  FutureOr<List<PrivateSession>> build() async {
    final firstPage = await buildFirstPage();
    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid != null) {
      unawaited(_syncHeadAndRefresh(ownerUid));
    }
    return firstPage;
  }

  @override
  Future<CursorPage<PrivateSession, int>> fetchPage(int? currentCursor) async {
    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) {
      return const CursorPage(items: [], nextCursor: null, hasMore: false);
    }

    final repository = ref.read(notificationRepositoryProvider);
    if (isRefreshing || currentCursor == null) {
      await repository.syncSessions(ownerUid: ownerUid, force: true);
    } else {
      await repository.syncSessionsOlder(
        ownerUid: ownerUid,
        sessionType: PrivateSessionType.user,
        endTs: currentCursor,
      );
    }

    final sessions = await repository.pageSessionsFromLocal(
      ownerUid: ownerUid,
      sessionType: PrivateSessionType.user,
      endTs: currentCursor,
    );

    return CursorPage(
      items: sessions,
      nextCursor: sessions.isEmpty ? currentCursor : sessions.last.sessionTs,
      hasMore: sessions.length >= notificationPrivateMessagePageSize,
    );
  }

  @override
  Object itemId(PrivateSession item) => item.talkerId;

  Future<void> loadMore() {
    return loadNextPage();
  }

  Future<void> _syncHeadAndRefresh(int ownerUid) async {
    try {
      await ref.read(notificationRepositoryProvider).syncSessions(ownerUid: ownerUid);
      await refreshPage();
    } catch (_) {}
  }
}

class PrivateSessionListView extends HookConsumerWidget {
  final void Function(
    PrivateSession session, {
    required String name,
    required String avatarUrl,
  })
  onOpenChat;

  const PrivateSessionListView({super.key, required this.onOpenChat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionListAsync = ref.watch(_privateSessionListProvider);
    final loadGate = useMemoized(PaginationLoadGate.new, const []);
    final t = context.t;

    return sessionListAsync.when(
      data: (sessions) {
        final notifier = ref.read(_privateSessionListProvider.notifier);
        final hasMore = notifier.hasMore;
        return EasyRefresh(
          onRefresh: () async {
            return ref.refresh(_privateSessionListProvider.future);
          },
          onLoad: !hasMore
              ? null
              : () => ScrollLoadTrigger.runWithNotifier(
                  gate: loadGate,
                  hasMore: () => ref.read(_privateSessionListProvider.notifier).hasMore,
                  loadMore: notifier.loadMore,
                  itemCount: () =>
                      ref.read(_privateSessionListProvider).asData?.value.length ??
                      sessions.length,
                  source: 'notification.private_session_list',
                ),
          footer: hasMore ? const MaterialFooter() : null,
          child: sessions.isEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: Center(child: Text(t.notification.chat.no_message)),
                      ),
                    );
                  },
                )
              : ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    return KeyedSubtree(
                      key: ValueKey('private_session_${session.talkerId}_$index'),
                      child: _PrivateSessionItem(
                        session: session,
                        onOpenChat: onOpenChat,
                      ),
                    );
                  },
                ),
        );
      },
      error: (e, s) => EasyRefresh(
        onRefresh: () async {
          return ref.refresh(_privateSessionListProvider.future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.7,
            child: AppErrorWidget(
              error: e,
              stackTrace: s,
              onRetry: () {
                ref.invalidate(_privateSessionListProvider);
              },
            ),
          ),
        ),
      ),
      loading: () => ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: CulculSpacing.md,
          vertical: CulculSpacing.sm,
        ),
        itemCount: 15,
        separatorBuilder: (context, index) => const SizedBox(height: CulculSpacing.md),
        itemBuilder: (context, index) => const AppShimmer(
          child: Row(
            children: [
              AppShimmerBox(width: 48, height: 48, borderRadius: CulculRadius.xl),
              SizedBox(width: CulculSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(width: 120, height: 16),
                    SizedBox(height: CulculSpacing.xs),
                    AppShimmerBox(width: double.infinity, height: 14),
                  ],
                ),
              ),
              SizedBox(width: CulculSpacing.md),
              AppShimmerBox(width: 40, height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivateSessionItem extends ConsumerWidget {
  final PrivateSession session;
  final void Function(
    PrivateSession session, {
    required String name,
    required String avatarUrl,
  })
  onOpenChat;

  const _PrivateSessionItem({required this.session, required this.onOpenChat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    String title = 'User ${session.talkerId}';
    String avatarUrl = '';
    bool isLoading = false;

    if (session.sessionType == PrivateSessionType.user) {
      if (session.accountInfo != null) {
        title = session.accountInfo!.name;
        avatarUrl = session.accountInfo!.picUrl;
      } else {
        final userProfileAsync = ref.watch(
          userProfileCardProvider(session.talkerId.toString()),
        );
        if (userProfileAsync.hasValue) {
          final profile = userProfileAsync.value?.dataOrNull;
          if (profile != null) {
            title = profile.name;
            avatarUrl = profile.face;
          }
        } else {
          isLoading = true;
        }
      }
    } else if (session.sessionType == PrivateSessionType.group) {
      title = session.groupName ?? 'Group';
      avatarUrl = session.groupCover ?? '';
    }

    if (isLoading) {
      return const AppShimmer(
        child: ListTile(
          leading: AppShimmerBox(width: 48, height: 48, borderRadius: CulculRadius.xl),
          title: AppShimmerBox(width: 100, height: 16),
          subtitle: AppShimmerBox(width: 200, height: 14),
        ),
      );
    }

    final t = Translations.of(context);
    final message = session.lastMessage;
    final content = () {
      if (message == null) return '';
      if (message.isWithdrawn) {
        return t.notification.chat.message_withdrawn;
      }

      return switch (message.summaryKind) {
        PrivateMessageSummaryKind.text =>
          message.primaryText ?? t.notification.chat.summary_text,
        PrivateMessageSummaryKind.image => t.notification.chat.summary_image,
        PrivateMessageSummaryKind.notice =>
          message.titleText ?? message.primaryText ?? t.notification.chat.summary_notice,
        PrivateMessageSummaryKind.video =>
          '${t.notification.chat.summary_video} ${message.titleText ?? ''}',
        PrivateMessageSummaryKind.article =>
          '${t.notification.chat.summary_article} ${message.titleText ?? ''}',
        PrivateMessageSummaryKind.card =>
          '${t.notification.chat.summary_card} ${message.titleText ?? ''}',
        PrivateMessageSummaryKind.share =>
          '${t.notification.chat.summary_share} ${message.titleText ?? ''}',
        PrivateMessageSummaryKind.withdrawn => t.notification.chat.message_withdrawn,
        PrivateMessageSummaryKind.unknown =>
          message.fallbackSummaryText ?? t.notification.chat.summary_unknown,
      };
    }();

    return ListTile(
      onTap: () {
        onOpenChat(session, name: title, avatarUrl: avatarUrl);
      },
      leading: avatarUrl.isEmpty
          ? CircleAvatar(
              radius: CulculRadius.xl,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(Icons.person, color: theme.colorScheme.primary),
            )
          : ExtendedImage.network(
              avatarUrl,
              width: 48,
              height: 48,
              shape: BoxShape.circle,
              fit: BoxFit.cover,
              cacheWidth: (48 * MediaQuery.devicePixelRatioOf(context)).round().clamp(
                1,
                2048,
              ),
              cacheHeight: (48 * MediaQuery.devicePixelRatioOf(context)).round().clamp(
                1,
                2048,
              ),
              loadStateChanged: (state) {
                if (state.extendedImageLoadState == LoadState.loading) {
                  return Container(color: theme.colorScheme.surfaceContainerHighest);
                }
                return null;
              },
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(width: CulculSpacing.xs),
          Text(
            FormatUtils.formatSimpleDate(
              DateTime.fromMicrosecondsSinceEpoch(session.sessionTs),
            ),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      subtitle: Text(
        content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: session.unreadCount <= 0
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CulculSpacing.xxs,
                vertical: CulculSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                borderRadius: BorderRadius.circular(CulculRadius.sm),
              ),
              child: Text(
                session.unreadCount > 99 ? '99+' : session.unreadCount.toString(),
                style: TextStyle(
                  color: theme.colorScheme.onError,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
