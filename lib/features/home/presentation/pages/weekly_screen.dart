import 'package:culcul/core/models/video_model_contract.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/home/data/home_repository_impl.dart';
import 'package:culcul/features/home/presentation/widgets/home_video_actions.dart';
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _weeklyListProvider = FutureProvider.autoDispose<List<VideoModel>>((ref) async {
  final result = await ref.watch(homeRepositoryImplProvider).fetchWeeklyList();
  return result.when(
    success: (data) => data,
    failure: (error) {
      DevLogger.log('feature', 'home.weekly_list.load_error', <String, Object?>{
        'error': error,
      });
      return const <VideoModel>[];
    },
  );
});

class WeeklyScreen extends ConsumerWidget {
  final ValueChanged<String> onOpenVideo;

  const WeeklyScreen({super.key, required this.onOpenVideo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyListAsync = ref.watch(_weeklyListProvider);
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.home.tabs.weekly_must_watch)),
      body: weeklyListAsync.when(
        data: (videos) {
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return PopularVideoCard(
                video: video,
                onTap: () => onOpenVideo(video.bvid),
                onLongPress: () => showHomeVideoActionsBottomSheet(
                  context,
                  ref,
                  bvid: video.bvid,
                  coverUrl: video.pic,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => AppErrorWidget(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.refresh(_weeklyListProvider),
        ),
      ),
    );
  }
}
