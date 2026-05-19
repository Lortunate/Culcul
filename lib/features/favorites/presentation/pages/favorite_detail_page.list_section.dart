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
      loading: () => const _FavoriteDetailSkeleton(),
    );
  }
}
