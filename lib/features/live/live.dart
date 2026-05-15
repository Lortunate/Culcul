import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/live/application/live_recommend_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

AsyncValue<List<LiveRoomSummary>> watchLiveRecommendations(WidgetRef ref) {
  return ref.watch(liveRecommendProvider);
}

LiveRecommend readLiveRecommendations(WidgetRef ref) {
  return ref.read(liveRecommendProvider.notifier);
}
