import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/data/dtos/related_video_dto.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/detail/info/uploader_section.dart';
import 'package:culcul/features/video/presentation/detail/info/video_actions.dart';
import 'package:culcul/features/video/presentation/detail/info/video_description.dart';
import 'package:culcul/features/video/presentation/detail/info/video_parts.dart';
import 'package:culcul/features/video/presentation/detail/info/video_recommendation.dart';
import 'package:culcul/features/video/presentation/detail/info/video_stats.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'video_info_view.engagement_section.dart';
part 'video_info_view.header_section.dart';
part 'video_info_view.loaded_content.dart';

class VideoInfoView extends HookConsumerWidget {
  final String bvid;

  const VideoInfoView({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = videoDetailControllerProvider(bvid);
    final state = ref.watch(
      provider.select(
        (state) => (
          isInitialLoading: state.videoDetail == null && state.isLoading,
          error: state.videoDetail == null ? state.error : null,
          detail: state.videoDetail,
          isFollowed: state.videoDetail?.reqUser?.attention == 1,
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

    useEffect(() {
      if (relatedVideos.isEmpty) {
        return null;
      }

      final screenWidth = MediaQuery.sizeOf(context).width;
      final containerWidth = screenWidth > AppBreakpoints.pageMaxWidth
          ? AppBreakpoints.pageMaxWidth
          : screenWidth;
      final itemWidth = (containerWidth - 32 - 10) / 2;
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      AppNetworkImagePrefetcher.prefetch(
        context,
        specs: relatedVideos
            .map(
              (video) => NetworkImagePrefetchSpec(
                url: video.pic,
                memCacheWidth: (itemWidth * pixelRatio).round(),
                memCacheHeight: (itemWidth / (16 / 10) * pixelRatio).round(),
              ),
            )
            .toList(growable: false),
        limit: 4,
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
      onLike: notifier.toggleVideoLike,
      onCoin: notifier.addVideoCoin,
      onPartChanged: notifier.switchPart,
    );
  }
}

class VideoCollectionSummary extends StatelessWidget {
  final String label;
  final String title;
  final int pageCount;

  const VideoCollectionSummary({
    super.key,
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
