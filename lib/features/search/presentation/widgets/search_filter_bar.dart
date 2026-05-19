import 'package:flutter/material.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/search/application/search_query.dart';

class SearchFilterBar extends StatelessWidget {
  final SearchOrder order;
  final SearchDuration duration;
  final ValueChanged<SearchOrder> onOrderChanged;
  final ValueChanged<SearchDuration> onDurationChanged;
  final bool showDuration;

  const SearchFilterBar({
    super.key,
    required this.order,
    required this.duration,
    required this.onOrderChanged,
    required this.onDurationChanged,
    this.showDuration = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: t.search.filter.sort_default,
                  selected: order == SearchOrder.totalrank,
                  onSelected: (_) => onOrderChanged(SearchOrder.totalrank),
                ),
                _FilterChip(
                  label: t.search.filter.sort_newest,
                  selected: order == SearchOrder.pubdate,
                  onSelected: (_) => onOrderChanged(SearchOrder.pubdate),
                ),
                _FilterChip(
                  label: t.search.filter.sort_click,
                  selected: order == SearchOrder.click,
                  onSelected: (_) => onOrderChanged(SearchOrder.click),
                ),
                _FilterChip(
                  label: t.search.filter.sort_danmaku,
                  selected: order == SearchOrder.dm,
                  onSelected: (_) => onOrderChanged(SearchOrder.dm),
                ),
                _FilterChip(
                  label: t.search.filter.sort_favorite,
                  selected: order == SearchOrder.stow,
                  onSelected: (_) => onOrderChanged(SearchOrder.stow),
                ),
              ],
            ),
          ),
          if (showDuration) ...[
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: t.search.filter.duration_all,
                    selected: duration == SearchDuration.all,
                    onSelected: (_) => onDurationChanged(SearchDuration.all),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_short,
                    selected: duration == SearchDuration.short,
                    onSelected: (_) => onDurationChanged(SearchDuration.short),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_medium,
                    selected: duration == SearchDuration.medium,
                    onSelected: (_) => onDurationChanged(SearchDuration.medium),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_long,
                    selected: duration == SearchDuration.long,
                    onSelected: (_) => onDurationChanged(SearchDuration.long),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_extra_long,
                    selected: duration == SearchDuration.extraLong,
                    onSelected: (_) => onDurationChanged(SearchDuration.extraLong),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
        labelStyle: theme.textTheme.labelSmall?.copyWith(
          color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          fontSize: 12,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        backgroundColor: Colors.transparent,
        selectedColor: colorScheme.primaryContainer.withValues(alpha: 0.4),
        side: BorderSide.none,
        showCheckmark: false,
      ),
    );
  }
}
