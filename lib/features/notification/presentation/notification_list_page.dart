import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:culcul/features/notification/controllers/at_controller.dart';
import 'package:culcul/features/notification/controllers/like_controller.dart';
import 'package:culcul/features/notification/controllers/reply_controller.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_item_widget.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum NotificationType { reply, at, like, system }

const _notificationTitles = {
  NotificationType.reply: '回复我的',
  NotificationType.at: '@我',
  NotificationType.like: '收到的赞',
  NotificationType.system: '系统通知',
};

class NotificationListPage extends ConsumerStatefulWidget {
  final NotificationType type;

  const NotificationListPage({super.key, required this.type});

  @override
  ConsumerState<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends ConsumerState<NotificationListPage> {
  final ScrollController _scrollController = ScrollController();
  final EasyRefreshController _erController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _erController.callLoad();
    }
  }

  void _loadMore() {
    switch (widget.type) {
      case NotificationType.reply:
        ref.read(replyListProvider.notifier).loadMore();
        break;
      case NotificationType.at:
        ref.read(atListProvider.notifier).loadMore();
        break;
      case NotificationType.like:
        ref.read(likeListProvider.notifier).loadMore();
        break;
      case NotificationType.system:
        // TODO: Implement system msg provider
        break;
    }
  }

  AsyncValue<List<ReplyItem>> _providerState(NotificationType type) => switch (type) {
    NotificationType.reply => ref.watch(replyListProvider),
    NotificationType.at => ref.watch(atListProvider),
    NotificationType.like => ref.watch(likeListProvider),
    NotificationType.system => const AsyncValue.data([]),
  };

  @override
  Widget build(BuildContext context) {
    final state = _providerState(widget.type);
    final title = _notificationTitles[widget.type] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: state.when(
        data: (items) {
          if (items.isEmpty) return const _EmptyNotificationView();
          return _NotificationListView(
            items: items,
            scrollController: _scrollController,
            refreshController: _erController,
            onLoadMore: _loadMore,
            itemBuilder: _buildItem,
          );
        },
        error: (e, s) {
          debugPrint('NotificationListPage Error: $e\n$s');
          return AppErrorWidget(
            error: e,
            stackTrace: s,
            onRetry: () {
              switch (widget.type) {
                case NotificationType.reply:
                  ref.invalidate(replyListProvider);
                  break;
                case NotificationType.at:
                  ref.invalidate(atListProvider);
                  break;
                case NotificationType.like:
                  ref.invalidate(likeListProvider);
                  break;
                case NotificationType.system:
                  break;
              }
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildItem(BuildContext context, ReplyItem item) {
    return NotificationItemWidget(item: item, type: widget.type);
  }
}

class _NotificationListView extends StatelessWidget {
  const _NotificationListView({
    required this.items,
    required this.scrollController,
    required this.refreshController,
    required this.onLoadMore,
    required this.itemBuilder,
  });

  final List<ReplyItem> items;
  final ScrollController scrollController;
  final EasyRefreshController refreshController;
  final VoidCallback onLoadMore;
  final Widget Function(BuildContext context, ReplyItem item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: refreshController,
      footer: const MaterialFooter(),
      onLoad: () async {
        onLoadMore();
        return IndicatorResult.success;
      },
      child: ListView.separated(
        controller: scrollController,
        itemCount: items.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) => itemBuilder(context, items[index]),
      ),
    );
  }
}

class _EmptyNotificationView extends StatelessWidget {
  const _EmptyNotificationView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('暂无消息'));
  }
}
