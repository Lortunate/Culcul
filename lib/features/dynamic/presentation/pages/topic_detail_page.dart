import 'package:culcul/features/dynamic/data/dtos/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/features/dynamic/dynamic_post_card.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_skeleton.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopicDetailPage extends HookConsumerWidget {
  final int topicId;
  final String topicName;

  const TopicDetailPage({super.key, required this.topicId, required this.topicName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final provider = topicDynamicProvider(topicId: topicId);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final loadGate = useMemoized(PaginationLoadGate.new, [topicId]);

    return Scaffold(
      appBar: AppBar(title: Text(topicName)),
      body: Builder(
        builder: (context) {
          if (state.isLoading && !state.hasValue) {
            return const VideoListSkeleton();
          }

          if (state.hasError && !state.hasValue) {
            return Center(
              child: AppErrorWidget(
                error: state.error!,
                stackTrace: state.stackTrace,
                onRetry: notifier.refresh,
              ),
            );
          }

          final items = state.value ?? [];
          final hasMore = notifier.hasMore;

          return EasyRefresh(
            header: AppRefreshHeader(),
            footer: hasMore ? AppLoadFooter() : null,
            onRefresh: () async {
              await notifier.refresh();
            },
            onLoad: !hasMore
                ? null
                : () => ScrollLoadTrigger.runWithNotifier(
                    gate: loadGate,
                    hasMore: () => ref.read(provider.notifier).hasMore,
                    loadMore: notifier.loadMore,
                    itemCount: () =>
                        ref.read(provider).asData?.value.length ?? items.length,
                    source: 'dynamic.topic_detail',
                  ),
            child: items.isEmpty
                ? CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        child: Center(
                          child: AppEmptyStateWidget(
                            message: t.common.no_content,
                            onAction: notifier.refresh,
                            actionLabel: t.common.retry,
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final post = items[index];
                      return KeyedSubtree(
                        key: ValueKey('topic_post_${post.idStr}_$index'),
                        child: DynamicPostCard(
                          post: post,
                          onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                  ),
          );
        },
      ),
    );
  }
}
