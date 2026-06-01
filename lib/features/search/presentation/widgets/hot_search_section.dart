import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HotSearchSection extends ConsumerWidget {
  final ValueChanged<String> onTap;

  const HotSearchSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final trendingAsync = ref.watch(trendingRankingProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.search.hot_search,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
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
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: AppClickable(
                    onTap: () => onTap(item.keyword),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          child: Text(
                            '${item.position}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              color: item.position < 4
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            item.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: item.position < 4
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => AppShimmer(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 40,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return const Row(
                  children: [
                    AppShimmerBox(width: 24, height: 18, borderRadius: 2),
                    SizedBox(width: 4),
                    Expanded(
                      child: AppShimmerBox(
                        height: 16,
                        width: double.infinity,
                        borderRadius: 2,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
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
