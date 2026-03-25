import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/profile/providers/user_space_extras_provider.dart';
import 'package:culcul/features/profile/presentation/widgets/home_tab/section_header.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StickyVideoSection extends ConsumerWidget {
  final int mid;
  const StickyVideoSection({super.key, required this.mid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stickyAsync = ref.watch(userStickyVideoProvider(mid));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return stickyAsync.when(
      data: (video) {
        if (video == null) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: '置顶视频'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 140,
                            height: 88,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AppNetworkImage(url: video.pic, fit: BoxFit.cover),
                                Positioned(
                                  bottom: 4,
                                  right: 4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.scrim.withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      FormatUtils.formatDuration(video.duration),
                                      style: TextStyle(
                                        color: colorScheme.onPrimary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                video.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.vertical_align_top_rounded,
                                          size: 12,
                                          color: colorScheme.primary,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          '置顶',
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      FormatUtils.formatTimeAgo(video.pubDate),
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  _StatIconText(
                                    icon: Icons.play_circle_outline_rounded,
                                    text: FormatUtils.formatNumber(video.stat.view),
                                  ),
                                  const SizedBox(width: 12),
                                  _StatIconText(
                                    icon: Icons.article_outlined,
                                    text: FormatUtils.formatNumber(video.stat.danmaku),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
      error: (error, stack) => const SliverToBoxAdapter(child: SizedBox.shrink()),
      loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}

class _StatIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _StatIconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7)),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
