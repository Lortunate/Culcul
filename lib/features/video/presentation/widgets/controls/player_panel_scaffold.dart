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
                        ?trailing,
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
