import 'package:culcul/features/search/presentation/view_models/search_history_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/app_clickable.dart';
import 'package:culcul/shared/widgets/app_section_header.dart';
import 'package:culcul/shared/widgets/app_tag.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchHistorySection extends ConsumerWidget {
  final ValueChanged<String> onTap;

  const SearchHistorySection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final history = ref.watch(searchHistoryProvider);

    if (history.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: t.search.history,
          padding: const EdgeInsets.only(bottom: 12),
          trailing: AppClickable(
            onTap: () => ref.read(searchHistoryProvider.notifier).clear(),
            child: Icon(
              Icons.delete_outline_rounded,
              size: 18,
              color: Theme.of(context).textTheme.labelSmall?.color,
            ),
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: history
              .map((tag) => _SearchTag(tag: tag, onTap: () => onTap(tag)))
              .toList(),
        ),
      ],
    );
  }
}

class _SearchTag extends StatelessWidget {
  final String tag;
  final VoidCallback onTap;

  const _SearchTag({required this.tag, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppClickable(
      onTap: onTap,
      child: AppTag(
        text: tag,
        fontSize: 13,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        borderRadius: 6,
      ),
    );
  }
}
