import 'dart:async';
import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/core/utils/format_utils.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:cilixili/data/models/home/index.dart';
import 'package:cilixili/data/models/video/index.dart';
import 'package:cilixili/features/video/reply/comment_reply_page.dart';
import 'package:cilixili/features/video/providers/video_detail_controller.dart';
import 'package:cilixili/features/video/widgets/bottom_input_bar.dart';
import 'package:cilixili/features/video/widgets/comment_item.dart';
import 'package:cilixili/features/video/widgets/player_controls.dart';
import 'package:cilixili/shared/widgets/index.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

const List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

class VideoDetailPage extends HookConsumerWidget {
  final String bvid;

  const VideoDetailPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoDetailControllerProvider(bvid));
    final notifier = ref.read(videoDetailControllerProvider(bvid).notifier);
    final player = useMemoized(() => Player());
    final controller = useMemoized(() => VideoController(player));

    useEffect(() {
      return player.dispose;
    }, [player]);

    final playUrl = state.playUrl;
    useEffect(() {
      if (playUrl != null && playUrl.durl.isNotEmpty) {
        final url = playUrl.durl.first.url;
        player.open(
          Media(
            url,
            httpHeaders: {
              'User-Agent':
                  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
              'Referer': 'https://www.bilibili.com/',
            },
          ),
          play: false,
        );
        if (state.playbackSpeed != 1.0) {
          player.setRate(state.playbackSpeed);
        }
      }
      return null;
    }, [playUrl, state.playbackSpeed]);

    double aspectRatio = 16 / 9;
    if (state.videoDetail != null) {
      final dim = state.videoDetail!.dimension;
      if (dim.width > 0 && dim.height > 0) {
        aspectRatio = dim.width / dim.height;
        if (aspectRatio < 0.5) aspectRatio = 0.5;
        if (aspectRatio > 2.5) aspectRatio = 2.5;
      }
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: _VideoPlayerSection(
                    controller: controller,
                    player: player,
                    isLoading:
                        state.isLoading &&
                        state.playUrl == null &&
                        state.error == null,
                    error: state.error,
                    onRetry: () => notifier.retry(),
                    aspectRatio: aspectRatio,
                    selectedQuality: state.selectedQuality,
                    availableQualities: state.availableQualities,
                    playbackSpeed: state.playbackSpeed,
                    onQualityChanged: (qn) => notifier.switchQuality(qn),
                    onSpeedChanged: (speed) => notifier.setPlaybackSpeed(speed),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyTabBarDelegate(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        border: Border(
                          bottom: BorderSide(
                            color: isDark
                                ? const Color(0xFF1F1F1F)
                                : const Color(0xFFEBEBEB),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TabBar(
                        labelColor: AppColors.primary,
                        unselectedLabelColor: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 3,
                          ),
                          insets: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: [
                          Tab(
                            text: Translations.of(context).video.tabs.info,
                            height: 48,
                          ),
                          Tab(
                            text:
                                Translations.of(context).video.tabs.comment +
                                (state.videoDetail != null
                                    ? ' ${FormatUtils.formatNumber(state.videoDetail!.stat.reply)}'
                                    : ''),
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                _VideoInfoView(
                  detail: state.videoDetail,
                  relatedVideos: state.relatedVideos,
                  currentCid: state.currentCid,
                  onPartChanged: (cid) => notifier.switchPart(cid),
                ),
                _VideoCommentsView(
                  bvid: bvid,
                  comments: state.comments,
                  totalCount: state.videoDetail?.stat.reply ?? 0,
                  sort: state.commentSort,
                  isLoading: state.isCommentLoading,
                  hasMore: state.hasMoreComments,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomInputBar(),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyTabBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _VideoPlayerSection extends HookWidget {
  final VideoController controller;
  final Player player;
  final bool isLoading;
  final Object? error;
  final VoidCallback onRetry;
  final double aspectRatio;
  final int selectedQuality;
  final List<int> availableQualities;
  final double playbackSpeed;
  final ValueChanged<int> onQualityChanged;
  final ValueChanged<double> onSpeedChanged;

  const _VideoPlayerSection({
    required this.controller,
    required this.player,
    required this.isLoading,
    required this.error,
    required this.onRetry,
    required this.aspectRatio,
    required this.selectedQuality,
    required this.availableQualities,
    required this.playbackSpeed,
    required this.onQualityChanged,
    required this.onSpeedChanged,
  });

  String _getQualityLabel(int quality) {
    return switch (quality) {
      125 => t.video.quality.p4k,
      120 => t.video.quality.p1080,
      112 => t.video.quality.p720,
      80 => t.video.quality.p480,
      64 => t.video.quality.p360,
      32 => t.video.quality.p240,
      16 => t.video.quality.p144,
      _ => '$quality',
    };
  }

  @override
  Widget build(BuildContext context) {
    final showControls = useState(false);
    final controlsTimer = useState<Timer?>(null);

    useEffect(() {
      return () => controlsTimer.value?.cancel();
    }, []);

    void showControlsOverlay() {
      showControls.value = true;
      controlsTimer.value?.cancel();
      controlsTimer.value = Timer(const Duration(seconds: 3), () {
        showControls.value = false;
      });
    }

    return Container(
      color: Colors.black,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          children: [
            if (error != null)
              Container(
                color: Colors.black,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.video.load_failed,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: onRetry,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                      child: Text(t.common.retry),
                    ),
                  ],
                ),
              )
            else
              GestureDetector(
                onTap: showControlsOverlay,
                child: Video(controller: controller),
              ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            GestureDetector(
              onTap: showControlsOverlay,
              child: PlayerControlsOverlay(
                isVisible: showControls.value,
                selectedQuality: selectedQuality,
                availableQualities: availableQualities,
                playbackSpeed: playbackSpeed,
                onClose: () => showControls.value = false,
                onQualityChanged: onQualityChanged,
                onSpeedChanged: onSpeedChanged,
                onFullscreenToggle: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeRight,
                  ]);
                },
                qualityLabels: {
                  120: '4K',
                  112: '1080P',
                  80: '720P',
                  64: '480P',
                  32: '360P',
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: AnimatedOpacity(
                opacity: showControls.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            if (availableQualities.isNotEmpty)
              Positioned(
                top: 12,
                right: 12,
                child: AnimatedOpacity(
                  opacity: showControls.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _getQualityLabel(selectedQuality),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoInfoView extends StatelessWidget {
  final VideoDetail? detail;
  final List<RelatedVideo> relatedVideos;
  final int currentCid;
  final ValueChanged<int> onPartChanged;

  const _VideoInfoView({
    required this.detail,
    required this.relatedVideos,
    required this.currentCid,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (detail == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final d = detail!;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        _UploaderInfoRow(owner: d.owner),
        const SizedBox(height: 16),
        SelectableText(
          d.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            height: 1.4,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _VideoMetaRow(detail: d),
        const SizedBox(height: 16),
        if (d.pages.length > 1) ...[
          _VideoPartsList(
            pages: d.pages,
            currentCid: currentCid,
            onPartChanged: onPartChanged,
          ),
          const SizedBox(height: 16),
        ],
        if (d.tag.isNotEmpty) ...[
          _VideoTagsSection(tags: d.tag),
          const SizedBox(height: 16),
        ],
        _ExpandableDescription(description: d.desc),
        const SizedBox(height: 16),
        _VideoActionsRow(stat: d.stat),
        const SizedBox(height: 24),
        Divider(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkSurface
              : AppColors.background,
          thickness: 1,
        ),
        if (relatedVideos.isNotEmpty) ...[
          AppSectionHeader(
            title: Translations.of(context).video.recommend,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          ...relatedVideos.map((video) => _RecommendationItem(video: video)),
        ],
        const SizedBox(height: 40),
      ],
    );
  }
}

class _UploaderInfoRow extends StatelessWidget {
  final Owner owner;

  const _UploaderInfoRow({required this.owner});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExtendedImage.network(
                owner.face,
                width: 44,
                height: 44,
                shape: BoxShape.circle,
                fit: BoxFit.cover,
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return Container(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      owner.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'UID: ${owner.mid}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: isDark ? Colors.grey[500] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            minimumSize: const Size(0, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            '+ ${t.video.actions.follow}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _VideoMetaRow extends StatelessWidget {
  final VideoDetail detail;

  const _VideoMetaRow({required this.detail});

  String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final style = theme.textTheme.labelSmall?.copyWith(
      fontSize: 13,
      color: isDark ? Colors.grey[500] : AppColors.textSecondary,
      height: 1.4,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _MetaItem(
              icon: Icons.play_circle_outline,
              label: FormatUtils.formatNumber(detail.stat.view),
              style: style,
            ),
            const SizedBox(width: 24),
            _MetaItem(
              icon: Icons.chat_bubble_outline,
              label: FormatUtils.formatNumber(detail.stat.danmaku),
              style: style,
            ),
            const SizedBox(width: 24),
            Text(_formatDate(detail.pubDate), style: style),
            const SizedBox(width: 24),
            SelectableText('BV${detail.bvid}', style: style),
          ],
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextStyle? style;

  const _MetaItem({required this.icon, required this.label, this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: style?.color),
        const SizedBox(width: 8),
        Text(label, style: style),
      ],
    );
  }
}

class _VideoPartsList extends StatelessWidget {
  final List<VideoPage> pages;
  final int currentCid;
  final ValueChanged<int> onPartChanged;

  const _VideoPartsList({
    required this.pages,
    required this.currentCid,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pages.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final page = pages[index];
          final isSelected = page.cid == currentCid;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onPartChanged(page.cid),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : isDark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(6),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.08),
                          width: 0.5,
                        ),
                ),
                child: Text(
                  'P${page.page} ${page.part.isEmpty ? '' : page.part}',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : isDark
                        ? Colors.white70
                        : Colors.black87,
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VideoTagsSection extends StatelessWidget {
  final List<VideoTag> tags;

  const _VideoTagsSection({required this.tags});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final validTags = tags.where((tag) => tag.tagName.isNotEmpty).toList();

    if (validTags.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.video.tags,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: validTags
                .map(
                  (tag) => Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            width: 0.8,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_offer_outlined,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              tag.tagName,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ExpandableDescription extends HookWidget {
  final String description;

  const _ExpandableDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isExpanded = useState(false);
    final descText = description.isEmpty ? t.video.no_desc : description;
    final isLong = descText.length > 60 || descText.contains('\n');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isExpanded.value)
            SelectableText(
              descText,
              style: TextStyle(
                height: 1.8,
                fontSize: 14,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.8)
                    : const Color(0xFF333333),
                letterSpacing: 0.2,
              ),
            )
          else
            Text(
              descText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                height: 1.8,
                fontSize: 14,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.8)
                    : const Color(0xFF333333),
                letterSpacing: 0.2,
              ),
            ),
          if (isLong) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => isExpanded.value = !isExpanded.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    isExpanded.value ? t.video.collapse : t.video.expand_all,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    isExpanded.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _VideoActionsRow extends StatelessWidget {
  final Stat stat;

  const _VideoActionsRow({required this.stat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.05),
            width: 0.5,
          ),
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.05),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppActionButton(
            icon: Icons.thumb_up_outlined,
            label: FormatUtils.formatNumber(stat.like),
          ),
          AppActionButton(
            icon: Icons.thumb_down_outlined,
            label: t.video.actions.unlike,
          ),
          AppActionButton(
            icon: Icons.monetization_on_outlined,
            label: FormatUtils.formatNumber(stat.coin),
          ),
          AppActionButton(
            icon: Icons.star_outline_rounded,
            label: FormatUtils.formatNumber(stat.favorite),
          ),
          AppActionButton(
            icon: Icons.share_outlined,
            label: FormatUtils.formatNumber(stat.share),
          ),
        ],
      ),
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  final RelatedVideo video;

  const _RecommendationItem({required this.video});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.push('/video/${video.bvid}');
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                child: VideoThumbnail(
                  url: video.pic,
                  duration: video.duration,
                  borderRadius: 8,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                        fontSize: 14,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${video.owner.name} • ${t.common.view_count(count: FormatUtils.formatNumber(video.stat.view))}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? Colors.grey[500]
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoCommentsView extends ConsumerWidget {
  final String bvid;
  final List<CommentItem> comments;
  final int totalCount;
  final int sort;
  final bool isLoading;
  final bool hasMore;

  const _VideoCommentsView({
    required this.bvid,
    required this.comments,
    required this.totalCount,
    required this.sort,
    required this.isLoading,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (comments.isEmpty && !isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 56,
              color: theme.textTheme.labelSmall?.color?.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 20),
            Text(
              t.video.comment_empty,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                ref.read(videoDetailControllerProvider(bvid).notifier).retry();
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              child: Text(
                t.common.refresh,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!isLoading &&
            hasMore &&
            notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 200) {
          ref
              .read(videoDetailControllerProvider(bvid).notifier)
              .loadMoreComments();
        }
        return false;
      },
      child: CustomScrollView(
        key: PageStorageKey<String>('comments_$bvid'),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppColors.darkSurface
                        : AppColors.background,
                    width: 1,
                  ),
                ),
              ),
              child: AppSectionHeader(
                title: t.video.all_comments,
                trailing: Row(
                  children: [
                    _SortButton(
                      label: t.video.comment_sort_hot,
                      isActive: sort == 1,
                      onTap: () => ref
                          .read(videoDetailControllerProvider(bvid).notifier)
                          .switchCommentSort(1),
                    ),
                    Container(
                      width: 1,
                      height: 12,
                      color: isDark ? Colors.white12 : Colors.black12,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    _SortButton(
                      label: t.video.comment_sort_time,
                      isActive: sort == 0,
                      onTap: () => ref
                          .read(videoDetailControllerProvider(bvid).notifier)
                          .switchCommentSort(0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return CommentItemWidget(
                item: comments[index],
                onTapReplies: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentReplyPage(
                        oid: comments[index].oid,
                        rootId: comments[index].rpid,
                        rootComment: comments[index],
                      ),
                    ),
                  );
                },
              );
            }, childCount: comments.length),
          ),
          if (isLoading)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SortButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = isActive
        ? AppColors.primary
        : (isDark ? Colors.grey[500] : Colors.grey[600]);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: color,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
