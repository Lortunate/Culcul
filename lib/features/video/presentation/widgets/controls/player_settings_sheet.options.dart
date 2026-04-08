part of 'player_settings_sheet.dart';

class _HorizontalTextOptionStrip<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;

  const _HorizontalTextOptionStrip({
    required this.items,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            _OptionTextChip<T>(
              item: items[i],
              selectedItem: selectedItem,
              labelBuilder: labelBuilder,
              onSelected: onSelected,
            ),
            if (i != items.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _OptionTextChip<T> extends StatelessWidget {
  final T item;
  final T? selectedItem;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;

  const _OptionTextChip({
    required this.item,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = item == selectedItem;
    final label = labelBuilder(item);

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onSelected(item),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              style: TextStyle(
                color: isSelected
                    ? colorScheme.primary
                    : VideoOverlayStyles.foreground(colorScheme, alpha: 0.62),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                height: 1.15,
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
