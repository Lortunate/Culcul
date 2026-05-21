part of 'player_panel.dart';

class PlayerPanelEmptyState extends StatelessWidget {
  final String label;

  const PlayerPanelEmptyState({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
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
        label,
        textAlign: TextAlign.center,
        style: VideoOverlayStyles.bodyStyle(colorScheme),
      ),
    );
  }
}
