import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/search/presentation/widgets/hot_search_skeleton.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/app_section_header.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HotSearchSection extends ConsumerWidget {
  final ValueChanged<String> onTap;

  const HotSearchSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final trendingAsync = ref.watch(trendingRankingProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: t.search.hot_search,
          padding: const EdgeInsets.only(bottom: 12),
        ),
        trendingAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return SizedBox(
                height: 120,
                child: AppEmptyStateWidget(message: t.common.no_content, compact: true),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 40,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _HotSearchItem(
                  position: item.position,
                  keyword: item.label,
                  onTap: () => onTap(item.keyword),
                );
              },
            );
          },
          loading: () => const HotSearchSkeleton(),
          error: (error, stack) => SizedBox(
            height: 120,
            child: AppErrorWidget(
              error: error,
              stackTrace: stack,
              onRetry: () => ref.refresh(trendingRankingProvider),
              variant: AppErrorWidgetVariant.compact,
            ),
          ),
        ),
      ],
    );
  }
}

class _HotSearchItem extends StatelessWidget {
  final int position;
  final String keyword;
  final VoidCallback onTap;

  const _HotSearchItem({
    required this.position,
    required this.keyword,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: AppClickable(
        onTap: onTap,
        child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '$position',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                color: position < 4
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              keyword,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                fontWeight: position < 4 ? FontWeight.w600 : FontWeight.w400,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
