import 'package:culcul/features/video/presentation/widgets/controls/video_overlay_styles.dart';
import 'package:flutter/material.dart';

class PlayerPanelScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  final bool isBottomSheet;
  final double panelWidth;
  final double maxHeightFactor;

  const PlayerPanelScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.isBottomSheet = false,
    this.panelWidth = 360,
    this.maxHeightFactor = 0.78,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: isBottomSheet ? double.infinity : panelWidth,
      constraints: BoxConstraints(
        maxHeight: isBottomSheet
            ? mediaQuery.size.height * maxHeightFactor
            : mediaQuery.size.height,
      ),
      child: ClipRRect(
        borderRadius: isBottomSheet
            ? const BorderRadius.vertical(top: Radius.circular(28))
            : const BorderRadius.horizontal(left: Radius.circular(28)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: VideoOverlayStyles.panelBackground(colorScheme),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.scrim.withValues(alpha: 0.96),
                colorScheme.scrim.withValues(alpha: 0.90),
              ],
            ),
            border: Border.all(color: VideoOverlayStyles.panelOutline(colorScheme)),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(-6, 0),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              top: false,
              bottom: !isBottomSheet,
              left: !isBottomSheet,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isBottomSheet) VideoOverlayStyles.dragHandle(colorScheme),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, isBottomSheet ? 4 : 24, 24, 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: VideoOverlayStyles.titleStyle(colorScheme)
                                    .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0,
                                    ),
                              ),
                              if (subtitle != null) ...[
                                const SizedBox(height: 6),
                                Text(
                                  subtitle!,
                                  style: VideoOverlayStyles.bodyStyle(
                                    colorScheme,
                                  ).copyWith(fontSize: 13),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (trailing != null) trailing!,
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: VideoOverlayStyles.panelOutline(colorScheme, alpha: 0.08),
                  ),
                  Flexible(child: child),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerPanelSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  final bool dense;
  final bool showBody;

  const PlayerPanelSection({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.dense = false,
    this.showBody = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final contentPadding = dense ? 14.0 : 18.0;
    final subtitleSpacing = dense ? 4.0 : 6.0;
    final sectionSpacing = dense ? 12.0 : 16.0;
    final titleSize = dense ? 14.0 : 15.0;
    final bodyStyle = VideoOverlayStyles.bodyStyle(
      colorScheme,
    ).copyWith(fontSize: dense ? 12 : 13);

    return Container(
      padding: EdgeInsets.all(contentPadding),
      decoration: BoxDecoration(
        color: VideoOverlayStyles.panelSurface(colorScheme),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: VideoOverlayStyles.panelOutline(colorScheme)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: VideoOverlayStyles.titleStyle(
                        colorScheme,
                      ).copyWith(fontSize: titleSize),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: subtitleSpacing),
                      Text(subtitle!, style: bodyStyle),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (showBody) ...[SizedBox(height: sectionSpacing), child],
        ],
      ),
    );
  }
}

class PlayerOptionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback? onTap;

  const PlayerOptionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.isSelected = false,
    this.isEnabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedColor = colorScheme.primaryContainer;
    final unselectedColor = VideoOverlayStyles.panelSurface(colorScheme, alpha: 0.52);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          constraints: const BoxConstraints(minWidth: 104, maxWidth: 180),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : unselectedColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.9)
                  : VideoOverlayStyles.panelOutline(
                      colorScheme,
                      alpha: isEnabled ? 0.08 : 0.04,
                    ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isEnabled
                            ? (isSelected
                                  ? colorScheme.onPrimaryContainer
                                  : VideoOverlayStyles.foreground(colorScheme))
                            : VideoOverlayStyles.foreground(colorScheme, alpha: 0.32),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 6),
                Text(
                  subtitle!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: VideoOverlayStyles.bodyStyle(colorScheme).copyWith(
                    color: isEnabled
                        ? (isSelected
                              ? colorScheme.onPrimaryContainer.withValues(alpha: 0.76)
                              : VideoOverlayStyles.foreground(colorScheme, alpha: 0.62))
                        : VideoOverlayStyles.foreground(colorScheme, alpha: 0.24),
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerMenuOptionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const PlayerMenuOptionTile({
    super.key,
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
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer.withValues(alpha: 0.95)
                : VideoOverlayStyles.panelSurface(colorScheme, alpha: 0.48),
            borderRadius: BorderRadius.circular(18),
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
                      const SizedBox(height: 4),
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
                duration: const Duration(milliseconds: 180),
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

class PlayerFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PlayerFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer.withValues(alpha: 0.9)
                : VideoOverlayStyles.panelSurface(colorScheme, alpha: 0.44),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.9)
                  : VideoOverlayStyles.panelOutline(colorScheme, alpha: 0.08),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : VideoOverlayStyles.foreground(colorScheme, alpha: 0.74),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerPanelEmptyState extends StatelessWidget {
  final String label;

  const PlayerPanelEmptyState({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: VideoOverlayStyles.panelSurface(colorScheme, alpha: 0.42),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: VideoOverlayStyles.panelOutline(colorScheme, alpha: 0.08),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: VideoOverlayStyles.bodyStyle(colorScheme),
      ),
    );
  }
}
