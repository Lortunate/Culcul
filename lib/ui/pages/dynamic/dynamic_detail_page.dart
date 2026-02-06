import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/router/router.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/domain/entities/dynamic_post.dart';
import 'package:culcul/providers/dynamic/dynamic_comment_controller.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_comments_view.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_content_widget.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:culcul/utils/share_utils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicDetailPage extends ConsumerStatefulWidget {
  final String dynamicId;

  const DynamicDetailPage({super.key, required this.dynamicId});

  @override
  ConsumerState<DynamicDetailPage> createState() => _DynamicDetailPageState();
}

class _DynamicDetailPageState extends ConsumerState<DynamicDetailPage> {
  DynamicPost? _post;
  bool _isLoading = true;
  String? _error;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadDetail() async {
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getDetail(widget.dynamicId);
    
    if (mounted) {
      result.when(
        success: (post) {
          setState(() {
            _post = post;
            _isLoading = false;
          });
        },
        failure: (e) {
          setState(() {
            _error = e.toString();
            _isLoading = false;
          });
        },
      );
    }
  }

  void _submitComment() {
    if (_post == null) return;
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    // Root comment: root=0, parent=0
    ref.read(dynamicCommentControllerProvider(_post!).notifier).addReply(
          0,
          0,
          text,
        );
    _commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('动态详情')),
        body: Center(child: Text(_error!)),
      );
    }

    if (_post == null) return const SizedBox();

    return Scaffold(
      appBar: AppBar(title: const Text('动态详情')),
      body: EasyRefresh(
        onRefresh: () async {
          await _loadDetail();
          if (_post != null) {
            return ref
                .read(dynamicCommentControllerProvider(_post!).notifier)
                .refresh();
          }
        },
        onLoad: () async {
          if (_post != null) {
            return ref
                .read(dynamicCommentControllerProvider(_post!).notifier)
                .loadMore();
          }
        },
        header: const ClassicHeader(
          dragText: '下拉刷新',
          armedText: '释放刷新',
          readyText: '正在刷新...',
          processingText: '正在刷新...',
          processedText: '刷新完成',
          noMoreText: '没有更多了',
          failedText: '刷新失败',
          messageText: '最后更新于 %T',
        ),
        footer: const ClassicFooter(
          dragText: '上拉加载',
          armedText: '释放加载',
          readyText: '正在加载...',
          processingText: '正在加载...',
          processedText: '加载完成',
          noMoreText: '没有更多了',
          failedText: '加载失败',
          messageText: '最后更新于 %T',
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DynamicContentWidget(post: _post!),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const SliverToBoxAdapter(child: Divider(height: 1)),
            DynamicCommentsSliver(post: _post!),
            // Add some padding at bottom for the input bar
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        UserProfileRoute(mid: _post!.authorMid).push(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: Row(
          children: [
            AppAvatar(url: _post!.authorAvatar, size: 42),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _post!.authorName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: _post!.authorName == '哔哩哔哩番剧' || _post!.authorName == '哔哩哔哩漫画'
                          ? const Color(0xFFFB7299)
                          : colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _post!.timeText,
                    style: const TextStyle(
                      color: Color(0xFF9499A0),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, size: 20, color: Color(0xFF9499A0)),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8 + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: '发一条友善的评论',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _submitComment(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _submitComment,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          _buildActionIcon(
            _post!.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
            _post!.likeCount,
            () => _handleLike(context),
            color: _post!.isLiked ? Theme.of(context).colorScheme.primary : null,
          ),
          const SizedBox(width: 16),
          _buildActionIcon(
            Icons.reply_rounded,
            _post!.forwardCount,
            () => ShareUtils.shareDynamic(_post!.id, _post!.description ?? ''),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, int count, VoidCallback onTap, {Color? color}) {
    final contentColor = color ?? const Color(0xFF9499A0);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: contentColor),
          if (count > 0)
            Text(
              '$count',
              style: TextStyle(
                fontSize: 10,
                color: contentColor,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _handleLike(BuildContext context) async {
    if (_post == null) return;
    
    final newStatus = !_post!.isLiked;
    // Optimistic update
    setState(() {
      _post = _post!.copyWith(
        isLiked: newStatus,
        likeCount: _post!.likeCount + (newStatus ? 1 : -1),
      );
    });
      
    final result = await ref.read(dynamicRepositoryProvider).likeDynamic(
          _post!.id,
          newStatus,
        );
        
    if (result.isFailure && mounted) {
       // Revert
       final oldStatus = !newStatus;
       setState(() {
          _post = _post!.copyWith(
            isLiked: oldStatus,
            likeCount: _post!.likeCount + (oldStatus ? 1 : -1),
          );
       });
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('操作失败: ${(result as Failure).exception}')),
       );
    }
  }
}
