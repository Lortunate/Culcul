import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/presentation/widgets/home_tab/section_header.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MasterpieceSection extends HookConsumerWidget {
  final int mid;
  const MasterpieceSection({super.key, required this.mid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final repository = ref.watch(profileRepositoryProvider);
    final masterpieceFuture = useMemoized(() async {
      final result = await repository.getMasterpiece(mid);
      return result.dataOrNull ?? const [];
    }, [repository, mid]);
    final masterpieceAsync = useFuture(masterpieceFuture);

    final videos = masterpieceAsync.data ?? const [];
    if (videos.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: t.profile.home_tab.masterpiece),
          SizedBox(
            height: 180,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: videos.length,
              separatorBuilder: (c, i) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final video = videos[index];
                return GestureDetector(
                  onTap: () => ProfileNavigationScope.of(context).onOpenVideo(video.bvid),
                  child: SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VideoThumbnail(
                          url: video.pic,
                          duration: video.duration,
                          viewCount: video.stats.view,
                          danmakuCount: video.stats.danmaku,
                          borderRadius: 12,
                          width: 160,
                          height: 100,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            height: 1.3,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
