import 'package:culcul/features/home/data/home_feed_data_source.dart';
import 'package:culcul/features/home/presentation/view_models/home_feed_paging_mixin.dart';
import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/perf/feature_flow_perf_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_recommend_view_model.g.dart';

@Riverpod(keepAlive: true)
class HomeRecommend extends _$HomeRecommend
    with OffsetPagedAsyncNotifier<VideoModel>, HomeFeedPagingMixin {
  @override
  Future<List<VideoModel>> build() {
    return buildFirstPageWithSilentRefresh(
      perfChain: 'home.recommend_feed',
      cachePath: ApiConstants.feedRcmd,
      cacheQuery: const <String, Object?>{
        'fresh_type': 4,
        'ps': 20,
        'fresh_idx': 1,
        'fresh_idx_1h': 1,
      },
      loadPage: _loadPage,
    );
  }

  @override
  Future<List<VideoModel>> fetchPage(int page) =>
      _loadPage(page, forceRefresh: isRefreshing);

  Future<List<VideoModel>> _loadPage(int page, {required bool forceRefresh}) async {
    final result = await ref
        .read(homeFeedDataSourceProvider)
        .fetchRecommendPage(page: page, forceRefresh: forceRefresh);
    if (forceRefresh) {
      FeatureFlowPerfLogger.log(
        chain: 'home.recommend_feed',
        stage: 'silent_refresh_result',
        fields: <String, Object?>{'success': result.isSuccess},
      );
    }
    return result.when(
      success: (data) => data,
      failure: (error) {
        debugPrint('Error loading recommend feed: $error');
        return const <VideoModel>[];
      },
    );
  }
}
