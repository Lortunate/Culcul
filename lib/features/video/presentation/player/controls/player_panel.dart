import 'package:culcul/features/video/presentation/player/controls/video_overlay_styles.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';

class PlayerPanelScaffold extends StatelessWidget {
  final Widget child;
  final bool isBottomSheet;
  final double panelWidth;
  final double maxHeightFactor;

  const PlayerPanelScaffold({
    super.key,
    required this.child,
    required this.isBottomSheet,
    this.panelWidth = 360,
    this.maxHeightFactor = 0.78,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: isBottomSheet ? double.infinity : panelWidth,
      constraints: BoxConstraints(
        maxHeight: isBottomSheet ? screenHeight * maxHeightFactor : screenHeight,
      ),
      child: ClipRRect(
        borderRadius: isBottomSheet
            ? const BorderRadius.vertical(top: CulculRadius.radiusXl)
            : const BorderRadius.horizontal(left: CulculRadius.radiusXl),
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
  final Color? backgroundColor;
  final double outlineAlpha;
  final double cornerRadius;

  const PlayerPanelSection({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.dense = false,
    this.showBody = true,
    this.backgroundColor,
    this.outlineAlpha = 0.12,
    this.cornerRadius = 22,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final contentPadding = dense ? 14.0 : 18.0;
    final subtitleSpacing = dense ? CulculSpacing.xxs : 6.0;
    final sectionSpacing = dense ? CulculSpacing.sm : CulculSpacing.md;
    final titleSize = dense ? 14.0 : 15.0;
    final bodyStyle = VideoOverlayStyles.bodyStyle(
      colorScheme,
    ).copyWith(fontSize: dense ? 12 : 13);

    return Container(
      padding: EdgeInsets.all(contentPadding),
      decoration: BoxDecoration(
        color: backgroundColor ?? VideoOverlayStyles.panelSurface(colorScheme),
        borderRadius: BorderRadius.circular(cornerRadius),
        border: Border.all(
          color: VideoOverlayStyles.panelOutline(colorScheme, alpha: outlineAlpha),
        ),
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
              ?trailing,
            ],
          ),
          if (showBody) ...[SizedBox(height: sectionSpacing), child],
        ],
      ),
    );
  }
}
