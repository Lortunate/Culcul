import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/home/presentation/view_models/weekly_view_model.dart';
import 'package:culcul/features/home/presentation/widgets/home_video_actions.dart';
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeeklyScreen extends ConsumerWidget {
  const WeeklyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyListAsync = ref.watch(weeklyListProvider);
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
                onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
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
          onRetry: () => ref.refresh(weeklyListProvider),
        ),
      ),
    );
  }
}
