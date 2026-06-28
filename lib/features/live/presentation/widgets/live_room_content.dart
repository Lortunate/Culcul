import 'package:culcul/features/live/presentation/widgets/danmaku/live_normal_message.dart';
import 'package:culcul/features/live/state/live_room_view_model.dart';
import 'package:culcul/features/live/state/live_danmaku_feed_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/theme/culcul_colors.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveRoomContent extends ConsumerWidget {
  final int roomId;

  const LiveRoomContent({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = liveRoomControllerProvider(roomId);
    final isLoading = ref.watch(provider.select((value) => value.isLoading));
    final error = ref.watch(provider.select((value) => value.error));
    final title = ref.watch(provider.select((value) => value.roomInfo?.title));

    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) {
      return Center(
        child: AppErrorWidget(
          error: error,
          onRetry: () => ref.read(liveRoomControllerProvider(roomId).notifier).refresh(),
        ),
      );
    }

    final colorScheme = Theme.of(context).colorScheme;
    final feed = ref.watch(liveDanmakuFeedControllerProvider(roomId));
    final history = feed.items;
    const listPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    const normalItemPadding = EdgeInsets.symmetric(vertical: 4);
    const systemItemPadding = EdgeInsets.symmetric(vertical: 6);

    return Column(
      children: [
        if (title != null && title.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 19,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        Expanded(
          child: Stack(
            children: [
              if (feed.isEnabled)
                RepaintBoundary(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: listPadding,
                    reverse: true,
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final item = history[index];
                      final isSystemMessage =
                          item.dmType == 3 ||
                          item.nickname == t.live.danmaku.system_notice;
                      final padding = isSystemMessage
                          ? systemItemPadding
                          : normalItemPadding;
                      final Widget child;
                      if (isSystemMessage) {
                        final theme = Theme.of(context);
                        final colorScheme = theme.colorScheme;
                        child = Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                          decoration: BoxDecoration(
                            color: colorScheme.scrim.withValues(alpha: 0.86),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: colorScheme.onPrimary.withValues(alpha: 0.08),
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.live.danmaku.system_notice_colon,
                                style: TextStyle(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.88,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.text,
                                style: TextStyle(
                                  color: colorScheme.onPrimary.withValues(alpha: 0.84),
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (item.dmType == 1) {
                        final colorScheme = Theme.of(context).colorScheme;
                        final semanticColors = context.semanticColors;
                        child = RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: item.nickname,
                                style: TextStyle(
                                  color: semanticColors.warning.withValues(alpha: 0.9),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5,
                                  height: 1.25,
                                ),
                              ),
                              TextSpan(
                                text: ' ${item.text}',
                                style: TextStyle(
                                  color: colorScheme.onPrimary.withValues(alpha: 0.72),
                                  fontSize: 12.5,
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (item.dmType == 2) {
                        final theme = Theme.of(context);
                        final colorScheme = theme.colorScheme;
                        child = Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            border: Border.all(
                              color: colorScheme.primary.withValues(alpha: 0.22),
                              width: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: item.nickname,
                                        style: TextStyle(
                                          color: colorScheme.primary.withValues(
                                            alpha: 0.95,
                                          ),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.5,
                                          height: 1.2,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ${item.text}',
                                        style: TextStyle(
                                          color: colorScheme.primary.withValues(
                                            alpha: 0.88,
                                          ),
                                          fontSize: 12.5,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        child = LiveNormalMessage(item: item);
                      }

                      return RepaintBoundary(
                        child: Padding(padding: padding, child: child),
                      );
                    },
                  ),
                )
              else
                const SizedBox.expand(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 32,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorScheme.scrim,
                          colorScheme.scrim.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
