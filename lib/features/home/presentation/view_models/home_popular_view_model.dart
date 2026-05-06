import 'package:culcul/features/home/data/home_feed_data_source.dart';
import 'package:culcul/features/home/presentation/view_models/home_feed_paging_mixin.dart';
import 'package:culcul/shared/constants/api_constants.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/shared/pagination/paged_async_notifier.dart';
import 'package:culcul/core/perf/feature_flow_perf_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_popular_view_model.g.dart';

@Riverpod(keepAlive: true)
class HomePopular extends _$HomePopular
    with OffsetPagedAsyncNotifier<VideoModel>, HomeFeedPagingMixin {
  @override
  Future<List<VideoModel>> build() {
    return buildFirstPageWithSilentRefresh(
      perfChain: 'home.popular_feed',
      cachePath: ApiConstants.popular,
      cacheQuery: const <String, Object?>{'pn': 1, 'ps': 20},
      loadPage: _loadPage,
    );
  }

  @override
  Future<List<VideoModel>> fetchPage(int page) =>
      _loadPage(page, forceRefresh: isRefreshing);

  Future<List<VideoModel>> _loadPage(int page, {required bool forceRefresh}) async {
    final result = await ref
        .read(homeFeedDataSourceProvider)
        .fetchPopularPage(page: page, forceRefresh: forceRefresh);
    if (forceRefresh) {
      FeatureFlowPerfLogger.log(
        chain: 'home.popular_feed',
        stage: 'silent_refresh_result',
        fields: <String, Object?>{'success': result.isSuccess},
      );
    }
    return result.dataOrNull ?? const <VideoModel>[];
  }
}
