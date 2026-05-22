part of 'video_info_view.dart';

class _VideoInfoLoadedContent extends StatelessWidget {
  final VideoDetailViewData detail;
  final bool isFollowed;
  final int currentCid;
  final List<VideoModel> relatedVideos;
  final ValueNotifier<bool> isExpanded;
  final VoidCallback onToggleFollow;
  final VoidCallback onLogin;
  final ValueChanged<int> onOpenUser;
  final ValueChanged<String> onOpenVideo;
  final VoidCallback onLike;
  final VoidCallback onCoin;
  final ValueChanged<int> onPartChanged;

  const _VideoInfoLoadedContent({
    required this.detail,
    required this.isFollowed,
    required this.currentCid,
    required this.relatedVideos,
    required this.isExpanded,
    required this.onToggleFollow,
    required this.onLogin,
    required this.onOpenUser,
    required this.onOpenVideo,
    required this.onLike,
    required this.onCoin,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            _VideoInfoHeaderSection(
              detail: detail,
              isFollowed: isFollowed,
              isExpanded: isExpanded,
              onToggleFollow: onToggleFollow,
              onLogin: onLogin,
              onOpenUser: onOpenUser,
            ),
            _VideoInfoEngagementSection(
              detail: detail,
              currentCid: currentCid,
              hasRecommendations: relatedVideos.isNotEmpty,
              onLike: onLike,
              onCoin: onCoin,
              onPartChanged: onPartChanged,
            ),
          ]),
        ),
        if (relatedVideos.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index.isOdd) {
                  return Divider(
                    height: 16,
                    thickness: 0.5,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.45),
                  );
                }
                return RecommendationItem(
                  video: relatedVideos[index ~/ 2],
                  onOpenVideo: onOpenVideo,
                );
              }, childCount: relatedVideos.length * 2 - 1),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
