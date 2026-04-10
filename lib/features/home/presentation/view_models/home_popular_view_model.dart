// ignore_for_file: invalid_use_of_internal_member
import 'dart:async';

import 'package:culcul/shared/constants/api_constants.dart';
import 'package:culcul/shared/network/interceptors/cache_interceptor.dart';
import 'package:culcul/shared/perf/feature_flow_perf_logger.dart';
import 'package:culcul/shared/providers/cache_store_provider.dart';
import 'package:culcul/shared/pagination/paged_async_notifier.dart';
import 'package:culcul/features/home/home.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/presentation/view_models/home_video_paging_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_popular_view_model.g.dart';

@Riverpod(keepAlive: true)
class HomePopular extends _$HomePopular
    with OffsetPagedAsyncNotifier<HomeVideo>, HomeVideoPagingViewModel {
  @override
  Future<List<HomeVideo>> build() async {
    final stopwatch = Stopwatch()..start();
    final items = await buildFirstPage();
    final cacheKey = CacheInterceptor.buildCacheKey(ApiConstants.popular, {
      'pn': 1,
      'ps': 20,
    });
    final hasCachedValue = await ref.read(cacheStoreProvider).exists(cacheKey);
    FeatureFlowPerfLogger.log(
      chain: 'home.popular_feed',
      stage: 'initial_data',
      fields: <String, Object?>{
        'items': items.length,
        'cache_present': hasCachedValue,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );
    if (hasCachedValue && items.isNotEmpty) {
      unawaited(
        Future<void>.microtask(() => refreshFirstPageSilently(_fetchFreshFirstPage)),
      );
    }
    return items;
  }

  @override
  Future<List<HomeVideo>> fetchPage(int page) async {
    final result = await ref
        .read(homeRepositoryProvider)
        .fetchPopular(page: page, forceRefresh: isRefreshing);
    return result.dataOrNull ?? const <HomeVideo>[];
  }

  Future<List<HomeVideo>> _fetchFreshFirstPage() async {
    final stopwatch = Stopwatch()..start();
    final result = await ref
        .read(homeRepositoryProvider)
        .fetchPopular(page: 1, forceRefresh: true);
    final items = result.dataOrNull ?? const <HomeVideo>[];
    FeatureFlowPerfLogger.log(
      chain: 'home.popular_feed',
      stage: 'silent_refresh_fetch',
      fields: <String, Object?>{
        'items': items.length,
        'success': result.isSuccess,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );
    return items;
  }
}
