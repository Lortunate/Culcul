part of 'player_panel.dart';

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
    const cardRadius = BorderRadius.all(
      Radius.circular(CulculRadius.lg + CulculSpacing.xxs / 2),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: cardRadius,
        child: AnimatedContainer(
          duration: CulculMotion.fast,
          curve: Curves.easeOutCubic,
          constraints: const BoxConstraints(minWidth: 104, maxWidth: 180),
          padding: const EdgeInsets.all(CulculSpacing.sm + CulculSpacing.xxs / 2),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : unselectedColor,
            borderRadius: cardRadius,
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
                const SizedBox(height: CulculSpacing.sm / 2),
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
