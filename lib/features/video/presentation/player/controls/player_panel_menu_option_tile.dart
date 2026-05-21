part of 'player_panel.dart';

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
