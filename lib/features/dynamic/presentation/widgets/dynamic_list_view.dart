import 'package:culcul/core/models/relation_user_contract.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_provider.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/profile/relation_api.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_post_card.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/cards/video_list_skeleton.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _recentlyFollowedProvider = FutureProvider.autoDispose<List<ProfileRelationUser>>((
  ref,
) async {
  final session = ref.watch(currentUserProvider);
  if (session == null || !session.isLoggedIn) {
    return const <ProfileRelationUser>[];
  }

  final result = await ref
      .read(relationServiceProvider)
      .getFollowings(int.parse(session.uid));
  return result.when(
    success: (users) => users.take(20).toList(),
    failure: (_) => const <ProfileRelationUser>[],
  );
});

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
                const SliverToBoxAdapter(child: _RecentlyFollowedHeader()),
              SliverList.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: context.isDesktopLayout ? 10 : 8),
                itemBuilder: (context, index) {
                  final post = items[index];
                  return KeyedSubtree(
                    key: ValueKey(post.id),
                    child: DynamicPostCard(
                      post: post,
                      header: DynamicPostHeader(post: post),
                      content: DynamicContentWidget(post: post),
                      onLike: () => notifier.toggleLike(post.id, post.isLiked),
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

class _RecentlyFollowedHeader extends ConsumerWidget {
  const _RecentlyFollowedHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final recentlyFollowed = ref.watch(_recentlyFollowedProvider);

    return recentlyFollowed.when(
      data: (users) {
        if (users.isEmpty) return const SizedBox.shrink();
        return Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  t.moments.recently_followed,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: users.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final theme = Theme.of(context);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.primary.withValues(alpha: 0.2),
                              width: 1.5,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 26,
                            backgroundImage: AppNetworkImage.providerFor(url: user.face),
                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 64,
                          child: Text(
                            user.uname,
                            style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
