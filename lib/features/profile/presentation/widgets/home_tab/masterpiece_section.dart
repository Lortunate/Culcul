import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_extras_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/home_tab/section_header.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MasterpieceSection extends ConsumerWidget {
  final int mid;
  const MasterpieceSection({super.key, required this.mid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final masterpieceAsync = ref.watch(userMasterpiecesProvider(mid));

    return masterpieceAsync.when(
      data: (videos) {
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
                      onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
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
                              aspectRatio: 16 / 10,
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
      },
      error: (error, stack) => const SliverToBoxAdapter(child: SizedBox.shrink()),
      loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}
