import 'package:culcul/features/home/data/home_repository_impl.dart';
import 'package:culcul/features/home/presentation/view_models/home_feed_paging_mixin.dart';
import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/perf/dev_logger.dart';
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
        .read(homeRepositoryImplProvider)
        .fetchPopularPage(page: page, forceRefresh: forceRefresh);
    if (forceRefresh) {
      DevLogger.log(
        'feature',
        'home.popular_feed.silent_refresh_result',
        <String, Object?>{'success': result.isSuccess},
      );
    }
    return result.when(
      success: (data) => data,
      failure: (error) {
        DevLogger.log('feature', 'home.popular_feed.load_error', <String, Object?>{
          'error': error,
        });
        return const <VideoModel>[];
      },
    );
  }
}
