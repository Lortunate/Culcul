import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/profile/presentation/widgets/relation_user_item.dart';
import 'package:culcul/core/models/relation_user_contract.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RelationUserList extends StatelessWidget {
  final AsyncValue<List<ProfileRelationUser>> asyncValue;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;
  final String emptyText;
  final bool hasMore;

  const RelationUserList({
    super.key,
    required this.asyncValue,
    required this.onRefresh,
    required this.onLoadMore,
    required this.emptyText,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SmartPagingView<ProfileRelationUser>(
      asyncValue: asyncValue,
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      itemCount: () => asyncValue.value?.length ?? 0,
      hasMore: hasMore,
      emptyText: emptyText,
      skeleton: const Center(child: CircularProgressIndicator()),
      errorBuilder: (context, error, stack) {
        if (error is AppError && error.code == 22115) {
          final colorScheme = Theme.of(context).colorScheme;
          final textTheme = Theme.of(context).textTheme;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 64.0,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16.0),
                Text(
                  t.profile.privacy_title,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  t.profile.privacy_message,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }
        return AppErrorWidget(error: error, stackTrace: stack, onRetry: onRefresh);
      },
      builder: (context, list) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
