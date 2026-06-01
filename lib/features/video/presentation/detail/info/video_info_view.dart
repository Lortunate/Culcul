import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/favorites/presentation/widgets/video_favorite_picker_sheet.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/buttons/app_tag.dart';
import 'package:culcul/ui/widgets/buttons/follow_button.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/media/network_image_prefetch_specs.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:culcul/ui/widgets/users/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class VideoInfoView extends HookConsumerWidget {
  final String bvid;
  final VoidCallback onLogin;
  final ValueChanged<int> onOpenUser;
  final ValueChanged<String> onOpenVideo;

  const VideoInfoView({
    super.key,
    required this.bvid,
    required this.onLogin,
    required this.onOpenUser,
    required this.onOpenVideo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = videoDetailControllerProvider(bvid);
    final state = ref.watch(
      provider.select(
        (state) => (
          isInitialLoading: state.videoDetail == null && state.isLoading,
          error: state.videoDetail == null ? state.error : null,
          detail: state.videoDetail,
          isFollowed: state.videoDetail?.reqUser.attention == 1,
          currentCid: state.currentCid,
          relatedVideos: state.relatedVideos,
        ),
      ),
    );
    final notifier = ref.read(provider.notifier);
    final t = Translations.of(context);

    if (state.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final detail = state.detail;
    if (detail == null) {
      return AppErrorWidget(
        error: state.error ?? Exception(t.common.error),
        onRetry: notifier.load,
      );
    }

    final isFollowed = state.isFollowed;
    final currentCid = state.currentCid;
    final relatedVideos = state.relatedVideos;
    final isExpanded = useState(false);

    Future<void> openFavoritePicker() async {
      final isFavorite = await showVideoFavoritePicker(
        context: context,
        aid: detail.aid,
        onLogin: onLogin,
      );
      if (isFavorite == null || !context.mounted) {
        return;
      }
      notifier.setVideoFavoriteState(isFavorite: isFavorite);
    }

    useEffect(() {
      if (relatedVideos.isEmpty) {
        return null;
      }

      final screenWidth = MediaQuery.sizeOf(context).width;
      final containerWidth = screenWidth > AppBreakpoints.pageMaxWidth
          ? AppBreakpoints.pageMaxWidth
          : screenWidth;
      final itemWidth =
          (containerWidth - _relatedGridHorizontalPadding - _relatedGridColumnGap) /
          _relatedGridColumns;
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      AppNetworkImagePrefetcher.prefetch(
        context,
        specs: buildNetworkImagePrefetchSpecs(
          relatedVideos,
          count: relatedVideos.length,
          logicalWidth: itemWidth,
          aspectRatio: _relatedCoverAspectRatio,
          pixelRatio: pixelRatio,
          imageUrl: (video) => video.pic,
        ),
        limit: _relatedImagePrefetchLimit,
      );
      return null;
    }, [relatedVideos]);

    return _VideoInfoLoadedContent(
      detail: detail,
      isFollowed: isFollowed,
      currentCid: currentCid,
      relatedVideos: relatedVideos,
      isExpanded: isExpanded,
      onToggleFollow: notifier.toggleFollow,
      onLogin: onLogin,
      onOpenUser: onOpenUser,
      onOpenVideo: onOpenVideo,
      onLike: notifier.toggleVideoLike,
      onCoin: notifier.addVideoCoin,
      onFavorite: openFavoritePicker,
      onPartChanged: notifier.switchPart,
    );
  }
}

const int _relatedImagePrefetchLimit = 4;
const int _relatedGridColumns = 2;
const double _relatedGridHorizontalPadding = 32;
const double _relatedGridColumnGap = 10;
const double _relatedCoverAspectRatio = 16 / 10;

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
  final VoidCallback onFavorite;
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
    required this.onFavorite,
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
              onFavorite: onFavorite,
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
                return _RecommendationItem(
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

class _VideoInfoHeaderSection extends ConsumerWidget {
  final VideoDetailViewData detail;
  final bool isFollowed;
  final ValueNotifier<bool> isExpanded;
  final VoidCallback onToggleFollow;
  final VoidCallback onLogin;
  final ValueChanged<int> onOpenUser;

  const _VideoInfoHeaderSection({
    required this.detail,
    required this.isFollowed,
    required this.isExpanded,
    required this.onToggleFollow,
    required this.onLogin,
    required this.onOpenUser,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: UserListTile(
            avatarUrl: detail.owner.face,
            name: detail.owner.name,
            avatarSize: 30,
            padding: EdgeInsets.zero,
            onTap: () => onOpenUser(detail.owner.mid),
            trailing: FollowButton(
              isFollowed: isFollowed,
              width: 72,
              height: 28,
              onTap: () {
                final session = ref.read(currentUserProvider);
                if (!(session?.isLoggedIn ?? false)) {
                  onLogin();
                  return;
                }
                onToggleFollow();
              },
            ),
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
          child: _VideoStatsRow(detail: detail, showBvid: isExpanded.value),
        ),
        if (isExpanded.value) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _ExpandableDescriptionAndTags(
              description: detail.desc,
              tags: detail.tags,
            ),
          ),
        ],
      ],
    );
  }
}

class _VideoInfoEngagementSection extends StatelessWidget {
  final VideoDetailViewData detail;
  final int currentCid;
  final bool hasRecommendations;
  final VoidCallback onLike;
  final VoidCallback onCoin;
  final VoidCallback onFavorite;
  final ValueChanged<int> onPartChanged;

  const _VideoInfoEngagementSection({
    required this.detail,
    required this.currentCid,
    required this.hasRecommendations,
    required this.onLike,
    required this.onCoin,
    required this.onFavorite,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _VideoActionsRow(
          detail: detail,
          onLike: onLike,
          onCoin: onCoin,
          onFavorite: onFavorite,
        ),
        const SizedBox(height: 8),
        if (detail.pages.length > 1) ...[
          _VideoPartsSection(
            pages: detail.pages,
            currentCid: currentCid,
            onPartChanged: onPartChanged,
          ),
          const SizedBox(height: 10),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _VideoCollectionSummary(
            label: t.video.parts,
            title: detail.title,
            pageCount: detail.pages.length,
          ),
        ),
        const SizedBox(height: 14),
        Divider(
          height: 1,
          thickness: 0.5,
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
        if (hasRecommendations)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Text(
              t.video.recommend,
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  final VideoModel video;
  final ValueChanged<String> onOpenVideo;

  const _RecommendationItem({required this.video, required this.onOpenVideo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return VideoListCard(
      title: video.title,
      coverUrl: video.pic,
      duration: video.duration,
      viewCount: video.stat.view,
      danmakuCount: video.stat.danmaku,
      thumbnailWidth: 104,
      height: 66,
      padding: EdgeInsets.zero,
      flat: true,
      badge: video.rcmdReason.isNotEmpty
          ? AppTag(text: video.rcmdReason, fontSize: 11)
          : null,
      author: Text(
        video.owner.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
      ),
      onTap: () => onOpenVideo(video.bvid),
    );
  }
}

class _VideoStatsRow extends StatelessWidget {
  final VideoDetailViewData detail;
  final bool showBvid;

  const _VideoStatsRow({required this.detail, this.showBvid = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = theme.textTheme.labelSmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
    );
    final d = DateTime.fromMillisecondsSinceEpoch(detail.pubDate * 1000);
    final date = d.toIsoDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconText(
              icon: Icons.play_circle_outline_rounded,
              text: detail.stat.view.formatNumber,
            ),
            IconText(
              icon: Icons.subtitles_outlined,
              text: detail.stat.danmaku.formatNumber,
            ),
            Text(date, style: style),
          ],
        ),
        if (showBvid) ...[
          const SizedBox(height: 6),
          Text('BV${detail.bvid}', style: style),
        ],
      ],
    );
  }
}

class _ExpandableDescriptionAndTags extends HookWidget {
  final String description;
  final List<String> tags;

  const _ExpandableDescriptionAndTags({required this.description, required this.tags});

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = context.t;

    return AppClickable(
      onTap: () => isExpanded.value = !isExpanded.value,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CulculSpacing.sm,
          vertical: CulculSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(CulculRadius.sm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    description.isEmpty ? t.video.no_desc : description,
                    maxLines: isExpanded.value ? null : 1,
                    overflow: isExpanded.value ? null : TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      height: 1.45,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Icon(
                  isExpanded.value
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            if (isExpanded.value && tags.isNotEmpty) ...[
              const SizedBox(height: CulculSpacing.xs),
              Wrap(
                spacing: CulculSpacing.xs,
                runSpacing: CulculSpacing.xs,
                children: tags
                    .take(12)
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: CulculSpacing.sm,
                          vertical: CulculSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(CulculRadius.lg),
                        ),
                        child: Text(
                          tag,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _VideoActionsRow extends StatelessWidget {
  final VideoDetailViewData detail;
  final VoidCallback? onLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;

  const _VideoActionsRow({
    required this.detail,
    this.onLike,
    this.onCoin,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.thumb_up_alt_rounded,
              label: detail.stat.like.formatNumber,
              isSelected: detail.reqUser.like == 1,
              onTap: onLike,
            ),
          ),
          Expanded(
            child: _ActionButton(
              icon: Icons.thumb_down_alt_rounded,
              label: t.actions.unlike,
            ),
          ),
          Expanded(
            child: _ActionButton(
              icon: Icons.paid_rounded,
              label: detail.stat.coin.formatNumber,
              isSelected: detail.reqUser.coin > 0,
              onTap: onCoin,
            ),
          ),
          Expanded(
            child: _ActionButton(
              icon: Icons.star_rounded,
              label: detail.stat.favorite.formatNumber,
              isSelected: detail.reqUser.favorite == 1,
              onTap: onFavorite,
            ),
          ),
          Expanded(
            child: _ActionButton(
              icon: Icons.share_rounded,
              label: detail.stat.share.formatNumber,
              onTap: () {
                final url = 'https://www.bilibili.com/video/${detail.bvid}';
                SharePlus.instance.share(
                  ShareParams(text: '${detail.title}\n$url', subject: detail.title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AppClickable(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 8.5,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoPartsSection extends StatelessWidget {
  final List<VideoPartViewData> pages;
  final int currentCid;
  final ValueChanged<int> onPartChanged;

  const _VideoPartsSection({
    required this.pages,
    required this.currentCid,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                '${t.video.parts} (${pages.length})',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 46,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: pages.length,
            separatorBuilder: (context, index) => const SizedBox(width: 6),
            itemBuilder: (context, index) {
              final page = pages[index];
              final isSelected = page.cid == currentCid;
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: isSelected
                      ? colorScheme.primary.withValues(alpha: 0.08)
                      : colorScheme.surfaceContainerHighest.withValues(alpha: 0.42),
                  child: AppClickable(
                    onTap: () => onPartChanged(page.cid),
                    child: Container(
                      width: 112,
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          if (isSelected) ...[
                            Icon(
                              Icons.graphic_eq_rounded,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 5),
                          ],
                          Expanded(
                            child: Text(
                              page.part.isEmpty
                                  ? 'P${page.page}'
                                  : '${page.part} ${page.page}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _VideoCollectionSummary extends StatelessWidget {
  final String label;
  final String title;
  final int pageCount;

  const _VideoCollectionSummary({
    required this.label,
    required this.title,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final count = pageCount <= 0 ? 1 : pageCount;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.graphic_eq_rounded, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              '$label - $title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '1/$count',
            style: theme.textTheme.labelLarge?.copyWith(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
