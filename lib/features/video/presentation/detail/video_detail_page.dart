import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/features/video/presentation/player/hooks/use_video_orientation.dart';
import 'package:culcul/features/video/presentation/player/hooks/use_video_session.dart';
import 'package:culcul/features/video/presentation/comments/video_comments_view.dart';
import 'package:culcul/features/video/presentation/detail/info/video_info_view.dart';
import 'package:culcul/features/video/presentation/player/video_player_view.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoDetailPage extends HookConsumerWidget {
  final String bvid;
  final VoidCallback onLogin;
  final ValueChanged<int> onOpenUser;
  final ValueChanged<String> onOpenVideo;
  final OpenVideoCommentReplies onOpenCommentReplies;

  const VideoDetailPage({
    super.key,
    required this.bvid,
    required this.onLogin,
    required this.onOpenUser,
    required this.onOpenVideo,
    required this.onOpenCommentReplies,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = useVideoSession(ref, bvid);
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    final detailState = ref.watch(videoDetailControllerProvider(bvid));
    final videoDetail = detailState.videoDetail;
    final currentCid = detailState.currentCid;
    final isFullscreen = ref.watch(
      playerControllerProvider.select((value) => value.isFullscreen),
    );

    final toggleFullscreen = useVideoOrientation(
      ref,
      videoDetail: videoDetail,
      currentCid: currentCid,
    );
    final tabController = useTabController(initialLength: 2);
    final hasVisitedComments = useState(false);

    useEffect(() {
      void handleTabChanged() {
        if (!hasVisitedComments.value && tabController.index == 1) {
          hasVisitedComments.value = true;
        }
      }

      tabController.addListener(handleTabChanged);
      handleTabChanged();
      return () => tabController.removeListener(handleTabChanged);
    }, [tabController]);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: PopScope(
        canPop: !isFullscreen,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          toggleFullscreen();
        },
        child: SafeArea(
          top: !isFullscreen,
          bottom: !isFullscreen,
          left: !isFullscreen,
          right: !isFullscreen,
          child: Column(
            children: [
              VideoPlayerView(
                bvid: bvid,
                onToggleFullscreen: toggleFullscreen,
                sessionId: sessionId,
              ),
              if (!isFullscreen) ...[
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: 38,
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TabBar(
                              controller: tabController,
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              indicatorColor: colorScheme.primary,
                              indicatorWeight: 2.5,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: colorScheme.primary,
                              unselectedLabelColor: colorScheme.onSurfaceVariant,
                              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12.5,
                              ),
                              unselectedLabelStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.5,
                              ),
                              dividerColor: Colors.transparent,
                              tabs: [
                                Tab(text: t.video.tabs.info),
                                Tab(
                                  text: videoDetail?.stat.reply == null
                                      ? t.video.tabs.comment
                                      : '${t.video.tabs.comment} '
                                            '${videoDetail!.stat.reply.formatNumber}',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: colorScheme.outlineVariant.withValues(alpha: 0.7),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                              child: Icon(Icons.subtitles_outlined, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      VideoInfoView(
                        bvid: bvid,
                        onLogin: onLogin,
                        onOpenUser: onOpenUser,
                        onOpenVideo: onOpenVideo,
                      ),
                      hasVisitedComments.value
                          ? VideoCommentsView(
                              bvid: bvid,
                              onOpenUser: onOpenUser,
                              onOpenCommentReplies: onOpenCommentReplies,
                            )
                          : const SizedBox.expand(),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
