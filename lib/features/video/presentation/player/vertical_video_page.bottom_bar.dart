part of 'vertical_video_page.dart';

class _BottomBar extends ConsumerWidget {
  final VideoDetail videoDetail;
  final PlayerController playerController;

  const _BottomBar({required this.videoDetail, required this.playerController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(playbackDurationProvider);
    final maxValue = duration.inSeconds > 0 ? duration.inSeconds.toDouble() : 1.0;
    final colorScheme = Theme.of(context).colorScheme;
    final t = context.t;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, colorScheme.scrim.withValues(alpha: 0.87)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAuthorRow(colorScheme, t),
          const SizedBox(height: 12),
          _buildTitleRow(colorScheme),
          const SizedBox(height: 4),
          _buildPlayCountRow(colorScheme, t),
          const SizedBox(height: 12),
          _buildProgressBar(position, maxValue, colorScheme),
          _buildActionRow(colorScheme, t),
        ],
      ),
    );
  }

  Widget _buildAuthorRow(ColorScheme colorScheme, Translations t) {
    return Row(
      children: [
        AppAvatar(url: videoDetail.owner.face, size: 36, onTap: () {}),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              videoDetail.owner.name,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${t.profile.stats.followers} 504.4${t.format.ten_thousand}',
              style: TextStyle(
                color: colorScheme.onPrimary.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '+ ${t.actions.follow}',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleRow(ColorScheme colorScheme) {
    // Keep high contrast for on-video readability.
    return Row(
      children: [
        Expanded(
          child: Text(
            videoDetail.title,
            style: TextStyle(color: colorScheme.onPrimary, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.keyboard_arrow_down,
          color: colorScheme.onPrimary.withValues(alpha: 0.7),
          size: 20,
        ),
      ],
    );
  }

  Widget _buildPlayCountRow(ColorScheme colorScheme, Translations t) {
    return Row(
      children: [
        Icon(
          Icons.play_circle_outline,
          size: 12,
          color: colorScheme.onPrimary.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 4),
        Text(
          t.common.view_count(count: FormatUtils.formatNumber(videoDetail.stat.view)),
          style: TextStyle(
            color: colorScheme.onPrimary.withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(Duration position, double maxValue, ColorScheme colorScheme) {
    return SizedBox(
      height: 20,
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 2,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 8),
          activeTrackColor: colorScheme.onPrimary,
          inactiveTrackColor: colorScheme.onPrimary.withValues(alpha: 0.24),
          thumbColor: colorScheme.onPrimary,
        ),
        child: Slider(
          value: position.inSeconds.toDouble().clamp(0, maxValue),
          max: maxValue,
          onChanged: (value) => playerController.seek(Duration(seconds: value.toInt())),
        ),
      ),
    );
  }

  Widget _buildActionRow(ColorScheme colorScheme, Translations t) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Text(
                  t.video.player.danmaku_closed,
                  style: TextStyle(
                    color: colorScheme.onPrimary.withValues(alpha: 0.54),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(Icons.notes, color: colorScheme.onPrimary, size: 24),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.onPrimary.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            t.video.detail_page,
            style: TextStyle(color: colorScheme.onPrimary, fontSize: 10),
          ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.fullscreen, color: colorScheme.onPrimary, size: 24),
      ],
    );
  }
}
