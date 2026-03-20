import 'package:culcul/data/models/notification/reply_model.dart';
import 'package:culcul/features/notification/controllers/at_controller.dart';
import 'package:culcul/features/notification/controllers/like_controller.dart';
import 'package:culcul/features/notification/controllers/reply_controller.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_item_widget.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum NotificationType { reply, at, like, system }

class NotificationListPage extends ConsumerStatefulWidget {
  final NotificationType type;

  const NotificationListPage({super.key, required this.type});

  @override
  ConsumerState<NotificationListPage> createState() =>
      _NotificationListPageState();
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

  AsyncValue<List<ReplyItem>> _getProviderState() {
    switch (widget.type) {
      case NotificationType.reply:
        return ref.watch(replyListProvider);
      case NotificationType.at:
        return ref.watch(atListProvider);
      case NotificationType.like:
        return ref.watch(likeListProvider);
      case NotificationType.system:
        return const AsyncValue.data([]); // TODO
    }
  }

  String _getTitle() {
    switch (widget.type) {
      case NotificationType.reply:
        return '回复我的';
      case NotificationType.at:
        return '@我';
      case NotificationType.like:
        return '收到的赞';
      case NotificationType.system:
        return '系统通知';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = _getProviderState();

    return Scaffold(
      appBar: AppBar(title: Text(_getTitle())),
      body: state.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('暂无消息'));
          }
          return EasyRefresh(
            controller: _erController,
            footer: const MaterialFooter(),
            onLoad: () async {
              _loadMore();
              return IndicatorResult.success;
            },
            child: ListView.separated(
              controller: _scrollController,
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return _buildItem(context, items[index]);
              },
            ),
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
