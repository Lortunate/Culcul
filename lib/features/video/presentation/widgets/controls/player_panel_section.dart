part of 'player_panel.dart';

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
              ?trailing,
            ],
          ),
          if (showBody) ...[SizedBox(height: sectionSpacing), child],
        ],
      ),
    );
  }
}
