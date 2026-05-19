part of 'player_settings_sheet.dart';

class _InlineTextOptionSection<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;
  final String? emptyLabel;

  const _InlineTextOptionSection({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onSelected,
    this.emptyLabel,
  });

  @override
  State<_InlineTextOptionSection<T>> createState() => _InlineTextOptionSectionState<T>();
}

class _InlineTextOptionSectionState<T> extends State<_InlineTextOptionSection<T>> {
  static const double _edgePadding = 8;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scrollViewportKey = GlobalKey();
  late List<GlobalKey> _itemKeys;

  @override
  void initState() {
    super.initState();
    _itemKeys = _buildItemKeys();
    _scheduleScrollToSelected(animated: false);
  }

  @override
  void didUpdateWidget(covariant _InlineTextOptionSection<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_sameItems(oldWidget.items, widget.items)) {
      _itemKeys = _buildItemKeys();
    }

    if (oldWidget.selectedItem != widget.selectedItem ||
        !_sameItems(oldWidget.items, widget.items)) {
      _scheduleScrollToSelected(animated: oldWidget.selectedItem != null);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<GlobalKey> _buildItemKeys() =>
      List<GlobalKey>.generate(widget.items.length, (_) => GlobalKey());

  bool _sameItems(List<T> previous, List<T> next) {
    if (identical(previous, next)) {
      return true;
    }
    if (previous.length != next.length) {
      return false;
    }
    for (var i = 0; i < previous.length; i++) {
      if (previous[i] != next[i]) {
        return false;
      }
    }
    return true;
  }

  void _scheduleScrollToSelected({required bool animated}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _scrollToSelected(animated: animated);
    });
  }

  void _scrollToSelected({required bool animated}) {
    final selectedItem = widget.selectedItem;
    if (selectedItem == null || !_scrollController.hasClients) {
      return;
    }

    final selectedIndex = widget.items.indexOf(selectedItem);
    if (selectedIndex < 0 || selectedIndex >= _itemKeys.length) {
      return;
    }

    final selectedContext = _itemKeys[selectedIndex].currentContext;
    final viewportContext = _scrollViewportKey.currentContext;
    if (selectedContext == null || viewportContext == null) {
      return;
    }

    final selectedBox = selectedContext.findRenderObject() as RenderBox?;
    final viewportBox = viewportContext.findRenderObject() as RenderBox?;
    if (selectedBox == null || viewportBox == null) {
      return;
    }

    final selectedOffset = selectedBox.localToGlobal(Offset.zero, ancestor: viewportBox);
    final selectedStart = selectedOffset.dx;
    final selectedEnd = selectedStart + selectedBox.size.width;
    final viewportWidth = viewportBox.size.width;
    var targetOffset = _scrollController.offset;

    if (selectedStart < _edgePadding) {
      targetOffset += selectedStart - _edgePadding;
    } else if (selectedEnd > viewportWidth - _edgePadding) {
      targetOffset += selectedEnd - (viewportWidth - _edgePadding);
    } else {
      return;
    }

    targetOffset = targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent);
    if ((targetOffset - _scrollController.offset).abs() < 1) {
      return;
    }

    if (animated) {
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
      );
    } else {
      _scrollController.jumpTo(targetOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _settingsSectionBackground(colorScheme),
        borderRadius: BorderRadius.circular(_settingsSectionCornerRadius),
        border: Border.all(
          color: VideoOverlayStyles.panelOutline(
            colorScheme,
            alpha: _settingsSectionOutlineAlpha,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(minWidth: 56),
            child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: VideoOverlayStyles.titleStyle(colorScheme).copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final content = widget.items.isEmpty
                    ? [
                        Text(
                          widget.emptyLabel ?? '',
                          style: VideoOverlayStyles.bodyStyle(
                            colorScheme,
                          ).copyWith(fontSize: 12),
                        ),
                      ]
                    : [
                        for (var i = 0; i < widget.items.length; i++) ...[
                          _OptionTextChip<T>(
                            key: _itemKeys[i],
                            item: widget.items[i],
                            selectedItem: widget.selectedItem,
                            labelBuilder: widget.labelBuilder,
                            onSelected: widget.onSelected,
                          ),
                          if (i != widget.items.length - 1) const SizedBox(width: 10),
                        ],
                      ];

                return SingleChildScrollView(
                  key: _scrollViewportKey,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: Row(children: content),
                  ),
                );
              },
            ),
          ),
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
    super.key,
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
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              style: TextStyle(
                color: isSelected
                    ? colorScheme.primary
                    : VideoOverlayStyles.foreground(colorScheme, alpha: 0.68),
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                height: 1.1,
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
