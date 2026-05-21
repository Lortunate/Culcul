part of 'player_panel.dart';

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
