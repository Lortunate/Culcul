import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/profile/application/profile_session_providers.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrivateSessionItem extends ConsumerWidget {
  final PrivateSession session;
  final void Function(
    PrivateSession session, {
    required String name,
    required String avatarUrl,
  })
  onOpenChat;

  const PrivateSessionItem({super.key, required this.session, required this.onOpenChat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // 1. Determine Title and Avatar
    String title = 'User ${session.talkerId}';
    String avatarUrl = '';
    bool isLoading = false;

    if (session.sessionType == PrivateSessionType.user) {
      // Type 1: User Session
      if (session.accountInfo != null) {
        // System messages usually carry accountInfo
        title = session.accountInfo!.name;
        avatarUrl = session.accountInfo!.picUrl;
      } else {
        // P2P messages: fetch profile info
        final userProfileAsync = ref.watch(
          userProfileInfoProvider(session.talkerId.toString()),
        );
        if (userProfileAsync.hasValue) {
          final profile = userProfileAsync.value;
          if (profile != null) {
            title = profile.name;
            avatarUrl = profile.face;
          }
        } else {
          isLoading = true;
        }
      }
    } else if (session.sessionType == PrivateSessionType.group) {
      // Type 2: Group/Fan Group
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
    final content = _buildMessageSummary(t, session.lastMessage);

    return ListTile(
      onTap: () {
        onOpenChat(session, name: title, avatarUrl: avatarUrl);
      },
      leading: _buildAvatar(avatarUrl, session.talkerId, context),
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
            DateTime.fromMicrosecondsSinceEpoch(session.sessionTs).toSimpleDate(),
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
      trailing: _buildUnreadBadge(context, session.unreadCount),
    );
  }

  String _buildMessageSummary(Translations t, PrivateMessage? message) {
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
      PrivateMessageSummaryKind.unknown => _guessFallbackSummary(t, message),
    };
  }

  String _guessFallbackSummary(Translations t, PrivateMessage message) {
    return message.fallbackSummaryText ?? t.notification.chat.summary_unknown;
  }

  Widget _buildAvatar(String url, int mid, BuildContext context) {
    if (url.isEmpty) {
      return CircleAvatar(
        radius: CulculRadius.xl,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
      );
    }
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final cacheSize = (48 * dpr).round().clamp(1, 2048);
    return ExtendedImage.network(
      url,
      width: 48,
      height: 48,
      shape: BoxShape.circle,
      fit: BoxFit.cover,
      cacheWidth: cacheSize,
      cacheHeight: cacheSize,
      loadStateChanged: (state) {
        if (state.extendedImageLoadState == LoadState.loading) {
          return Container(color: Theme.of(context).colorScheme.surfaceContainerHighest);
        }
        return null;
      },
    );
  }

  Widget? _buildUnreadBadge(BuildContext context, int count) {
    if (count <= 0) return null;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CulculSpacing.xxs,
        vertical: CulculSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(CulculRadius.sm),
      ),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onError,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
