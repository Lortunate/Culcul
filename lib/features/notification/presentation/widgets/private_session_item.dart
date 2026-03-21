import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/features/profile/providers/profile_provider.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrivateSessionItem extends ConsumerWidget {
  final PrivateMessageSession session;

  const PrivateSessionItem({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // 1. Determine Title and Avatar
    String title = 'User ${session.talkerId}';
    String avatarUrl = '';
    bool isLoading = false;

    if (session.sessionType == 1) {
      // Type 1: User Session
      if (session.accountInfo != null) {
        // System messages usually carry accountInfo
        title = session.accountInfo!.name;
        avatarUrl = session.accountInfo!.picUrl;
      } else {
        // P2P messages: fetch profile info
        final userProfileAsync = ref.watch(
          userProfileProvider(session.talkerId.toString()),
        );
        if (userProfileAsync.hasValue) {
          final profile = userProfileAsync.value!;
          title = profile.username;
          avatarUrl = profile.avatarUrl ?? '';
        } else {
          isLoading = true;
        }
      }
    } else if (session.sessionType == 2) {
      // Type 2: Group/Fan Group
      title = session.groupName ?? 'Group';
      avatarUrl = session.groupCover ?? '';
    }

    if (isLoading) {
      return AppShimmer(
        child: ListTile(
          leading: const AppShimmerBox(width: 48, height: 48, borderRadius: 24),
          title: const AppShimmerBox(width: 100, height: 16),
          subtitle: const AppShimmerBox(width: 200, height: 14),
        ),
      );
    }

    // 2. Parse Content
    final content = session.lastMsg?.summary ?? '';

    return ListTile(
      onTap: () {
        ChatRoute(
          talkerId: session.talkerId,
          name: title,
          sessionType: session.sessionType,
          avatarUrl: avatarUrl,
        ).push(context);
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
          const SizedBox(width: 8),
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

  Widget _buildAvatar(String url, int mid, BuildContext context) {
    if (url.isEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
      );
    }
    return ExtendedImage.network(
      url,
      width: 48,
      height: 48,
      shape: BoxShape.circle,
      fit: BoxFit.cover,
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(10),
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
