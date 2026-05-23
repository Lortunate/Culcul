import 'package:culcul/features/home/application/home_application_providers.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_view_model.g.dart';

@riverpod
Future<List<VideoModel>> weeklyList(Ref ref) async {
  final result = await ref.watch(homePortProvider).fetchWeeklyList();
  return result.when(
    success: (data) => data,
    failure: (error) {
      DevLogger.log('feature', 'home.weekly_list.load_error', <String, Object?>{
        'error': error,
      });
      return const <VideoModel>[];
    },
  );
}
