import 'package:culcul/core/constants/app_dimens.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/features/profile/presentation/relation/widgets/relation_user_item.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/core/widgets/privacy_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RelationUserList extends StatelessWidget {
  final AsyncValue<List<RelationUser>> asyncValue;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;
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
  Widget build(BuildContext context) {
    return SmartPagingView<RelationUser>(
      asyncValue: asyncValue,
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      hasMore: hasMore,
      emptyText: emptyText,
      skeleton: const Center(child: CircularProgressIndicator()), // TODO: Better skeleton
      errorBuilder: (context, error, stack) {
        if (error is AppException && error.code == 22115) {
          return const PrivacyErrorWidget();
        }
        return AppErrorWidget(
          error: error,
          onRetry: onRefresh,
        );
      },
      builder: (context, list) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.p8),
          itemCount: list.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 1, indent: 76, endIndent: 0),
          itemBuilder: (context, index) {
            final item = list[index];
            return RelationUserItem(user: item);
          },
        );
      },
    );
  }
}
