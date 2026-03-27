import 'package:culcul/features/home/providers/weekly_provider.dart';
import 'package:culcul/features/home/presentation/widgets/popular_video_card.dart';
import 'package:culcul/i18n/strings.g.dart';
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
        data: (weeklyModel) {
          return ListView.builder(
            itemCount: weeklyModel.list.length,
            itemBuilder: (context, index) {
              final video = weeklyModel.list[index];
              return PopularVideoCard(video: video);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('${t.common.error}: $error')),
      ),
    );
  }
}

