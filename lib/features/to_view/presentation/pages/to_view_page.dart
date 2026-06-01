import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/to_view/application/to_view_list_controller.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card_dimensions.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:culcul/ui/widgets/users/guest_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToViewPage extends ConsumerWidget {
  final VoidCallback onLogin;
  final ValueChanged<String> onOpenVideo;

  const ToViewPage({required this.onLogin, required this.onOpenVideo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(
      currentUserProvider.select((s) => s?.isLoggedIn ?? false),
    );
    final currentItemCount = ref.watch(
      toViewListProvider.select((value) => value.asData?.value.length ?? 0),
    );
    final canClearAll = isLoggedIn && currentItemCount > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.watch_later.title),
        actions: [
          if (isLoggedIn)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () => _handleClearAll(context, ref, canClearAll),
            ),
        ],
      ),
      body: isLoggedIn
          ? _ToViewBody(
              onRefresh: () async {
                try {
                  ref.invalidate(toViewListProvider);
                  await ref.read(toViewListProvider.future);
                  return IndicatorResult.success;
                } catch (_) {
                  return IndicatorResult.fail;
                }
              },
              onDelete: (aid) => ref.read(toViewListProvider.notifier).delete(aid),
              onOpenVideo: onOpenVideo,
            )
          : GuestView(
              title: t.profile.not_logged_in,
              message: t.profile.login_hint,
              onLogin: onLogin,
            ),
    );
  }

  Future<void> _handleClearAll(
    BuildContext context,
    WidgetRef ref,
    bool canClearAll,
  ) async {
    if (!canClearAll) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(t.watch_later.clear_all),
          content: Text(t.watch_later.clear_all_confirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(t.common.cancel),
            ),
            TextButton(
              onPressed: () async {
                await ref.read(toViewListProvider.notifier).clear();
                if (!dialogContext.mounted) {
                  return;
                }
                Navigator.of(dialogContext).pop();
              },
              child: Text(t.common.confirm),
            ),
          ],
        );
      },
    );
  }
}

class _ToViewBody extends ConsumerWidget {
  const _ToViewBody({
    required this.onRefresh,
    required this.onDelete,
    required this.onOpenVideo,
  });

  final Future<IndicatorResult> Function() onRefresh;
  final ValueChanged<int> onDelete;
  final ValueChanged<String> onOpenVideo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toViewListAsync = ref.watch(toViewListProvider);
    return switch (toViewListAsync) {
      AsyncData(:final value) when value.isEmpty => Center(
        child: Text(t.common.no_content),
      ),
      AsyncData(:final value) => EasyRefresh(
        header: const AppRefreshHeader(),
        onRefresh: onRefresh,
        child: ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final item = value[index];
            final aid = item.aid;
            final bvid = item.bvid;
            if (bvid.isEmpty) {
              return const SizedBox.shrink();
            }

            return Dismissible(
              key: ValueKey(aid),
              direction: DismissDirection.endToStart,
              background: ColoredBox(
                color: Theme.of(context).colorScheme.error,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                ),
              ),
              onDismissed: (_) => onDelete(aid),
              child: _ToViewItem(item: item, onTap: () => onOpenVideo(bvid)),
            );
          },
        ),
      ),
      AsyncError(:final error, :final stackTrace) => AppErrorWidget(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(toViewListProvider),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _ToViewItem extends StatelessWidget {
  const _ToViewItem({required this.item, this.onTap});

  final ToViewEntry item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final translations = Translations.of(context);

    return VideoListCard(
      onTap: onTap,
      coverUrl: item.coverUrl,
      title: item.title,
      duration: item.hasProgress ? 0 : item.duration,
      thumbnailWidth: compactVideoListCardThumbnailWidth,
      aspectRatio: compactVideoListCardThumbnailAspectRatio,
      height: compactVideoListCardThumbnailHeight,
      middleContent: Row(
        children: [
          if (item.hasProgress) ...[
            Icon(Icons.history, size: 14, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                translations.watch_later.watch_to(
                  progress: FormatUtils.formatDuration(item.progress),
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else ...[
            Icon(Icons.person_outline, size: 14, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                item.ownerName,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
      stats: [
        IconText(
          icon: Icons.play_circle_outline,
          text: FormatUtils.formatNumber(item.viewCount),
          iconSize: 12,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
        IconText(
          icon: Icons.comment_outlined,
          text: FormatUtils.formatNumber(item.danmakuCount),
          iconSize: 12,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
