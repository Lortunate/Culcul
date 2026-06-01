import 'package:culcul/features/video/presentation/player/controls/player_panel.dart';
import 'package:culcul/features/video/presentation/player/controls/video_overlay_styles.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';

class QuickSelectionSheet<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T> onSelected;
  final String Function(T) labelBuilder;
  final String? Function(T)? subtitleBuilder;
  final String? emptyText;
  final bool isBottomSheet;

  const QuickSelectionSheet({
    super.key,
    required this.items,
    required this.onSelected,
    required this.labelBuilder,
    this.selectedItem,
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
      isBottomSheet: isBottomSheet,
      panelWidth: 320,
      maxHeightFactor: 0.68,
      child: items.isEmpty
          ? Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
              child: Builder(
                builder: (context) {
                  final colorScheme = Theme.of(context).colorScheme;
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: CulculSpacing.md,
                      vertical: CulculSpacing.lg,
                    ),
                    decoration: BoxDecoration(
                      color: VideoOverlayStyles.panelSurface(colorScheme, alpha: 0.42),
                      borderRadius: BorderRadius.circular(CulculRadius.lg),
                      border: Border.all(
                        color: VideoOverlayStyles.panelOutline(colorScheme, alpha: 0.08),
                      ),
                    ),
                    child: Text(
                      emptyText ?? '',
                      textAlign: TextAlign.center,
                      style: VideoOverlayStyles.bodyStyle(colorScheme),
                    ),
                  );
                },
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
              itemCount: items.length,
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = item == selectedItem;

                return _PlayerMenuOptionTile(
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

class _PlayerMenuOptionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlayerMenuOptionTile({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CulculRadius.lg),
        child: AnimatedContainer(
          duration: CulculMotion.fast,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: CulculSpacing.md,
            vertical: CulculSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer.withValues(alpha: 0.95)
                : VideoOverlayStyles.panelSurface(colorScheme, alpha: 0.48),
            borderRadius: BorderRadius.circular(CulculRadius.lg),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.9)
                  : VideoOverlayStyles.panelOutline(colorScheme, alpha: 0.08),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isSelected
                            ? colorScheme.onPrimaryContainer
                            : VideoOverlayStyles.foreground(colorScheme),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: CulculSpacing.xxs),
                      Text(
                        subtitle!,
                        style: VideoOverlayStyles.bodyStyle(colorScheme).copyWith(
                          color: isSelected
                              ? colorScheme.onPrimaryContainer.withValues(alpha: 0.72)
                              : VideoOverlayStyles.foreground(colorScheme, alpha: 0.58),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: CulculMotion.fast,
                child: isSelected
                    ? Icon(
                        Icons.check_circle_rounded,
                        key: const ValueKey('selected'),
                        color: colorScheme.primary,
                        size: 20,
                      )
                    : Icon(
                        Icons.chevron_right_rounded,
                        key: const ValueKey('unselected'),
                        color: VideoOverlayStyles.foreground(colorScheme, alpha: 0.36),
                        size: 20,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
