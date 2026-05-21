part of 'player_panel.dart';

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
        borderRadius: BorderRadius.circular(CulculRadius.xl),
        child: AnimatedContainer(
          duration: CulculMotion.fast,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: CulculSpacing.md,
            vertical: CulculSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer.withValues(alpha: 0.9)
                : VideoOverlayStyles.panelSurface(colorScheme, alpha: 0.44),
            borderRadius: BorderRadius.circular(CulculRadius.xl),
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
