import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/features/dynamic/controllers/dynamic_comment_controller.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_detail_bottom_bar.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_detail_header.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_comments_view.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicDetailPage extends HookConsumerWidget {
  final String dynamicId;

  const DynamicDetailPage({super.key, required this.dynamicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final post = useState<DynamicItem?>(null);
    final isLoading = useState(true);
    final error = useState<String?>(null);
    final commentController = useTextEditingController();

    // We need a way to refresh comments, so we get the controller for comments
    // But we can only get it if we have a post.

    Future<void> loadDetail() async {
      final result = await ref.read(dynamicRepositoryProvider).getDetail(dynamicId);

      result.when(
        success: (data) {
          post.value = data;
          isLoading.value = false;
        },
        failure: (e) {
          error.value = e.toString();
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      loadDetail();
      return null;
    }, []);

    void submitComment() {
      if (post.value == null) return;
      final text = commentController.text.trim();
      if (text.isEmpty) return;

      ref
          .read(dynamicCommentControllerProvider(post.value!).notifier)
          .addReply(0, 0, text);
      commentController.clear();
      FocusScope.of(context).unfocus();
    }

    Future<void> handleLike() async {
      if (post.value == null) return;

      final item = post.value!;
      final newStatus = !item.isLiked;
      final newLikeCount = item.likeCount + (newStatus ? 1 : -1);

      // Deep copy update logic
      final newStatLike = item.modules.moduleStat?.like.copyWith(
        count: newLikeCount,
        status: newStatus,
      );

      if (item.modules.moduleStat == null || newStatLike == null) return;

      final newModuleStat = item.modules.moduleStat!.copyWith(like: newStatLike);
      final newModules = item.modules.copyWith(moduleStat: newModuleStat);
      final newItem = item.copyWith(modules: newModules);

      // Optimistic update
      post.value = newItem;

      final result = await ref
          .read(dynamicRepositoryProvider)
          .likeDynamic(item.id, newStatus);

        if (result.isFailure) {
        // Revert
        post.value = item;
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.moments.operation_failed(message: (result as Failure).exception.toString()))),
          );
        }
      }
    }

    if (isLoading.value) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (error.value != null) {
      return Scaffold(
        appBar: AppBar(title: Text(t.moments.detail_title)),
        body: Center(child: Text(error.value!)),
      );
    }

    if (post.value == null) return const SizedBox();

    return Scaffold(
      appBar: AppBar(title: Text(t.moments.detail_title)),
      body: EasyRefresh(
        onRefresh: () async {
          await loadDetail();
          if (post.value != null) {
            return ref
                .read(dynamicCommentControllerProvider(post.value!).notifier)
                .refresh();
          }
        },
        onLoad: () async {
          if (post.value != null) {
            return ref
                .read(dynamicCommentControllerProvider(post.value!).notifier)
                .loadMore();
          }
        },
        header: const AppRefreshHeader(),
        footer: AppLoadFooter(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: DynamicDetailHeader(post: post.value!)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DynamicContentWidget(post: post.value!),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const SliverToBoxAdapter(child: Divider(height: 1)),
            DynamicCommentsSliver(post: post.value!),
            // Add some padding at bottom for the input bar
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      bottomNavigationBar: DynamicDetailBottomBar(
        post: post.value!,
        onLike: handleLike,
        onSubmitComment: submitComment,
        commentController: commentController,
      ),
    );
  }
}

