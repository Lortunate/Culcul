import 'package:culcul/features/video/presentation/widgets/controls/player_panel.dart';
import 'package:flutter/material.dart';

class QuickSelectionSheet<T> extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T> onSelected;
  final String Function(T) labelBuilder;
  final String? Function(T)? subtitleBuilder;
  final String? emptyText;
  final bool isBottomSheet;

  const QuickSelectionSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    required this.labelBuilder,
    this.selectedItem,
    this.subtitle,
    this.subtitleBuilder,
    this.emptyText,
    this.isBottomSheet = false,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = isBottomSheet
        ? MediaQuery.paddingOf(context).bottom + 20
        : 20.0;

    return PlayerPanelScaffold(
      title: title,
      subtitle: subtitle,
      isBottomSheet: isBottomSheet,
      panelWidth: 320,
      maxHeightFactor: 0.68,
      child: items.isEmpty
          ? Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
              child: PlayerPanelEmptyState(label: emptyText ?? ''),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
              itemCount: items.length,
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = item == selectedItem;

                return PlayerMenuOptionTile(
                  title: labelBuilder(item),
                  subtitle: subtitleBuilder?.call(item),
                  isSelected: isSelected,
                  onTap: () {
                    onSelected(item);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
    );
  }
}
