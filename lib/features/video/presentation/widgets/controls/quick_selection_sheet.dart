import 'package:flutter/material.dart';

class QuickSelectionSheet<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T selectedItem;
  final ValueChanged<T> onSelected;
  final String Function(T) labelBuilder;
  final bool isBottomSheet;

  const QuickSelectionSheet({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    required this.labelBuilder,
    this.isBottomSheet = false,
  });

  @override
  Widget build(BuildContext context) {
    // Panel width for side menu (landscape)
    const double panelWidth = 280.0;

    return Container(
      width: isBottomSheet ? double.infinity : panelWidth,
      constraints: BoxConstraints(
        maxHeight: isBottomSheet
            ? MediaQuery.of(context).size.height * 0.6
            : double.infinity,
      ),
      child: ClipRRect(
        borderRadius: isBottomSheet
            ? const BorderRadius.vertical(top: Radius.circular(24))
            : const BorderRadius.horizontal(left: Radius.circular(24)),
        child: Container(
          color: const Color(0xE61E1E1E),
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              top: false,
              bottom: !isBottomSheet,
              left: !isBottomSheet,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isBottomSheet)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        isBottomSheet ? 8 : 8,
                        16,
                        isBottomSheet ? MediaQuery.of(context).padding.bottom + 16 : 16,
                      ),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isSelected = item == selectedItem;
                        final colorScheme = Theme.of(context).colorScheme;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: InkWell(
                            onTap: () {
                              onSelected(item);
                              // Close after selection? Usually yes for quick actions
                              // But let the parent handle closing if needed, or we pop here
                              // Typically we want to pop.
                              Navigator.of(context).pop();
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colorScheme.primary.withValues(alpha: 0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: isSelected
                                    ? Border.all(
                                        color: colorScheme.primary.withValues(alpha: 0.5),
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      labelBuilder(item),
                                      style: TextStyle(
                                        color: isSelected
                                            ? colorScheme.primary
                                            : Colors.white70,
                                        fontSize: 15,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_rounded,
                                      color: colorScheme.primary,
                                      size: 20,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
