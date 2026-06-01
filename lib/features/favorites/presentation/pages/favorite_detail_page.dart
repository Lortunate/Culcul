import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/favorites/data/fav_repository_impl.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';
import 'package:culcul/features/favorites/state/favorites_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card_dimensions.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteDetailPage extends HookConsumerWidget {
  final int mediaId;
  final String title;
  final int mid;

  const FavoriteDetailPage({
    super.key,
    required this.mediaId,
    required this.title,
    required this.mid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final session = ref.watch(currentUserProvider);
    final isMine = session != null && session.isLoggedIn && session.uid == mid.toString();

    final isSelectionMode = useState(false);
    final selectedItems = useState<Set<int>>({});
    final refreshController = useManagedEasyRefreshController();
    final loadGate = useMemoized(PaginationLoadGate.new, [mediaId]);
    final provider = favFolderResourcesProvider(mediaId);
    final asyncValue = ref.watch(provider);
    final t = Translations.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: _buildFavoriteDetailAppBarActions(
          context: context,
          ref: ref,
          mediaId: mediaId,
          isMine: isMine,
          isSelectionMode: isSelectionMode,
          selectedItems: selectedItems,
        ),
      ),
      body: asyncValue.when(
        data: (state) {
          final pager = ref.read(provider.notifier);
          final items = state.paging.items;
          final info = state.info;

          return EasyRefresh(
            controller: refreshController,
            header: const AppRefreshHeader(),
            footer: pager.hasMore ? const AppLoadFooter() : null,
            onRefresh: () async {
              return ref.refresh(provider.future);
            },
            onLoad: !pager.hasMore
                ? null
                : () => ScrollLoadTrigger.runWithNotifier(
                    gate: loadGate,
                    hasMore: () => ref.read(provider.notifier).hasMore,
                    isLoadingMore: () => ref.read(provider.notifier).isLoadingMore,
                    loadMore: () => pager.loadMore(mediaId),
                    itemCount: () =>
                        ref.read(provider).asData?.value.paging.items.length ??
                        items.length,
                    source: 'favorites.favorite_detail',
                  ),
            child: CustomScrollView(
              slivers: [
                if (info != null)
                  SliverToBoxAdapter(child: _FavoriteFolderHeader(info: info)),
                if (items.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: AppEmptyStateWidget(
                        message: t.common.no_content,
                        onAction: () => ref.refresh(provider.future),
                        actionLabel: t.common.retry,
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = items[index];
                      return KeyedSubtree(
                        key: ValueKey('fav_resource_${item.id}_$index'),
                        child: _FavoriteResourceRow(
                          item: item,
                          isSelectionMode: isSelectionMode.value,
                          isSelected: selectedItems.value.contains(item.id),
                          onSelectionChanged: (selected) {
                            final newSet = Set<int>.from(selectedItems.value);
                            if (selected) {
                              newSet.add(item.id);
                            } else {
                              newSet.remove(item.id);
                            }
                            selectedItems.value = newSet;
                          },
                          onTap: () {
                            if (!isSelectionMode.value) return;
                            final newSet = Set<int>.from(selectedItems.value);
                            if (newSet.contains(item.id)) {
                              newSet.remove(item.id);
                            } else {
                              newSet.add(item.id);
                            }
                            selectedItems.value = newSet;
                          },
                        ),
                      );
                    }, childCount: items.length),
                  ),
                if (state.paging.error != null && items.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: AppErrorWidget(
                        error: state.paging.error!,
                        onRetry: () => pager.loadMore(mediaId),
                        variant: AppErrorWidgetVariant.compact,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        error: (error, stack) => Center(
          child: AppErrorWidget(
            error: error,
            stackTrace: stack,
            onRetry: () => ref.refresh(provider.future),
          ),
        ),
        loading: () {
          final colorScheme = Theme.of(context).colorScheme;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: 10,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, indent: 16, endIndent: 16),
            itemBuilder: (context, index) {
              return AppShimmer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: wideVideoListCardThumbnailWidth,
                        height: wideVideoListCardThumbnailHeight,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 16,
                              color: colorScheme.surfaceContainerHigh,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 16,
                              width: 100,
                              color: colorScheme.surfaceContainerHigh,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

List<Widget> _buildFavoriteDetailAppBarActions({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
  required bool isMine,
  required ValueNotifier<bool> isSelectionMode,
  required ValueNotifier<Set<int>> selectedItems,
}) {
  final t = Translations.of(context);
  final colorScheme = Theme.of(context).colorScheme;

  if (isSelectionMode.value) {
    return [
      TextButton(
        onPressed: selectedItems.value.isEmpty
            ? null
            : () async {
                final success = await _handleDeleteResources(
                  context: context,
                  ref: ref,
                  mediaId: mediaId,
                  resourceIds: selectedItems.value,
                );
                if (success) {
                  isSelectionMode.value = false;
                  selectedItems.value = {};
                  ref.invalidate(favFolderResourcesProvider(mediaId));
                  return;
                }
              },
        child: Text(t.favorites.delete_with_count(count: selectedItems.value.length)),
      ),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          isSelectionMode.value = false;
          selectedItems.value = {};
        },
      ),
    ];
  }

  if (!isMine) {
    return const [];
  }

  return [
    PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'edit') {
          await _handleEditFolder(context: context, ref: ref, mediaId: mediaId);
          return;
        }
        if (value == 'manage') {
          isSelectionMode.value = true;
          return;
        }
        if (value == 'delete') {
          await _handleDeleteFolder(context: context, ref: ref, mediaId: mediaId);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'edit', child: Text(t.favorites.edit_info)),
        PopupMenuItem(value: 'manage', child: Text(t.favorites.manage_resources)),
        PopupMenuItem(
          value: 'delete',
          child: Text(
            t.favorites.delete_folder,
            style: TextStyle(color: colorScheme.error),
          ),
        ),
      ],
    ),
  ];
}

Future<bool> _handleEditFolder({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
}) async {
  final createdFolders = ref.read(favCreatedFoldersProvider).asData?.value;
  final folder = createdFolders?.where((f) => f.id == mediaId).firstOrNull;
  final data = await showDialog<({String title, String? intro, int privacy})>(
    context: context,
    builder: (_) => FavFolderDialog(folder: folder),
  );
  if (data == null) {
    return false;
  }

  final result = await ref
      .read(favRepositoryProvider)
      .updateFolder(
        mediaId: mediaId,
        title: data.title,
        intro: data.intro,
        privacy: data.privacy,
      );
  final error = result.errorOrNull;
  if (error == null) {
    ref.invalidate(favCreatedFoldersProvider);
    return true;
  }

  if (!context.mounted) {
    return false;
  }
  final t = Translations.of(context);
  context.showAppFeedback(
    '${t.common.error}: ${error.message}',
    level: AppFeedbackLevel.error,
  );
  return false;
}

Future<bool> _handleDeleteFolder({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
}) async {
  final t = Translations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.favorites.delete_folder),
      content: Text(t.favorites.delete_folder_confirm),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(t.common.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(t.common.delete),
        ),
      ],
    ),
  );
  if (confirmed != true) {
    return false;
  }

  final result = await ref
      .read(favRepositoryProvider)
      .deleteFolder(mediaIds: mediaId.toString());
  final error = result.errorOrNull;
  if (error == null) {
    ref.invalidate(favCreatedFoldersProvider);
    if (context.mounted) {
      context.pop();
    }
    return true;
  }

  if (!context.mounted) {
    return false;
  }
  context.showAppFeedback(
    '${t.common.error}: ${error.message}',
    level: AppFeedbackLevel.error,
  );
  return false;
}

Future<bool> _handleDeleteResources({
  required BuildContext context,
  required WidgetRef ref,
  required int mediaId,
  required Set<int> resourceIds,
}) async {
  final result = await ref
      .read(favRepositoryProvider)
      .deleteResources(mediaId: mediaId, resources: resourceIds.join(','));
  final error = result.errorOrNull;
  if (error == null) {
    return true;
  }

  if (!context.mounted) {
    return false;
  }
  final t = Translations.of(context);
  context.showAppFeedback(
    '${t.common.error}: ${error.message}',
    level: AppFeedbackLevel.error,
  );
  return false;
}

class _FavoriteFolderHeader extends StatelessWidget {
  final FavoriteFolder info;

  const _FavoriteFolderHeader({required this.info});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          AppNetworkImage(
            url: info.cover!,
            width: 100,
            height: 100,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ClipOval(
                      child: AppNetworkImage(
                        url: info.upper!.face,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      info.upper!.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  t.favorites.folder_item_count(count: info.mediaCount),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteResourceRow extends StatelessWidget {
  final FavoriteResource item;
  final bool isSelectionMode;
  final bool isSelected;
  final ValueChanged<bool> onSelectionChanged;
  final VoidCallback onTap;

  const _FavoriteResourceRow({
    required this.item,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onSelectionChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Column(
      children: [
        Row(
          children: [
            if (isSelectionMode)
              Checkbox(
                value: isSelected,
                onChanged: (value) => onSelectionChanged(value ?? false),
              ),
            Expanded(
              child: DefaultTextStyle.merge(
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
                child: VideoListCard(
                  onTap: onTap,
                  coverUrl: item.cover,
                  title: item.title,
                  duration: item.duration,
                  aspectRatio: wideVideoListCardThumbnailAspectRatio,
                  height: wideVideoListCardThumbnailHeight,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  middleContent: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.upper.name,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.showAppFeedback(t.common.coming_soon(tab: 'More'));
                        },
                        child: Icon(
                          Icons.more_vert,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  stats: [
                    IconText(
                      icon: Icons.play_circle_outline,
                      text: FormatUtils.formatNumber(item.stats.play),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                    IconText(
                      icon: Icons.comment_outlined,
                      text: FormatUtils.formatNumber(item.stats.danmaku),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}
