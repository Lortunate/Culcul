import 'package:culcul/features/dynamic/presentation.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/skeletons/dynamic_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDynamicTab extends ConsumerStatefulWidget {
  final int mid;
  const UserDynamicTab({super.key, required this.mid});

  @override
  ConsumerState<UserDynamicTab> createState() => _UserDynamicTabState();
}

class _UserDynamicTabState extends ConsumerState<UserDynamicTab>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    if (_scrollController.position.extentAfter > 360) {
      return;
    }
    _loadMoreIfNeeded();
  }

  Future<void> _loadMoreIfNeeded() async {
    if (_isLoadingMore) {
      return;
    }
    final notifier = ref.read(userDynamicProvider(widget.mid).notifier);
    if (!notifier.hasMore) {
      return;
    }
    _isLoadingMore = true;
    try {
      await notifier.loadMore();
    } finally {
      _isLoadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final t = Translations.of(context);
    final feedAsync = ref.watch(userDynamicProvider(widget.mid));
    final notifier = ref.read(userDynamicProvider(widget.mid).notifier);

    return CustomScrollView(
      controller: _scrollController,
      key: PageStorageKey<String>('user_dynamic_tab_${widget.mid}'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        feedAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return SliverFillRemaining(child: Center(child: Text(t.common.no_content)));
            }
            final contentCount = items.length * 2 - 1;
            final showLoadingFooter = feedAsync.isLoading && items.isNotEmpty;
            final totalCount = contentCount + (showLoadingFooter ? 1 : 0);
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index >= contentCount) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (index.isOdd) {
                    return const SizedBox(height: 16);
                  }
                  final item = items[index ~/ 2];
                  return DynamicPostCard(
                    key: ValueKey('user_dynamic_${item.idStr}_$index'),
                    post: item,
                    onLike: (post) => notifier.toggleLike(
                      post.idStr,
                      post.modules.moduleStat?.like.status ?? false,
                    ),
                  );
                }, childCount: totalCount),
              ),
            );
          },
          error: (err, stack) => SliverFillRemaining(
            child: AppErrorWidget(
              error: err,
              stackTrace: stack,
              onRetry: () => ref.refresh(userDynamicProvider(widget.mid)),
            ),
          ),
          loading: () {
            const skeletonCount = 5;
            const childCount = skeletonCount * 2 - 1;
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index.isOdd) {
                    return const SizedBox(height: 16);
                  }
                  return const DynamicSkeleton();
                }, childCount: childCount),
              ),
            );
          },
        ),
      ],
    );
  }
}
