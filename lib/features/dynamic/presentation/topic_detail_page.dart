import 'package:culcul/features/dynamic/models/dynamic_models.dart';
import 'package:culcul/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_post_card.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(topicName)),
      body: Builder(
        builder: (context) {
          if (state.isLoading && !state.hasValue) {
            return const VideoListSkeleton();
          }

          if (state.hasError && !state.hasValue) {
            return Center(
              child: AppErrorWidget(error: state.error!, onRetry: notifier.refresh),
            );
          }

          final items = state.value ?? [];

          return EasyRefresh(
            header: AppRefreshHeader(),
            footer: AppLoadFooter(),
            onRefresh: () async {
              await notifier.refresh();
            },
            onLoad: () async {
              await notifier.loadMore();
            },
            child: items.isEmpty
                ? CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        child: Center(
                          child: AppErrorWidget(
                            message: t.common.no_content,
                            onRetry: notifier.refresh,
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
                      return DynamicPostCard(
                        post: post,
                        onLike: (post) => notifier.toggleLike(post.id, post.isLiked),
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
