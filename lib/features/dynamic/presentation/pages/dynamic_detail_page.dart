import 'package:culcul/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_detail_bottom_bar.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_detail_header.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_comments_view.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/features/dynamic/presentation/pages/dynamic_detail_page_commands.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/pagination/pagination_load_gate.dart';
import 'package:culcul/shared/widgets/app_error_widget.dart';
import 'package:culcul/shared/widgets/refresh_header_footer.dart';
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
    final provider = dynamicDetailViewModelProvider(dynamicId);
    final state = ref.watch(provider);
    final commentController = useTextEditingController();
    final loadGate = useMemoized(PaginationLoadGate.new, [dynamicId]);
    final commands = DynamicDetailPageCommands.fromPage(
      context: context,
      ref: ref,
      dynamicId: dynamicId,
      commentController: commentController,
      loadGate: loadGate,
    );

    if (state.isLoading && state.post == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.error != null && state.post == null) {
      return Scaffold(
        appBar: AppBar(title: Text(t.moments.detail_title)),
        body: Center(
          child: AppErrorWidget(
            error: state.error!,
            onRetry: commands.refreshDetailAndComments,
          ),
        ),
      );
    }

    final post = state.post;
    if (post == null) return const SizedBox();
    final commentState = ref.watch(dynamicCommentControllerProvider(post));
    final hasMore = commentState.paging.hasMore;

    return Scaffold(
      appBar: AppBar(title: Text(t.moments.detail_title)),
      body: EasyRefresh(
        onRefresh: commands.refreshDetailAndComments,
        onLoad: !hasMore ? null : commands.loadMoreComments,
        header: const AppRefreshHeader(),
        footer: hasMore ? AppLoadFooter() : null,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: DynamicDetailHeader(post: post)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DynamicContentWidget(post: post, selectableText: true),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const SliverToBoxAdapter(child: Divider(height: 1)),
            DynamicCommentsSliver(post: post),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      bottomNavigationBar: DynamicDetailBottomBar(
        post: post,
        onLike: commands.handleLike,
        onSubmitComment: commands.submitComment,
        commentController: commentController,
      ),
    );
  }
}
