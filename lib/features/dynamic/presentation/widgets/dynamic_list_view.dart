import 'package:culcul/features/dynamic/application/dynamic_post_card_view_data.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_post_card.dart';
import 'package:culcul/features/dynamic/presentation/widgets/recently_followed_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicListView extends HookConsumerWidget {
  final String type;

  const DynamicListView({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final t = Translations.of(context);
    final provider = dynamicProvider(type);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    return ResponsiveContentContainer(
      maxWidth: AppBreakpoints.pageMaxWidth,
      child: SmartPagingView(
        asyncValue: state,
        onRefresh: notifier.refresh,
        onLoadMore: notifier.loadMore,
        itemCount: () => ref.read(provider).value?.length ?? 0,
        skeleton: const VideoListSkeleton(),
        emptyText: t.common.no_content,
        builder: (context, items) {
          return CustomScrollView(
            slivers: [
              if (type == 'all')
                const SliverToBoxAdapter(child: RecentlyFollowedWidget()),
              SliverList.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: context.isDesktopLayout ? 10 : 8),
                itemBuilder: (context, index) {
                  final post = items[index];
                  final cardPost = post.toDynamicPostCardViewData();
                  return KeyedSubtree(
                    key: ValueKey(cardPost.id),
                    child: DynamicPostCard(
                      post: cardPost,
                      header: DynamicPostHeader(post: post),
                      content: DynamicContentWidget(post: post),
                      onLike: () => notifier.toggleLike(cardPost.id, cardPost.isLiked),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
