import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/ui/pages/relation/widgets/relation_user_item.dart';
import 'package:easy_refresh/easy_refresh.dart';

class RelationUserList extends StatefulWidget {
  final AsyncValue<List<RelationUser>> asyncValue;
  final RefreshCallback onRefresh;
  final VoidCallback onLoadMore;
  final String emptyText;
  final bool hasMore;

  const RelationUserList({
    super.key,
    required this.asyncValue,
    required this.onRefresh,
    required this.onLoadMore,
    this.emptyText = '暂无数据',
    this.hasMore = false,
  });

  @override
  State<RelationUserList> createState() => _RelationUserListState();
}

class _RelationUserListState extends State<RelationUserList> {
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
      if (widget.hasMore) {
        _erController.callLoad();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.asyncValue.when(
      skipLoadingOnReload: true,
      data: (list) {
        if (list.isEmpty) {
          return Center(child: Text(widget.emptyText));
        }
        return EasyRefresh(
          controller: _erController,
          header: const MaterialHeader(),
          footer: const MaterialFooter(),
          onRefresh: () async {
            await widget.onRefresh();
            return IndicatorResult.success;
          },
          onLoad: () async {
            if (!widget.hasMore) return IndicatorResult.noMore;
            widget.onLoadMore();
            return IndicatorResult.success;
          },
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: list.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, indent: 72, endIndent: 0),
            itemBuilder: (context, index) {
              final item = list[index];
              return RelationUserItem(
                user: item,
                onTap: () {},
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
