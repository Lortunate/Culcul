part of 'favorite_detail_page.dart';

class _FavoriteDetailListSection extends ConsumerWidget {
  final int mediaId;
  final EasyRefreshController refreshController;
  final PaginationLoadGate loadGate;
  final ValueNotifier<bool> isSelectionMode;
  final ValueNotifier<Set<int>> selectedItems;

  const _FavoriteDetailListSection({
    required this.mediaId,
    required this.refreshController,
    required this.loadGate,
    required this.isSelectionMode,
    required this.selectedItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final provider = favFolderResourcesProvider(mediaId);
    final asyncValue = ref.watch(provider);
    return asyncValue.when(
      data: (state) {
        final pager = ref.read(provider.notifier);
        final items = state.paging.items;
        final info = state.info;

        return EasyRefresh(
          controller: refreshController,
          header: AppRefreshHeader(),
          footer: pager.hasMore ? AppLoadFooter() : null,
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
      loading: () => const _FavoriteDetailSkeleton(),
    );
  }
}

class _FavoriteFolderHeader extends StatelessWidget {
  final FavoriteFolderInfo info;

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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AppNetworkImage(
              url: info.cover,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
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
                      child: AppNetworkImage(url: info.upper.face, width: 20, height: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      info.upper.name,
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
              child: FavResourceItem(item: item, onTap: onTap),
            ),
          ],
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}

class _FavoriteDetailSkeleton extends StatelessWidget {
  const _FavoriteDetailSkeleton();

  @override
  Widget build(BuildContext context) {
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
                  width: 160,
                  height: 90,
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
                      Container(height: 16, color: colorScheme.surfaceContainerHigh),
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
  }
}
