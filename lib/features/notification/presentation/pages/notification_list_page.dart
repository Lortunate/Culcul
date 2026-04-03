import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/presentation/view_models/notification_feed_view_model.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_item_widget.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationListPage extends ConsumerStatefulWidget {
  final NotificationFeedType type;

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
    if (widget.type == NotificationFeedType.system) return;
    final notifier = ref.read(notificationFeedListProvider(widget.type).notifier);
    if (!notifier.hasMore) return;
    notifier.loadMore();
  }

  AsyncValue<List<NotificationEntry>> _providerState(NotificationFeedType type) =>
      switch (type) {
        NotificationFeedType.reply => ref.watch(notificationFeedListProvider(type)),
        NotificationFeedType.at => ref.watch(notificationFeedListProvider(type)),
        NotificationFeedType.like => ref.watch(notificationFeedListProvider(type)),
        NotificationFeedType.system => const AsyncValue.data([]),
      };

  @override
  Widget build(BuildContext context) {
    final state = _providerState(widget.type);
    final t = i18n(context);
    final colorScheme = Theme.of(context).colorScheme;
    final title = switch (widget.type) {
      NotificationFeedType.reply => t.notification.types.reply,
      NotificationFeedType.at => t.notification.types.at,
      NotificationFeedType.like => t.notification.types.like,
      NotificationFeedType.system => t.notification.types.system,
    };

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
          return AppErrorWidget(
            error: e,
            stackTrace: s,
            onRetry: () {
              switch (widget.type) {
                case NotificationFeedType.reply:
                  ref.invalidate(notificationFeedListProvider(widget.type));
                  break;
                case NotificationFeedType.at:
                  ref.invalidate(notificationFeedListProvider(widget.type));
                  break;
                case NotificationFeedType.like:
                  ref.invalidate(notificationFeedListProvider(widget.type));
                  break;
                case NotificationFeedType.system:
                  break;
              }
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildItem(BuildContext context, NotificationEntry item) {
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

  final List<NotificationEntry> items;
  final ScrollController scrollController;
  final EasyRefreshController refreshController;
  final VoidCallback onLoadMore;
  final Widget Function(BuildContext context, NotificationEntry item) itemBuilder;

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: items.length,
        separatorBuilder: (_, _) => const Column(
          children: [SizedBox(height: 12), Divider(height: 1), SizedBox(height: 12)],
        ),
        itemBuilder: (context, index) => itemBuilder(context, items[index]),
      ),
    );
  }
}

class _EmptyNotificationView extends StatelessWidget {
  const _EmptyNotificationView();

  @override
  Widget build(BuildContext context) {
    final t = i18n(context);
    return Center(child: Text(t.notification.chat.no_message));
  }
}
