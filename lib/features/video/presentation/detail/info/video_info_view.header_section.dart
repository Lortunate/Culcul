part of 'video_info_view.dart';

class _VideoInfoHeaderSection extends StatelessWidget {
  final VideoDetail detail;
  final bool isFollowed;
  final ValueNotifier<bool> isExpanded;
  final VoidCallback onToggleFollow;

  const _VideoInfoHeaderSection({
    required this.detail,
    required this.isFollowed,
    required this.isExpanded,
    required this.onToggleFollow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: UploaderSection(
            owner: detail.owner,
            isFollowed: isFollowed,
            onToggleFollow: onToggleFollow,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppClickable(
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    detail.title,
                    maxLines: isExpanded.value ? null : 1,
                    overflow: isExpanded.value ? null : TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.28,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  isExpanded.value
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: VideoStatsRow(detail: detail, showBvid: isExpanded.value),
        ),
        if (isExpanded.value) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ExpandableDescriptionAndTags(
              description: detail.desc,
              tags: detail.tag,
            ),
          ),
        ],
      ],
    );
  }
}
