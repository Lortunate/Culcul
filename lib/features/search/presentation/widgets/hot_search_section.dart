import 'package:culcul/features/search/controllers/search_controller.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/search/presentation/widgets/hot_search_skeleton.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:culcul/ui/widgets/app_section_header.dart';
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
        AppSectionHeader(
          title: t.search.hot_search,
          padding: const EdgeInsets.only(bottom: 12),
        ),
        trendingAsync.when(
          data: (data) {
            if (data == null || data.list.isEmpty) {
              return SizedBox(
                height: 120,
                child: Center(
                  child: Text(t.common.no_content, style: theme.textTheme.bodyMedium),
                ),
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
              itemCount: data.list.length,
              itemBuilder: (context, index) {
                final item = data.list[index];
                return _HotSearchItem(
                  position: item.position,
                  keyword: item.showName,
                  onTap: () => onTap(item.keyword),
                );
              },
            );
          },
          loading: () => const HotSearchSkeleton(),
          error: (error, stack) => SizedBox(
            height: 120,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded, color: colorScheme.error, size: 24),
                  const SizedBox(height: 8),
                  Text(
                    t.common.error,
                    style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                  ),
                ],
              ),
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
    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
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
    );
  }
}

