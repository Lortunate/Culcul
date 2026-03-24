import 'package:culcul/data/models/toview/to_view_model.dart';
import 'package:culcul/features/to_view/presentation/widgets/to_view_item.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class ToViewListView extends StatelessWidget {
  const ToViewListView({
    super.key,
    required this.items,
    required this.onRefresh,
    required this.onDelete,
    required this.onOpenVideo,
  });

  final List<ToViewModel> items;
  final Future<IndicatorResult> Function() onRefresh;
  final ValueChanged<int> onDelete;
  final ValueChanged<String> onOpenVideo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return EasyRefresh(
      header: const AppRefreshHeader(),
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final aid = item.aid;
          final bvid = item.bvid;
          if (aid == null || bvid == null) {
            return const SizedBox.shrink();
          }

          return _DismissibleToViewItem(
            aid: aid,
            bvid: bvid,
            item: item,
            errorColor: colorScheme.error,
            onDelete: onDelete,
            onOpenVideo: onOpenVideo,
          );
        },
      ),
    );
  }
}

class _DismissibleToViewItem extends StatelessWidget {
  const _DismissibleToViewItem({
    required this.aid,
    required this.bvid,
    required this.item,
    required this.errorColor,
    required this.onDelete,
    required this.onOpenVideo,
  });

  final int aid;
  final String bvid;
  final ToViewModel item;
  final Color errorColor;
  final ValueChanged<int> onDelete;
  final ValueChanged<String> onOpenVideo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(aid),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: errorColor,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete_outline, color: Colors.white),
          ),
        ),
      ),
      onDismissed: (_) => onDelete(aid),
      child: ToViewItem(item: item, onTap: () => onOpenVideo(bvid)),
    );
  }
}
