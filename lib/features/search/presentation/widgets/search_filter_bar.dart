import 'package:flutter/material.dart';
import 'package:culcul/i18n/strings.g.dart';

class SearchFilterBar extends StatelessWidget {
  final String order;
  final int duration;
  final ValueChanged<String> onOrderChanged;
  final ValueChanged<int> onDurationChanged;
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
                  selected: order == 'totalrank',
                  onSelected: (_) => onOrderChanged('totalrank'),
                ),
                _FilterChip(
                  label: t.search.filter.sort_newest,
                  selected: order == 'pubdate',
                  onSelected: (_) => onOrderChanged('pubdate'),
                ),
                _FilterChip(
                  label: t.search.filter.sort_click,
                  selected: order == 'click',
                  onSelected: (_) => onOrderChanged('click'),
                ),
                _FilterChip(
                  label: t.search.filter.sort_danmaku,
                  selected: order == 'dm',
                  onSelected: (_) => onOrderChanged('dm'),
                ),
                _FilterChip(
                  label: t.search.filter.sort_favorite,
                  selected: order == 'stow',
                  onSelected: (_) => onOrderChanged('stow'),
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
                    selected: duration == 0,
                    onSelected: (_) => onDurationChanged(0),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_short,
                    selected: duration == 1,
                    onSelected: (_) => onDurationChanged(1),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_medium,
                    selected: duration == 2,
                    onSelected: (_) => onDurationChanged(2),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_long,
                    selected: duration == 3,
                    onSelected: (_) => onDurationChanged(3),
                  ),
                  _FilterChip(
                    label: t.search.filter.duration_extra_long,
                    selected: duration == 4,
                    onSelected: (_) => onDurationChanged(4),
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
