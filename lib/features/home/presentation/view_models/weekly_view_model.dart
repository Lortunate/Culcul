import 'package:culcul/features/home/data/home_feed_data_source.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_view_model.g.dart';

@riverpod
Future<List<VideoModel>> weeklyList(Ref ref) async {
  final result = await ref.watch(homeFeedDataSourceProvider).fetchWeeklyList();
  return result.dataOrNull ?? const <VideoModel>[];
}
